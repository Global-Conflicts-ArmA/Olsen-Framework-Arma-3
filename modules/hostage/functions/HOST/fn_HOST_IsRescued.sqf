#include "script_component.hpp"

params ["_unit"];

TRACE_1("Hostage isRescued called", _unit);
/* diag_log format ["Rescued?: %1", GETVAR(_unit, IsRescued, false)]; */

private _isRescued = GETVAR(_unit, IsRescued, false);

_isRescued;
