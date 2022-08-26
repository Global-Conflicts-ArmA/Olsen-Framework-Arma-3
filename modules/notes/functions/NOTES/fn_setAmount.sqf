#include "script_component.hpp"

params ["_unit","_amount"];
if (!isServer && !local _unit) exitWith {};

_unit setVariable [QGVAR(amount), round _amount, true];
