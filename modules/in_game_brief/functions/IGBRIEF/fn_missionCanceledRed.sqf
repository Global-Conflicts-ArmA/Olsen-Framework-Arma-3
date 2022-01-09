#include "script_component.hpp"

RedBoard removeAction GVAR(confirmedRed);
RedBoard removeAction GVAR(canceledRed);

GVAR(opforStarter) = RedBoard addAction ["Begin Mission", "modules\in_game_brief\functions\IGBRIEF\fn_startTheMissionRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];
