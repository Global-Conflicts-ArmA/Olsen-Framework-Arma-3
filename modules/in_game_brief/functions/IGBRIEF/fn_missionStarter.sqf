#include "script_component.hpp"

GVAR(bluforStarter) = BlueBoard addAction ["Begin Mission", "modules\in_game_brief\functions\IGBRIEF\fn_startTheMissionBlu.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == west)"];

GVAR(opforStarter) = RedBoard addAction ["Begin Mission", "modules\in_game_brief\functions\IGBRIEF\fn_startTheMissionRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];

[] call FUNC(beginTheMission);
