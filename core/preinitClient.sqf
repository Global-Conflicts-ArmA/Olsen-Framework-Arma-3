#include "script_macros.hpp"

#define preInitClient

#include "..\customization\clientSettings.sqf" //DO NOT REMOVE

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
	SETMVAR(SpawnPos,getpos player);
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
    params [["_respawnType", 0, [0]]];

    cutText ["\n","BLACK IN", 5];
	[QGVAR(death), 0, false] call ace_common_fnc_setHearingCapability;
	0 fadeSound 1;

	private _respawnName = switch (side player) do {
        case west: {"fw_west_respawn"};
        case east: {"fw_east_respawn"};
        case independent: {"fw_ind_respawn"};
        case civilian: {"fw_civ_respawn"};
        default {""};
    };
	private _respawnPoint = missionNamespace getVariable [_respawnName, objNull];
	private _loadout = (player getVariable [QGVAR(Loadout), ""]);

	if !(_loadout isEqualTo "") then {
		[player, _loadout] call FUNC(GearScript);
	};

	if !(_respawnPoint isEqualTo objnull) then {
		player setPosATL getPosATL _respawnPoint;
	};

    player setVariable [QGVAR(Body), player, true];

    switch (_respawnType) do {
        case -1: {
            cutText ["You have respawned. This mission has unlimited respawns.", 'PLAIN DOWN'];
        };
        case 0: {
            private _p = "";
        	if (GVAR(RespawnTickets) != 1) then {
        		_p = "s";
        	};
        	private _message2 = format ["You have %1 individual ticket%2 remaining, you can respawn %1 time%2", GVAR(RespawnTickets), _p];
            cutText [_message2, 'PLAIN DOWN'];
        };
        case 1: {
            private _sideTickets = switch (side player) do {
        		case west: {
        			GVAR(RespawnTicketsWest)
        		};
        		case east: {
        			GVAR(RespawnTicketsEast)
        		};
        		case independent: {
        			GVAR(RespawnTicketsInd)
        		};
        		case civilian: {
        			GVAR(RespawnTicketsCiv)
        		};
                default {
                    0
                };
        	};
        	private _p = "";
        	if (_sideTickets != 1) then {
        		_p = "s";
        	};
        	cutText [format ['Your side has %1 ticket%2 left, you can respawn %1 time%2', _sideTickets, _p], 'PLAIN DOWN'];
        };
        default {};
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(eventCheckRespawnTickets_Response), {
    params [["_response", false, [false]]];
    LOG_2("eventCheckRespawnTickets_Response started: %1 response: %2",player,_response);
    if (_response) then {
        [QGVAR(eventPlayerRespawned), [1]] call CBA_fnc_localEvent;
    } else {
        [] call FUNC(StartSpectator); // spectator var is set in this function
        [QGVAR(respawnEvent), [player, true]] call CBA_fnc_serverEvent;
    };
}] call CBA_fnc_addEventHandler;

#include "..\customization\inits\PreInitClient.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
