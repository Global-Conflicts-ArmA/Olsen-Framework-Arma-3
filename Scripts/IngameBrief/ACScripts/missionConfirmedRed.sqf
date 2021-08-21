private["_removeConfirmedRed","_removeCanceledRed"];

_removeConfirmedRed = RedBoard removeAction confirmedRed;
_removeCanceledRed = RedBoard removeAction canceledRed;

[-2, {hint "Opfor has signaled they are ready to begin!";}] call CBA_fnc_globalExecute;

opforIsReady = True;
publicvariable "opforIsReady";
RedBoard hideObjectGlobal true;
deleteVehicle BlueBoard;