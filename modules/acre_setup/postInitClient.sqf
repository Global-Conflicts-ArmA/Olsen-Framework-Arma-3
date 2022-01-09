#include "..\..\core\script_macros.hpp"

params ["_unit"];

if (GETVAR(_unit,Spectating,false)) exitWith { }; // If the unit is spectating, don't run this, it will overwrite their access to all languages
LOG_1("Running ACRE setup for %1", _unit);
[] call FUNC(ACRES_ClientInit);
