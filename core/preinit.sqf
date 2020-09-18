#define preinit

#include "script_macros.hpp"
#include "..\customization\settings.sqf" //DO NOT REMOVE
#include "..\customization\debugSettings.sqf" //DO NOT REMOVE

GVAR(DebugMessages) = [];
GVAR(Modules) = [];

["ace_firedPlayer", FUNC(firedEH)] call CBA_fnc_addEventHandler;
["ace_firedPlayerVehicle", FUNC(firedEH)] call CBA_fnc_addEventHandler;
["ace_firedNonPlayer", FUNC(firedEH)] call CBA_fnc_addEventHandler;
["ace_firedNonPlayerVehicle", FUNC(firedEH)] call CBA_fnc_addEventHandler;

#include "..\customization\gearSettings.sqf"

#include "..\customization\inits\PreInitGlobal.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
