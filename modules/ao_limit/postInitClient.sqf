#include "script_component.hpp"

GVAR(markers) = [];

#include "settings.sqf"

if ((count GVAR(markers)) > 0) then {
	[] call FUNC(init);
};
