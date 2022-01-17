#include "script_component.hpp"

GVAR(CAPZONE_INTERVAL) = 15;
GVAR(CAPZONE_MESSAGES) = ["Blufor is capturing the zone", "Opfor is capturing the zone", "Resistance is capturing the zone", "Civilian is capturing the zone", "The zone is contested", "The zone is uncontested"];
GVAR(CAPZONE_MARKERCOLLECTION) = [];
GVAR(TIMERS) = [];
GVAR(CAPZONE_COLOURS) = ["ColorBlue", "ColorRed", "ColorGreen", "ColorYellow", "ColorWhite", "ColorKhaki"];
GVAR(OLD_OWNERS_MAP) = createHashMap;

#include "settings.sqf"
