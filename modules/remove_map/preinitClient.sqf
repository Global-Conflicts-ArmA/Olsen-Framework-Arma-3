if (!hasInterface) exitWith { }; // As this module is client-side only, only continue if this is a client

#include "..\..\core\script_macros.hpp"

private _version = 0.1;

["Remove Maps", "Removes maps and compasses from specific gear cases.", "TinfoilHate &amp; StatusRed", _version] call FUNC(RegisterModule);

#include "settings.sqf"

[_keepMapClasses, _keepCompassClasses] call FUNC(RM_doRemoves);
