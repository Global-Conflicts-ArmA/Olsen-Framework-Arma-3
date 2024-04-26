#include "script_component.hpp"

private _version = 0.2;

["Start Text", "Displays animated text on mission start.", "Olsen, Starfox64, StatusRed &amp; PiZZADOX", _version] call EFUNC(FW,RegisterModule);

["CBA_loadingScreenDone", {
    [] call FUNC(init);
}] call CBA_fnc_addEventHandler;
