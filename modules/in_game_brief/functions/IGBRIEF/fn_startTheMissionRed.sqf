#include "script_component.hpp"

["OPFOR Confirm mission start?"] remoteExec ["hint"];

RedBoard removeAction GVAR(opforStarter);

GVAR(confirmedRed) = RedBoard addAction ["Confirm Begin Mission", "modules\in_game_brief\functions\IGBRIEF\fn_missionConfirmedRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];
GVAR(canceledRed) = RedBoard addAction ["<t color='#FF0000'>Abort Begin Mission</t>", "modules\in_game_brief\functions\IGBRIEF\fn_missionCanceledRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];
