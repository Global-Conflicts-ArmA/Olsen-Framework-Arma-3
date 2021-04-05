#include "script_component.hpp"

private _version = 0.1;

["Anti ND", "Prevents negligent discharges at spawn.", "Starfox64 &amp; PIZZADOX", _version] call EFUNC(FW,RegisterModule);

[] call FUNC(Init);
