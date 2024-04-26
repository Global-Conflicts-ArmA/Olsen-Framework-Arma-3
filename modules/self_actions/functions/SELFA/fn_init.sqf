#include "script_component.hpp"
//IGNORE_PRIVATE_WARNING ["_player", "_target"]

player setVariable [QGVAR(originalSide), playerSide, true];

private _selfActionsMenu = ["SelfActionsMenu", "Self Actions", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _selfActionsMenu] call ace_interact_menu_fnc_addActionToObject;

//check own color interaction
if (GETMVAR(TeamColourCheck,false)) then {
	private _teamColor = ["colorCheck_class", "Check Team Colour", "", {
		private _str = switch (assignedTeam player) do {
			case "BLUE": {"You are in <br/><t color='#0000FF'>BLUE</t> team."};
			case "RED": {"You are in <br/><t color='#FF0000'>RED</t> team."};
			case "GREEN": {"You are in <br/><t color='#00FF00'>GREEN</t> team."};
			case "YELLOW": {"You are in <br/><t color='#FFFF00'>YELLOW</t> team."};
			default {"You are in <br/><t color='#FFFFFF'>WHITE</t> team."};
		};
        [_str] call EFUNC(FW,parsedTextDisplay);
	}, {!isNil {assignedTeam player}}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "SelfActionsMenu"], _teamColor] call ace_interact_menu_fnc_addActionToObject;
};

//share map interaction
if (GETMVAR(MapViewing,false)) then {
	private _shareMap = ["shareMap_class", "View Map", "", {
		params ["_target", "_player"];
		player linkItem "ItemMap";
		openMap true;
		[
			{!visibleMap || (_this select 0) distance (_this select 1) > 3},
			{
				openMap false;
				player unlinkItem "ItemMap";
			},
			[_target,_player]
		] call CBA_fnc_waitUntilAndExecute;
	}, {
		!("ItemMap" in assignedItems _player) &&
		{"ItemMap" in assignedItems _target} &&
		{_target distance _player <= 3} &&
		{((_player getVariable [QGVAR(OriginalSide), side _player]) isEqualTo (_target getVariable [QGVAR(OriginalSide), side _target]))}
	}] call ace_interact_menu_fnc_createAction;
	["Man", 0, ["ACE_SelfActions", "SelfActionsMenu"], _shareMap, true] call ace_interact_menu_fnc_addActionToClass;
};

//cut grass interaction
if (GETMVAR(GrassCutting,false)) then {
	private _machete = ["machete_class", "Cut Grass Small", "", {
        private _animation = ["AinvPknlMstpSnonWrflDr_medic1","AinvPknlMstpSnonWnonDr_medic1"] select (primaryWeapon player isEqualTo "");
        [_player, _animation] call ace_common_fnc_doAnimation;
        [4.7, [_player], {
            params ["_args"];
            _args params ["_player"];
            [_player, "", 2] call ace_common_fnc_doAnimation;
            private _cutter = createVehicle ["ClutterCutter_small_EP1", (player getPos [1, getDir player]), [], 0, "CAN_COLLIDE"];
        }, {
            params ["_args"];
            _args params ["_player"];
            [_player, "", 2] call ace_common_fnc_doAnimation;
        }, "Cutting Grass...", {
            params ["_args"];
            _args params ["_player"];
            (alive _player && {speed _player <= 2})
        }, ["isNotInside", "isNotSwimming"]] call ace_common_fnc_progressBar;
	}, {stance player isEqualTo "CROUCH"}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "SelfActionsMenu"], _machete] call ace_interact_menu_fnc_addActionToObject;
    if (GETMVAR(GrassCuttingLarge,false)) then {
        private _macheteB = ["machete_class", "Cut Grass Large", "", {
            private _animation = ["AinvPknlMstpSnonWrflDr_medic5","AinvPknlMstpSnonWnonDr_medic5"] select (primaryWeapon player isEqualTo "");
            [_player, _animation] call ace_common_fnc_doAnimation;
            [9, [_player], {
                params ["_args"];
                _args params ["_player"];
                [_player, "", 2] call ace_common_fnc_doAnimation;
                private _cutter = createVehicle ["ClutterCutter_small_EP1", getPos player, [], 0, "CAN_COLLIDE"];
                [45, 135, 225, 315] apply {
                    private _pos = player getPos [3.2, _x];
                    private _cutter = createVehicle ["ClutterCutter_small_EP1", _pos, [], 0, "CAN_COLLIDE"];
                };
            }, {
                params ["_args"];
                _args params ["_player"];
                [_player, "", 2] call ace_common_fnc_doAnimation;
            }, "Cutting Grass...", {
                params ["_args"];
                _args params ["_player"];
                (alive _player && {speed _player <= 2})
            }, ["isNotInside", "isNotSwimming"]] call ace_common_fnc_progressBar;
    	}, {stance player isEqualTo "CROUCH"}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "SelfActionsMenu"], _macheteB] call ace_interact_menu_fnc_addActionToObject;
    };
};

if (GETMVAR(SipDrink,false)) then {
    private _sipPath = getMissionPath "modules\self_actions\res\sounds\sipAh.ogg";
    private _drink = "Franta";
    private _drinkClass = "ACE_Can_Franta";
    private _drinkVehicle = "Land_Can_V2_F";

    private _sipAction = ["boomer_class","Take a sip of " + _drink, "", {
        params ["_target", "_player", "_params"];
        _params params ["_sipPath"];
        private _stanceIndex = ["STAND", "CROUCH", "PRONE"] find stance _player;
        private _consumeAnim = ["ace_field_rations_drinkStandCan", "ace_field_rations_drinkCrouchCan", "ace_field_rations_drinkProneCan"] select _stanceIndex;
        private _canHold = createVehicle ["Land_Can_V2_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _canHold attachTo [player, [-0.01, -0.08, -0.03], "righthandmiddle1", true];
        _canHold setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];
        [_player, _consumeAnim] call ACE_common_fnc_doAnimation;
        [{
            params ["_sipPath", "_player"];
            playSound3D [_sipPath, _player];
        }, [_sipPath, _player], 1.4] call CBA_fnc_waitAndExecute;
        [2.9, [_player, _canHold], {
            params ["_args"];
            _args params ["_player", "_canHold"];
            [_player, "", 2] call ace_common_fnc_doAnimation;
            if (GETMVAR(SipDrinkRequireItem,false)) then {
                [_player, "ACE_Can_Franta"] call CBA_fnc_removeItem;
            };
            private _pos = _player getpos [1.3, getdir _player];
            deleteVehicle _canHold;
            private _can = createVehicle ["Land_Can_Dented_F", [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"];
        }, {
            params ["_args"];
            _args params ["_player", "_canHold"];
            deleteVehicle _canHold;
            [_player, "", 2] call ace_common_fnc_doAnimation;
        }, "Taking a sip", {
            params ["_args"];
            _args params ["_player"];
            (
                alive _player &&
                {speed _player <= 2} &&
                {
                    !(GETMVAR(SipDrinkRequireItem,false)) || [_player, "ACE_Can_Franta"] call ace_common_fnc_hasItem
                }
            )
        }, ["isNotInside", "isNotSwimming"]] call ace_common_fnc_progressBar;
    }, {
        !(GETMVAR(SipDrinkRequireItem,false)) || [_player, "ACE_Can_Franta"] call ace_common_fnc_hasItem
    }, {}, [_sipPath]] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "SelfActionsMenu"], _sipAction] call ace_interact_menu_fnc_addActionToObject;
};
