#include "script_macros.hpp"

#define preInitClient

// Debug settings
GVAR(debugMessagesEnabled) = ([missionConfigFile >> QGVAR(debugSettings) >> "debugMessagesEnabled", "number", 1] call CBA_fnc_getConfigEntry) == 1;

// Start on Safe settings
GVAR(StartOnSafe) = ([missionConfigFile >> QGVAR(clientSettings) >> "StartOnSafe" >> "enabled", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(StartOnSafe_Lowered) = ([missionConfigFile >> QGVAR(clientSettings) >> "StartOnSafe" >> "lowered", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(StartOnSafe_Unloaded) = ([missionConfigFile >> QGVAR(clientSettings) >> "StartOnSafe" >> "unloaded", "number", 0] call CBA_fnc_getConfigEntry) == 1;

// General Settings
GVAR(clientViewDistance) = [missionConfigFile >> QGVAR(clientSettings) >> "viewDistance", "number", 2500] call CBA_fnc_getConfigEntry;
GVAR(respawnTickets) = [missionConfigFile >> QGVAR(clientSettings) >> "respawnTickets", "number", 0] call CBA_fnc_getConfigEntry;

if (([missionConfigFile >> QGVAR(clientSettings) >> "forceTerrainGrid", "number", 0] call CBA_fnc_getConfigEntry) == 1) then {
    GVAR(terrainGridValue) = [missionConfigFile >> QGVAR(clientSettings) >> "terrainGridValue", "number", 3.125] call CBA_fnc_getConfigEntry;
    if (GVAR(terrainGridValue) > 50) then {
        GVAR(terrainGridValue) = 50;
    } else {
        if (GVAR(terrainGridValue) > 3.125) then {
            GVAR(terrainGridValue) = 3.125;
        };
    };
    [] call FUNC(forceTerrainGrid);
};

GVAR(eg_whitelisted_sides) = if (([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "viewAllSides", "number", 1] call CBA_fnc_getConfigEntry) == 1) then {
    [west, east, independent, civilian]
} else {
    []
};
GVAR(eg_ai_viewed_by_spectator) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "viewAI", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_free_camera_mode_available) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "freeCamera", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_third_person_perspective_camera_mode_available) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "thirdPersonCamera", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(Show_Focus_Info_widget) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "showInfo", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_show_camera_buttons_widget) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "showCameraButtons", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_show_controls_helper_widget) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "showControls", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_show_header_widget) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "showHeader", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_show_Entities_and_locations_lists) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "showEntitiesList", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_spectator_marker) = [missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "showEntitiesList", "string", ""] call CBA_fnc_getConfigEntry;
GVAR(killcam_active) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "killCam", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(eg_instant_death) = ([missionConfigFile >> QGVAR(clientSettings) >> "Spectator" >> "instantDeath", "number", 1] call CBA_fnc_getConfigEntry) == 1;


if (GETMVAR(SpectateBriefing,true)) then {

	#define NEWTAB(NAME) _briefing set [count _briefing, ["Diary",[NAME,"
	#define ENDTAB "]]];

	GVAR(allBriefings) = [];

	private _briefing = [];
	#include "..\customization\briefings\blufor.sqf"
	private _westBriefing = _briefing;

	_briefing = [];
	#include "..\customization\briefings\opfor.sqf"
	private _eastBriefing = _briefing;

	_briefing = [];
	#include "..\customization\briefings\indfor.sqf"
	private _indBriefing = _briefing;

	_briefing = [];
	#include "..\customization\briefings\civilian.sqf"
	private _civBriefing = _briefing;

	_briefing = [];
	#include "..\customization\briefings\missionNotes.sqf"
	private _missionNotes = _briefing;

	_briefing = [];
	#include "..\customization\briefings\changelog.sqf"
	private _changelog = _briefing;

	[_westBriefing, _eastBriefing, _indBriefing, _civBriefing, _missionNotes, _changelog] apply {
		private _tempEntry = [];
		_x apply {
			(_x select 1) params ["_name", "_text"];
			_text = _text call FUNC(parseBriefing);
			_tempEntry pushBack [_name, _text];
		};
		GVAR(allBriefings) pushBack _tempEntry;
	};
};

[{!isNull ace_player},{
	SETMVAR(SpawnPos,getPosATL player);
}] call CBA_fnc_waitUntilAndExecute;

