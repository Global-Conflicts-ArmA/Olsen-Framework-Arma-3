#include "script_component.hpp"
params ["_unit", ["_allow",true]];

_unit setVariable [QGVAR(canPackUp),_allow,true];
