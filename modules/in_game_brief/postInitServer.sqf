#include "script_component.hpp"

// Ingame Brief Variable Defines
GVAR(bluforIsReady) = false;
GVAR(opforIsReady) = false;
GVAR(missionStarter) = false;

[] call FUNC(missionStarter);

#include "settings.sqf"
