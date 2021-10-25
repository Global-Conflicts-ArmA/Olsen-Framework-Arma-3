//This module shares target information between AI groups based on their radios.
//Written by TinfoilHate, ported by StatusRed
//Updated: 25th October, 2021

#include "script_component.hpp"

#include "settings.sqf"

[{call FUNC(aiLink)},[],GVAR(aiLink_startDelay)] call CBA_fnc_waitAndExecute;
