#include "script_component.hpp"

params ["_unit"];

private _morale	= _unit getVariable "aiCover_morale_down";
private _state	= _unit getVariable "aiCover_state_down";

if (alive _unit) then {
  [{morale (_this select 0) < (_this select 1) || !alive (_this select 0)},{
    params ["_unit", "_state"];

    _unit setUnitPos _state;
    [_unit] call FUNC(addRecover);
  },[_unit, _morale, _state]] call CBA_fnc_waitUntilAndExecute;
};
