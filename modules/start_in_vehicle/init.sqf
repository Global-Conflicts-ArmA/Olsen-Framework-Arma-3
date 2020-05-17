["Start in Vehicle", "Moves units into specific vehicle slots upon mission start, includes JiP timeout", "PIZZADOX"] call FUNC(RegisterModule);

["CBA_loadingScreenDone", {
    [] call StartInVehicle_fnc_startInVehicle;
}] call CBA_fnc_addEventHandler;


