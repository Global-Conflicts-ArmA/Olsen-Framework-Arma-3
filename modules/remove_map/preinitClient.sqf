if !(hasInterface) exitWith {}; // As this module is client-side only, only continue if this is a client

#include "script_component.hpp"

private _version = 0.2;

["Remove Maps", "Removes maps and compasses from specific gear cases.", "TinfoilHate &amp; StatusRed", _version] call FUNC(RegisterModule);
