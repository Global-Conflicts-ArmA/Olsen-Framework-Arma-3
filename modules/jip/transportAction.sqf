#include "script_component.hpp"

private _id = _this select 2;
private _targets = [];

playableUnits apply {
	if ((side player) == (side _x) && {(leader _x == _x)}) then {
		_targets pushBack _x;
	};
};

[format ["%1 joined the mission and is requesting transport.", name player], "hint", _targets] call BIS_fnc_MP;

player removeAction _id;
