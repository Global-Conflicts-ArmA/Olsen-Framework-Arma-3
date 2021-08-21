private["_removeConfirmedRed","_removeCanceledRed"];

_removeConfirmedRed = RedBoard removeAction confirmedRed;
_removeCanceledRed = RedBoard removeAction canceledRed;

opforStarter = RedBoard addAction ["Begin Mission", "ingameBrief\ACScripts\startTheMissionRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];
