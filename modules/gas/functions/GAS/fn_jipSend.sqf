#include "script_component.hpp"

GVAR(GASLOGICS) apply {
	[QGVAR(GASZONES), _x] spawn CBA_fnc_globalEvent;
};
