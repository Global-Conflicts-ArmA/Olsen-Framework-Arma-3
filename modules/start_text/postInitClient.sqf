#include "..\..\core\script_macros.hpp"

params ["_unit"];

if !(local _unit) exitWith {};
if !(hasInterface) exitWith {};

[] call FUNC(START_init);
