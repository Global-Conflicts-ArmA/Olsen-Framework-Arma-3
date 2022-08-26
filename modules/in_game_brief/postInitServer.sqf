#include "script_component.hpp"

// Ingame Brief Variable Defines
SETMPVAR(bluforIsReady, false);
SETMPVAR(opforIsReady, false);
SETMPVAR(missionStarter, false);

[] call FUNC(beginTheMission);

#include "settings.sqf"
