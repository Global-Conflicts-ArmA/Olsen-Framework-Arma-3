#include "script_component.hpp"

if (GETPLVAR(Spectating,false)) exitWith {};

SETPLPVAR(Dead,true); //Tells the framework the player is dead
SETPLPVAR(Spectating,true); //Player is now spectating
SETMVAR(Spectating,true); //set local global var to spectating
[player, true] remoteExecCall ["hideObject", 0];
[player, true] remoteExecCall ["hideObjectGlobal", 2];

[player] call FUNC(freezeUnit);

QGVAR(respawnBlackScreen) cutText ["\n","BLACK IN", 5];
[QGVAR(death), 0, false] call ace_common_fnc_setHearingCapability;
0 fadeSound 1;

player call FUNC(RemoveAllGear);
player addWeapon "itemMap";

player setPos [0, 0, 0];
private _side = side player;
private _specGroup = switch _side do {
    case west: {
        private _tempGroup = GETMVAR((DOUBLES(spectateGroup,west)),grpNull);
        if (_tempGroup isEqualTo grpNull) then {
            _tempGroup = createGroup west;
            _tempGroup setGroupIdGlobal ["Spectators"];
            SETMVAR((DOUBLES(spectateGroup,west)),_tempGroup);
        };
        _tempGroup
    };
    case east: {
        private _tempGroup = GETMVAR((DOUBLES(spectateGroup,east)),grpNull);
        if (_tempGroup isEqualTo grpNull) then {
            _tempGroup = createGroup east;
            _tempGroup setGroupIdGlobal ["Spectators"];
            SETMVAR((DOUBLES(spectateGroup,east)),_tempGroup);
        };
        _tempGroup
    };
    case independent: {
        private _tempGroup = GETMVAR((DOUBLES(spectateGroup,independent)),grpNull);
        if (_tempGroup isEqualTo grpNull) then {
            _tempGroup = createGroup independent;
            _tempGroup setGroupIdGlobal ["Spectators"];
            SETMVAR((DOUBLES(spectateGroup,independent)),_tempGroup);
        };
        _tempGroup
    };
    case civilian: {
        private _tempGroup = GETMVAR((DOUBLES(spectateGroup,civilian)),grpNull);
        if (_tempGroup isEqualTo grpNull) then {
            _tempGroup = createGroup civilian;
            _tempGroup setGroupIdGlobal ["Spectators"];
            SETMVAR((DOUBLES(spectateGroup,civilian)),_tempGroup);
        };
        _tempGroup
    };
    default {
        grpNull
    };
};
[player] joinSilent _specGroup;

[true] call acre_api_fnc_setSpectator;
//If babel is enabled, allowed spectator to hear all languages present in mission.
if (GETMVAR(ACRE_Enable_Babel,false)) then {
    private _missionLanguages = [];
    GVAR(ACRE_All_Languages) apply {
        _x params ["_short", "_long"];
        _missionLanguages pushBackUnique _short;
    };
    _missionLanguages call acre_api_fnc_babelSetSpokenLanguages;
};

//we set default pos in case all methods fail and we end up with 0,0,0
private _pos = [2000, 2000, 100];
private _dir = 0;

if ((getMarkerColor GVAR(eg_spectator_marker)) isEqualTo "") then {
    if !(GETMVAR(killcam_body,objnull) isEqualTo objnull) then {
        //set camera pos on player body
        _pos = [(getpos GVAR(killcam_body)) select 0, (getpos GVAR(killcam_body)) select 1, ((getposATL GVAR(killcam_body)) select 2)+1.2];
        _dir = getDir GVAR(killcam_body);
    };
} else {
    _pos = getmarkerpos GVAR(eg_spectator_marker);
};

if (abs(_pos select 0) < 2 && abs(_pos select 1) < 2) then {
    _pos = [2000, 2000, 100];
};

["Initialize",
    [
        player,
        GVAR(eg_Whitelisted_Sides),
        GVAR(eg_Ai_Viewed_By_Spectator),
        GVAR(eg_Free_Camera_Mode_Available),
        GVAR(eg_Third_Person_Perspective_Camera_mode_Available),
        GVAR(eg_Show_Focus_Info_Widget),
        GVAR(eg_Show_Camera_Buttons_Widget),
        GVAR(eg_Show_Controls_Helper_Widget),
        GVAR(eg_Show_Header_Widget),
        GVAR(eg_Show_Entities_And_Locations_Lists)
    ]
] call BIS_fnc_EGSpectator;

private _cam = missionNamespace getVariable ["BIS_EGSpectatorCamera_camera", objNull];

