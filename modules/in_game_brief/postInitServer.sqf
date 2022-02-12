#include "script_component.hpp"

// Ingame Brief Variable Defines
SETMVAR(bluforIsReady, false);
SETMVAR(opforIsReady, false);
SETMVAR(missionStarter, false);

[] call FUNC(beginTheMission);

#include "settings.sqf"
