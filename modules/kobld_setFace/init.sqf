#include "settings.sqf"

allUnits apply {
	if (local _x && {!(_x in kobld_setFace_exclusion)} && {_x isKindOf "MAN"}) then {
		[_x] call kobld_fnc_setFace;
	};
};