if !(_cam isEqualTo objNull) then {
    [{!isNull (findDisplay 60492)}, {
            GVAR(eg_keyHandle) = (findDisplay 60492) displayAddEventHandler ["keyDown", {call FUNC(eg_keyHandler);}];
            GVAR(eg_keyHandle2) = (findDisplay 46) displayAddEventHandler ["keyDown", {call FUNC(eg_keyHandler2)}];
    }, []] call CBA_fnc_waitUntilAndExecute;

    if (GETMVAR(killcam_active,true)) then {
        SETMVAR(killcam_toggle,false);
        //this cool piece of code adds key handler to spectator display
        //it takes some time for display to create, so we have to delay it.
        [{!isNull (findDisplay 60492)}, {
            GVAR(killcam_keyHandle) = (findDisplay 60492) displayAddEventHandler ["keyDown", {call FUNC(killcam_toggleFnc);}];
        }, []] call CBA_fnc_waitUntilAndExecute;

        if !((GETMVAR(killcam_killer,objnull)) isEqualTo objnull) then {
            GVAR(killcam_distance) = GVAR(killcam_killer) distance GVAR(killcam_body);
            _pos = _pos getPos [-1.8, (GVAR(killcam_body) getDir GVAR(killcam_killer))];
            _cam setposATL _pos;

            //vector magic
            private _temp1 = ([getposASL _cam, getposASL GVAR(killcam_killer)] call BIS_fnc_vectorFromXToY);
            private _temp = (_temp1 call CBA_fnc_vect2Polar);

            //we check if camera is not pointing up, just in case
            if (abs(_temp select 2) > 89) then {_temp set [2, 0]};
            [_cam, [_temp select 1, _temp select 2]] call BIS_fnc_setObjectRotation;
        } else {
            _cam setposATL _pos;
            _cam setDir _dir;
        };

        GVAR(killcam_texture) = "a3\ui_f\data\gui\cfg\debriefing\enddeath_ca.paa";

        GVAR(killcam_drawHandle) = addMissionEventHandler ["Draw3D", {
            //we don't draw hud unless we toggle it by keypress
            if (GETMVAR(killcam_toggle,false)) then {
              private _killIconColour = [1,0,0,1];

                if ((GETMVAR(killcam_killer_pos,[ARR_3(0,0,0)])) isEqualTo [0,0,0]) then {
                    QGVAR(respawnMessagesLayer) cutText ["killer info unavailable", "PLAIN DOWN"];
                    SETMVAR(killcam_toggle,true);
                    drawIcon3D [GVAR(killcam_texture), _killIconColour, GVAR(killcam_unit_pos), 0.7, 0.7, 0, "You", 1, 0.04, "PuristaMedium"];
                } else {
                    private _u = GVAR(killcam_unit_pos);
                    private _k = GVAR(killcam_killer_pos);
                    if ((_u distance _k) < 2000) then {
                        //TODO do it better
                        drawLine3D [[(_u select 0)+0.01, (_u select 1)+0.01, (_u select 2)+0.01], [(_k select 0)+0.01, (_k select 1)+0.01, (_k select 2)+0.01], [1,0,0,1]];
                        drawLine3D [[(_u select 0)-0.01, (_u select 1)-0.01, (_u select 2)-0.01], [(_k select 0)-0.01, (_k select 1)-0.01, (_k select 2)-0.01], [1,0,0,1]];
                        drawLine3D [[(_u select 0)-0.01, (_u select 1)+0.01, (_u select 2)-0.01], [(_k select 0)-0.01, (_k select 1)+0.01, (_k select 2)-0.01], [1,0,0,1]];
                        drawLine3D [[(_u select 0)+0.01, (_u select 1)-0.01, (_u select 2)+0.01], [(_k select 0)+0.01, (_k select 1)-0.01, (_k select 2)+0.01], [1,0,0,1]];
                    };
                    if !((GETMVAR(killcam_killer,objnull)) isEqualTo objnull) then {
                        private _killerName = name GVAR(killcam_killer);
                        drawIcon3D [GVAR(killcam_texture), _killIconColour, [eyePos GVAR(killcam_killer) select 0, eyePos GVAR(killcam_killer) select 1, (ASLtoAGL eyePos GVAR(killcam_killer) select 2) + 0.4], 0.7, 0.7, 0, _killerName + ", " + (str round GVAR(killcam_distance)) + "m", 1, 0.04, "PuristaMedium"];
                    };
                };
            };
        }];
    } else {
        _pos = _pos getPos [-2, _dir];
        _cam setposATL _pos;
        _cam setDir _dir;
    };
};

private _killcam_msg = if (GETMVAR(killcam_active,true)) then {
    "Press <t color='#FFA500'>K</t> to toggle indicator showing location where you were killed from.<br/>";
} else {""};
private _text = format ["<t size='0.5' color='#ffffff'>%1
Close spectator HUD by pressing <t color='#FFA500'>CTRL+H</t>.<br/>
Press <t color='#FFA500'>SHIFT</t>, <t color='#FFA500'>ALT</t> or <t color='#FFA500'>SHIFT+ALT</t> to modify camera speed. Open map by pressing <t color='#FFA500'>M</t> and click anywhere to move camera to that postion.<br/>
Spectator controls can be customized in game <t color='#FFA500'>options->controls->'Camera'</t> tab.</t>", _killcam_msg];

[_text, 0.55, 0.8, 20, 1] spawn BIS_fnc_dynamicText;

GVAR(SpectatePFH) = [{
    params ["_args", "_idPFH"];
    if !(GETVAR(player,Spectating,false)) exitWith {
        [player] call FUNC(thawUnit);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    player setOxygenRemaining 1;
}, 0.25, []] call CBA_fnc_addPerFrameHandler;
