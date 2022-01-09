if (!hasInterface) exitWith { }; // As this module is client-side only, only continue if this is a client

#include "..\..\core\script_macros.hpp"

#include "settings.sqf"

[_keepMapClasses, _keepCompassClasses] call FUNC(RM_doRemoves);
