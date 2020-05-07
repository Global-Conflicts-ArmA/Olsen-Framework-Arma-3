#define preinitClient

#include "script_macros.hpp"
#include "..\customization\clientSettings.sqf" //DO NOT REMOVE

//QGVAR(EndMission) player event sends the received variables to the end screen
GVAR(EndMissionEh) = [QGVAR(EndMission), {_this call FUNC(EndScreen)}] call CBA_fnc_addEventHandler;

#include "..\customization\inits\PreInitClient.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE