#include "script_component.hpp"

private _version = 0.1;

["Setup Timer", "Allows the mission maker to restrict players to an area for a set amount of time", "Olsen, Sacher &amp; PIZZADOX", _version] call EFUNC(FW,RegisterModule);

GVAR(SetupTimers) = [];

#include "settings.sqf"
