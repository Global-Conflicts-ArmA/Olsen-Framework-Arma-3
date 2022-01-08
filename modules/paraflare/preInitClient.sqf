#include "script_component.hpp"

private _version = 0.1;

["Paraflares", "Paraflares, old style.", "TinfoilHate &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

GVAR(flareAngle) = 90;

["paraflare_evt_flareLight", FUNC(flareLight)] call CBA_fnc_addEventHandler;
