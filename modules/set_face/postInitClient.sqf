#include "script_component.hpp"

#include "settings.sqf"

allUnits apply {
	if (local _x && {!(_x in GVAR(setFace_exclusion))} && {_x isKindOf "MAN"}) then {
		[_x] call FUNC(setFace);
	};
};
