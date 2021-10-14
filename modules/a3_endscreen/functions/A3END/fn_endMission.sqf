// A3END_fnc_EndMission(END_TYPE, WIN) OR EFUNC(A3END,EndMission) from within code will end the mission (see settings.sqf for advanced options)
// Sends the team stats, time limit, endType and executes "BIS_fnc_endMission" on all players machines
#include "script_component.hpp"

#include "..\..\settings.sqf"

diag_log "INFO: A3 END called!";

params[
	["_endName", "end1", ["end1", []]],
	["_isVictory", true, [true]]
];

GVAR(FW_EndStats) = "";

if (!ENABLE_A3_ENDSCREEN) exitWith {};

if (GVAR(FW_EndStats) == "") then {
	private _team = objNull;
	private _casualties = objNull;
	private _assets = [];
	private _disabled = 0;
	private _destroyed = 0;
	private _time = ceil(CBA_missionTime / 60);

	if (_time >= GVAR(TimeLimit)) then {_time = GVAR(TimeLimit);};

	if (GVAR(TimeLimit) == 0) then {

		GVAR(FW_EndStats) = format ["<t font='PuristaBold' size='1'>Mission duration: %1 minutes.</t><br/><br/>", _time];

	} else {

		GVAR(FW_EndStats) = format ["<t font='PuristaBold' size='1'>Mission duration: %1 out of %2 minutes.</t><br/><br/>", _time, GVAR(TimeLimit)];

	};

	for "_i" from 0 to count GVAR(Teams) -1 do {
		_team = GVAR(Teams) select _i;
		_casualties = _team select 0 call EFUNC(FW,CasualtyCount);

		GVAR(FW_EndStats) = GVAR(FW_EndStats) + format ["<t font='PuristaBold' size='1.6'>%1:</t><br/>Casualties: %2/%3", _team select 0, _casualties, _team select 3];

		_assets = (_team select 0) call EFUNC(FW,GetDamagedAssets);
		_disabled = _assets select 0;
		_destroyed = _assets select 1;

		if (count _disabled > 0) then {
			GVAR(FW_EndStats) = GVAR(FW_EndStats) + "<br/><br/><t font='PuristaBold' size='1.2'>Disabled Assets:</t><br/>";

			for "_k" from 0 to count _disabled -1 do {
				GVAR(FW_EndStats) = GVAR(FW_EndStats) + format ["- %1", _disabled select _k];

				if (_k < count _disabled -1) then {
					GVAR(FW_EndStats) = GVAR(FW_EndStats) + "<br/>";
				};
			};
		};

		if (count _destroyed > 0) then {
			GVAR(FW_EndStats) = GVAR(FW_EndStats) + "<br/><br/><t font='PuristaBold' size='1.2'>Destroyed Assets:</t><br/>";

			for "_k" from 0 to count _destroyed -1 do {
				GVAR(FW_EndStats) = GVAR(FW_EndStats) + format ["- %1", _destroyed select _k];

				if (_k < count _destroyed -1) then {
					GVAR(FW_EndStats) = GVAR(FW_EndStats) + "<br/>";
				};
			};
		};

		if (_i < count GVAR(Teams) -1) then {
			GVAR(FW_EndStats) = GVAR(FW_EndStats) + "<br/><br/><br/>";
		};
	};

	/* publicVariable "GVAR(FW_EndStats)"; */

};

SETMPVAR(MissionEnded,true);

if (_endName isEqualType "STRING") exitWith {

	[[_endName, _isVictory], "BIS_fnc_endMission"] call BIS_fnc_MP;

};

if (_endName isEqualType "ARRAY") exitWith {

	_this apply {

		[[_x select 1, _x select 2], "BIS_fnc_endMission", _x select 0] call BIS_fnc_MP;

	};

};
