#include "script_component.hpp"
params ["_unit","_factor"];

_unit setVariable [QGVAR(buildTimeFactor),_factor,true];
