#include "script_component.hpp"

GVAR(markers) = [];

#include "settings.sqf"

if (GVAR(markers) isNotEqualTo []) then {
	[] call FUNC(init);
};
