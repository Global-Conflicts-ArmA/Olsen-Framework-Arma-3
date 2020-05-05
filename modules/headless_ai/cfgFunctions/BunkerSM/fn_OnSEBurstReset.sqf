#include "..\..\script_macros.hpp"

params ["_unit"];

SETVAR(_unit,burstCount,0);
private _BurstResetCount = GETVAR(_this,BurstResetCount,0);
_BurstResetCount = _BurstResetCount + 1;
SETVAR(_this,BurstResetCount,_BurstResetCount);

