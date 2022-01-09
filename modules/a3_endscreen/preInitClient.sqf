// Module by Starfox64 (STEAM_0:1:37636871) //
#include "script_component.hpp"

private _version = 0.1;

["ArmA 3 End Screen", "Replaces the standard end screen with the default ArmA 3 end mission animation.", "Starfox64 &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

#include "settings.sqf"

GVAR(FW_EndStats) = "";
