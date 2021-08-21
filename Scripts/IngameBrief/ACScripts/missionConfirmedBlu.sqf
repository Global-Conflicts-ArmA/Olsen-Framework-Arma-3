private["_removeConfirmedBlu","_removeCanceledBlu"];

_removeConfirmedBlu = BlueBoard removeAction confirmedBlu;
_removeCanceledBlu = BlueBoard removeAction canceledBlu;

[-2, {hint "Blufor has signaled they are ready to begin!";}] call CBA_fnc_globalExecute;

bluforIsReady = True;
publicvariable "bluforIsReady";
BlueBoard hideObjectGlobal true;
deleteVehicle BlueBoard;