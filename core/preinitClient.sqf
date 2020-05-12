#include "script_macros.hpp"

#define preInitClient

#include "..\customization\clientSettings.sqf" //DO NOT REMOVE

//QGVAR(EndMission) player event sends the received variables to the end screen
GVAR(EndMissionEh) = [QGVAR(EndMission), {_this call FUNC(EndScreen)}] call CBA_fnc_addEventHandler;

//function ran from keyHandler
killcam_toggleFnc = {
    //37 is DIK code for K
    if ((_this select 1) == 37) then {
        if (killcam_toggle) then {
            killcam_toggle = false;
            cutText ["", "PLAIN DOWN"];
        }
        else {
            killcam_toggle = true;
            cutText ["Line shows LINE OF SIGHT from postion of enemy to player's position during the time of death.\nPress K to toggle hud markers off.\n\nTHIS FRAMEWORK FEATURE IS WIP. It may contain bugs and may be updated or changed at any point.", "PLAIN DOWN"];
        };
    };
};

eg_keyHandler_display_hidden = false;

eg_keyHandler = {
    params ["_control", "_code", "_shift", "_control", "_alt"];

    private _acre = ["ACRE2", "HeadSet"] call CBA_fnc_getKeybind;
    if (!isNil "_acre") then {
        private _action = _acre select 4;
        private _keys = _acre select 5;

        if ((_code == _keys select 0) && {(_keys select 1) isEqualTo [_shift, _control, _alt]}) then {
            call _action;
        };
    };
    
    if (_code == 35 && {!_shift} && {_control} && {!_alt}) then {
        if (!eg_keyHandler_display_hidden) then {
            (findDisplay 60492) closedisplay 1;
            eg_keyHandler_display_hidden = true;
        };
    };
};

eg_keyHandler2 = {
    params ["_control", "_code", "_shift", "_control", "_alt"];
    
    if (_code == 35 && {!_shift} && {_control} && {!_alt} &&
    {!isNil "eg_keyHandler_display_hidden"} &&
    {eg_keyHandler_display_hidden}
    ) then {
        ([] call BIS_fnc_displayMission) createDisplay "RscDisplayEGSpectator";
        eg_keyHandler_display_hidden = false;
        
        eg_keyHandle = (findDisplay 60492) displayAddEventHandler ["keyDown", {call eg_keyHandler;}];
        if (killcam_active) then {
            killcam_keyHandle = (findDisplay 60492) displayAddEventHandler ["keyDown", {call killcam_toggleFnc;}];
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
        [] call FUNC(StartSpectator);
    };
}] call CBA_fnc_addEventHandler;

#include "..\customization\inits\PreInitClient.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE