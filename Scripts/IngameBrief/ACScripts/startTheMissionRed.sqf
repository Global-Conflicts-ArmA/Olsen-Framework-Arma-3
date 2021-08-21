private["_removeOpforStarter"];

[-2, {hint "OPFOR Confirm mission start?";}] call CBA_fnc_globalExecute;

_removeOpforStarter = RedBoard removeAction opforStarter;

confirmedRed = RedBoard addAction ["Confirm Begin Mission", "ingameBrief\ACScripts\missionConfirmedRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];
canceledRed = RedBoard addAction ["<t color='#FF0000'>Abort Begin Mission</t>", "ingameBrief\ACScripts\missionCanceledRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];