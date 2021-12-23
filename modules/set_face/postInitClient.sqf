#include "script_component.hpp"

#include "settings.sqf"

allUnits select {
    local _x
    && {!(_x in GVAR(setFace_exclusion))}
    && {_x isKindOf "MAN"}
} apply {
	[_x] call FUNC(setFace);
};
