#include "script_component.hpp"

params [
	["_player", objNull, [objNull]],
	["_callID", "", [""]]
];

GVAR(MissionCalls) apply {

	if ((_x select 1) == sideUnknown && (_x select 0) == _callID) exitWith {
		["Calling mission...", "hint", _player] call BIS_fnc_MP;
		(_x select 2) call EFUNC(FW,EndMission);

	};

	if ((_x select 0) == _callID) exitWith {
		if (_player getVariable ["FW_IsCO", false]) then {
			["Calling mission...", "hint", _player] call BIS_fnc_MP;
			(_x select 2) call EFUNC(FW,EndMission);

		} else {
			["You must be the CO to call this mission.", "hint", _player] call BIS_fnc_MP;
		};

	};

};
