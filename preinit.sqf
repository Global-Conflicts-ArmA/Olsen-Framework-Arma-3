#define preinit

#include "core\script_macros.hpp"
#include "customization\settings.sqf" //DO NOT REMOVE

GVAR(DebugMessages) = [];
GVAR(Modules) = [];

FW_fnc_Briefing = compile preprocessFileLineNumbers "customization\briefing.sqf";
FW_fnc_Menu = compile preprocessFileLineNumbers "core\menu.sqf";
FW_fnc_GearScript = compile preprocessFileLineNumbers "customization\gear.sqf"; 
FW_fnc_VehicleGearScript = compile preprocessFileLineNumbers "customization\vehGear.sqf";
FW_fnc_EndScreen = compile preprocessFileLineNumbers "core\dia\endscreen\dia_endscreen.sqf";

#include "modules\modules.sqf" //DO NOT REMOVE