//QGVAR(EndMission) player event sends the received variables to the end screen
GVAR(EndMissionEh) = [QGVAR(EndMission), {_this call FUNC(EndScreen)}] call CBA_fnc_addEventHandler;

GVAR(eg_keyHandler_display_hidden) = false;

#define DIK_APOSTROPHE 0x28

FUNC(killcam_toggleFnc) = {
    //37 is DIK code for K
    if ((_this select 1) == 37) then {
        if (GETMVAR(killcam_toggle,false)) then {
            GVAR(killcam_toggle) = false;
        } else {
            GVAR(killcam_toggle) = true;
        };
    };
};

FUNC(eg_keyHandler) = {
    params ["_control", "_code", "_shift", "_control", "_alt"];
    private _acre = ["ACRE2", "HeadSet"] call CBA_fnc_getKeybind;
    if !(isNil "_acre") then {
        private _action = _acre select 4;
        private _keys = _acre select 5;
        if ((_code == _keys select 0) && {(_keys select 1) isEqualTo [_shift, _control, _alt]}) then {
            call _action;
        };
    };
    if (_code == 35 && {!_shift} && {_control} && {!_alt}) then {
        if !(GETMVAR(eg_keyHandler_display_hidden,false)) then {
            (findDisplay 60492) closedisplay 1;
            GVAR(eg_keyHandler_display_hidden) = true;
        };
    };
};

FUNC(eg_keyHandler2) = {
    params ["_control", "_code", "_shift", "_control", "_alt"];
    if (_code == 35 && {!_shift} && {_control} && {!_alt} &&
    {GETMVAR(eg_keyHandler_display_hidden,false)}
    ) then {
        ([] call BIS_fnc_displayMission) createDisplay "RscDisplayEGSpectator";
        SETMVAR(eg_keyHandler_display_hidden,false);
        GVAR(eg_keyHandle) = (findDisplay 60492) displayAddEventHandler ["keyDown", {call FUNC(eg_keyHandler);}];
        if (GETMVAR(killcam_active,false)) then {
            GVAR(killcam_keyHandle) = (findDisplay 60492) displayAddEventHandler ["keyDown", {call FUNC(killcam_toggleFnc);}];
        };
    };
};

