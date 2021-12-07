#include "script_component.hpp"

// Detect that the mission has been called
GVAR(CallMissionEh) = ["frameworkCallMission", {_this call FUNC(CallMission);}] call CBA_fnc_addEventHandler;
