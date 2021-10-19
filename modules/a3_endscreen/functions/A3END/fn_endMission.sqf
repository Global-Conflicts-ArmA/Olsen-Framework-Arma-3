// A3END_fnc_EndMission(END_TYPE, WIN) OR EFUNC(A3END,EndMission) from within code will end the mission (see settings.sqf for advanced options)
// Sends the team stats, time limit, endType and executes "BIS_fnc_endMission" on all players machines
#include "script_component.hpp"

#include "..\..\settings.sqf"

INFO("A3 END called!");

params[
	["_endName", "end1", ["end1", []]],
	["_isVictory", true, [true]]
];

GVAR(FW_EndStats) = "";

if !(ENABLE_A3_ENDSCREEN) exitWith {};

if (GVAR(FW_EndStats) isEqualTo "") then {
	private _time = ceil(CBA_missionTime / 60);
	if (_time >= GVAR(TimeLimit)) then {_time = GVAR(TimeLimit)};

	if (GVAR(TimeLimit) isEqualTo 0) then {
		GVAR(FW_EndStats) = format ["<t font='PuristaBold' size='1'>Mission duration: %1 minutes.</t><br/><br/>", _time];
	} else {
		GVAR(FW_EndStats) = format ["<t font='PuristaBold' size='1'>Mission duration: %1 out of %2 minutes.</t><br/><br/>", _time, GVAR(TimeLimit)];
	};

	for "_i" from 0 to count GVAR(Teams) -1 do {
		private _team = GVAR(Teams) select _i;
		private _casualties = _team select 0 call EFUNC(FW,CasualtyCount);

		GVAR(FW_EndStats) = GVAR(FW_EndStats) + format ["<t font='PuristaBold' size='1.6'>%1:</t><br/>Casualties: %2/%3", _team select 0, _casualties, _team select 3];

		private _assets = (_team select 0) call EFUNC(FW,GetDamagedAssets);
		_assets params [["_disabled", [], [[]]], ["_destroyed", [], [[]]]];

		if (_disabled isNotEqualTo []) then {
			GVAR(FW_EndStats) = GVAR(FW_EndStats) + "<br/><br/><t font='PuristaBold' size='1.2'>Disabled Assets:</t><br/>";

			for "_k" from 0 to count _disabled -1 do {
				GVAR(FW_EndStats) = GVAR(FW_EndStats) + format ["- %1", _disabled select _k];

				if (_k < count _disabled -1) then {
					GVAR(FW_EndStats) = GVAR(FW_EndStats) + "<br/>";
				};
			};
		};

	 if (_destroyed isNotEqualTo []) then {
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
	[_endName, _isVictory] remoteExec ["BIS_fnc_endMission", 0, true];
};

if (_endName isEqualType "ARRAY") exitWith {
	_this apply {
		[_x select 1, _x select 2] remoteExec ["BIS_fnc_endMission", _x select 0, true];
	};
};
