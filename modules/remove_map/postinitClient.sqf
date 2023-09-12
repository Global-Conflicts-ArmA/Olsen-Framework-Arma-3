if !(hasInterface) exitWith {}; // As this module is client-side only, only continue if this is a client

#include "script_component.hpp"

#include "settings.sqf"

[_keepMapClasses, _keepCompassClasses] call FUNC(doRemoves);
