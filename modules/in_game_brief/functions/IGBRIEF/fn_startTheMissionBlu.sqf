#include "script_component.hpp"

["BLUFOR Confirm mission start?"] remoteExec ["hint"];

BlueBoard removeAction GVAR(bluforStarter);

GVAR(confirmedBlu) = BlueBoard addAction ["Confirm Begin Mission", "modules\in_game_brief\functions\IGBRIEF\fn_missionConfirmedBlu.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == west)"];
GVAR(canceledBlu) = BlueBoard addAction ["<t color='#FF0000'>Abort Begin Mission</t>", "modules\in_game_brief\functions\IGBRIEF\fn_missionCanceledBlu.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == west)"];
