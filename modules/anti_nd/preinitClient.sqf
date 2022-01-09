#include "script_component.hpp"

private _version = 1.0;

["Anti ND", "Prevents negligent discharges at spawn.", "Starfox64, PIZZADOX &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

[] call FUNC(Init);
