#define preinit

#include "script_macros.hpp"
#include "..\customization\settings.sqf" //DO NOT REMOVE

GVAR(DebugMessages) = [];
GVAR(Modules) = [];

#include "..\customization\gearSettings.sqf"

#include "..\customization\inits\PreInitGlobal.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE