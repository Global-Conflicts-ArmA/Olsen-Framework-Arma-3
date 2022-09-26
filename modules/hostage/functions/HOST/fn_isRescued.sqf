#include "script_component.hpp"

params ["_unit"];

private _isRescued = GETVAR(_unit,IsRescued,false);

TRACE_2("isRescued called",_unit,_isRescued);

_isRescued;