[QGVAR(eventPlayerRespawned), {
    QGVAR(respawnBlackScreen) cutText ["\n","BLACK IN", 5];
	[QGVAR(death), 0, false] call ace_common_fnc_setHearingCapability;
	0 fadeSound 1;
	private _loadout = (player getVariable [QGVAR(Loadout), ""]);
	if (_loadout isNotEqualTo "") then {
		[player, _loadout] call FUNC(GearScript);
	};
    private _customRespawn = missionNamespace getVariable [QGVAR(CustomRespawnPoint), [0,0,0]];
    if (_customRespawn isNotEqualTo [0,0,0]) then {
        player setPosATL _customRespawn;
    } else {
        private _respawnName = switch (side player) do {
            case west: {"fw_west_respawn"};
            case east: {"fw_east_respawn"};
            case independent: {"fw_ind_respawn"};
            case civilian: {"fw_civ_respawn"};
            default {""};
        };
    	private _respawnPoint = missionNamespace getVariable [_respawnName, objNull];
        if (_respawnPoint isNotEqualTo objnull) then {
    		player setPosATL getPosATL _respawnPoint;
    	} else {
            ERROR_MSG_1("respawn marker not found for side!",_respawnName);
            player setPosATL (GETMVAR(spawnPos,[ARR_3(0,0,0)]));
        };
    };
    player setVariable [QGVAR(Body), player, true];
    player setVariable [QGVAR(HasDied), false, true];
    player setVariable [QGVAR(Dead), false, true];
	[QGVAR(respawnEvent), [player]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(eventCheckRespawnTickets_Response), {
    params [
        ["_mode", "C_UNLIMITED", [""]],
        ["_teamTickets", 0, [0]]
    ];
    TRACE_2("",_mode,_teamTickets);
    switch _mode do {
        // team tickets are unlimited and individual tickets are unlimited
        case "C_UNLIMITED": {
            private _message = "You have unlimited respawns.";
            [{
                [_this, true, 5, 100] call ace_common_fnc_displayText
            }, _message, 1] call CBA_fnc_waitAndExecute;
            [QGVAR(eventPlayerRespawned)] call CBA_fnc_localEvent;
        };
        // team tickets are unlimited and individual tickets are limited
        case "C_LIMITED": {
            private _newValue = (GVAR(RespawnTickets) - 1) max 0;
            SETMVAR(RespawnTickets,_newValue);
            private _message = switch _newValue do {
                case 0: {
                    "You have no tickets left, you will not be able to respawn"
                };
                case 1: {
                    "You have 1 ticket left, you can respawn one more time"
                };
                default {
                    format ['You have %1 tickets left, you can respawn %1 times', _newValue];
                };
            };
            [{
                [_this, true, 5, 100] call ace_common_fnc_displayText
            }, _message, 1] call CBA_fnc_waitAndExecute;
            [QGVAR(eventPlayerRespawned)] call CBA_fnc_localEvent;
        };
        // team tickets are used up!
        case "TEAM_ZERO": {
            [] call FUNC(StartSpectator);
            [QGVAR(eventPlayerRespawned)] call CBA_fnc_localEvent;
        };
        // team tickets are limited and individual tickets are unlimited
        case "TEAM_LIMITED": {
            private _message = switch _teamTickets do {
                case 0: {
                    "Your side has no tickets left, you can not respawn"
                };
                case 1: {
                    "Your side has 1 ticket left, you can respawn one more time"
                };
                default {
                    format ['Your side has %1 tickets left, you can respawn %1 times', _teamTickets];
                };
            };
            [{
                [_this, true, 5, 100] call ace_common_fnc_displayText
            }, _message, 1] call CBA_fnc_waitAndExecute;
            [QGVAR(eventPlayerRespawned)] call CBA_fnc_localEvent;
        };
        // team tickets are limited and individual tickets are limited
        case "BOTH LIMITED": {
            private _newValue = (GVAR(RespawnTickets) - 1) max 0;
            SETMVAR(RespawnTickets,_newValue);
            private _message = if (_newValue isEqualTo 0) then {
                "You have no individual tickets left, you can not respawn";
            } else {
                private _returnMain = switch _teamTickets do {
                    case 0: {
                        "Your side has no tickets left, you can not respawn"
                    };
                    case 1: {
                        "Your side has 1 ticket left, you can respawn one more time";
                    };
                    default {
                        private _return = if (_newValue isEqualTo 1) then {
                            format ['You have 1 individual ticket left and your team has %1 tickets left, you can respawn one more time', _teamTickets]
                        } else {
                            private _return2 = if (_newValue >= _teamTickets) then {
                                format ['You have %1 individual tickets left and your team has %2 tickets left, you can respawn %2 times', _newValue, _teamTickets]
                            } else {
                                format ['You have %1 individual tickets left and your team has %2 tickets left, you can respawn %1 times', _newValue, _teamTickets]
                            };
                            _return2
                        };
                        _return
                    };
                };
                _returnMain
            };
            [{
                [_this, true, 5, 100] call ace_common_fnc_displayText
            }, _message, 1] call CBA_fnc_waitAndExecute;
            [QGVAR(eventPlayerRespawned)] call CBA_fnc_localEvent;
        };
    };
}] call CBA_fnc_addEventHandler;

GVAR(CheckingCoC) = false;

[QGVAR(responseCOEvent), {
    params [["_co", objNull, [objNull]], ["_var", "", [""]]];
    TRACE_2("client response for CO",_co,_var);
    missionNamespace setVariable [_var, _co];
    GVAR(CheckingCoC) = false;
}] call CBA_fnc_addEventHandler;

[QGVAR(triggeredRespawn), {
    params [
        ["_side", sideEmpty, [sideEmpty]],
        ["_condition", {true}, [{}]],
        ["_newIndividualTickets", 0, [0]]
    ];
    if (
        (_side isEqualTo sideEmpty ||
        {playerSide isEqualTo _side}) &&
        {GETPLVAR(spectating,false)} &&
        {_condition}
    ) then {
        if (_newIndividualTickets > 0) then {
            TRACE_2("Setting new individual ticket value",(GVAR(RespawnTickets)),_newIndividualTickets);
            GVAR(RespawnTickets) = _newIndividualTickets;
        };
        [] call FUNC(endSpectator);
    };
}] call CBA_fnc_addEventHandler;

#include "..\customization\inits\PreInitClient.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
