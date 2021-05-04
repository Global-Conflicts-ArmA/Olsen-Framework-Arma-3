#include "script_component.hpp"

private _veh = _this select 0;
private _side = _this select 1;

private _units = [];

{if (side _x == _side) then {_units set [count _units, _x]}} forEach playableUnits;

private _result = [_veh, _units] call FUNC(EXTRACT_CheckArrayInVeh);

_result;
