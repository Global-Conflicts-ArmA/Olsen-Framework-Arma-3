private["_removeBluforStarter"];

[-2, {hint "BLUFOR Confirm mission start?";}] call CBA_fnc_globalExecute;

_removeBluforStarter = BlueBoard removeAction bluforStarter;

confirmedBlu = BlueBoard addAction ["Confirm Begin Mission", "ingameBrief\ACScripts\missionConfirmedBlu.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == west)"];
canceledBlu = BlueBoard addAction ["<t color='#FF0000'>Abort Begin Mission</t>", "ingameBrief\ACScripts\missionCanceledBlu.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == west)"];