#include "script_component.hpp"

params ["_unit","_down","_up"];	//[OBJECT,[0.5,"DOWN"],[0.6,"MIDDLE"]] call FNC_aiCover;

if (!local _unit) exitWith {};

_unit setVariable ["aiCover_morale_down",_down select 0,false];
_unit setVariable ["aiCover_state_down",_down select 1,false];

_unit setVariable ["aiCover_morale_up",_up select 0,false];
_unit setVariable ["aiCover_state_up",_up select 1,false];

[_unit] call FUNC(addCover);
