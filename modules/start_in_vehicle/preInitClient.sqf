#include "..\..\core\script_macros.hpp"

private _version = 0.1;

["Start in Vehicle", "Moves units into specific vehicle slots upon mission start, includes JiP timeout", "PIZZADOX &amp; StatusRed", _version] call FUNC(RegisterModule);

["CBA_loadingScreenDone", {
    [] call FUNC(StartInVehicle_startInVehicle);
}] call CBA_fnc_addEventHandler;
