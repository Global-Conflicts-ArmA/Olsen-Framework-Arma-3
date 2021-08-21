private["_removeConfirmedBlu","_removeCanceledBlu"];

_removeConfirmedBlu = BlueBoard removeAction confirmedBlu;
_removeCanceledBlu = BlueBoard removeAction canceledBlu;

bluforStarter = BlueBoard addAction ["Begin Mission", "ingameBrief\ACScripts\startTheMissionBlu.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == west)"];