#include "script_component.hpp"
params ["_unit", "_type", ["_amount", 1]];

if (_type == "") exitWith {};
if !(local _unit) exitWith {
    [_unit,_type,_amount] remoteExecCall [QFUNC(addFort),_unit,false];
};

_amount = round _amount;
private _myForts = _unit getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate];

private _stock = [_myForts,_type] call CBA_fnc_hashGet;
if (_stock + _amount <= 0) then {
    [_myForts,_type] call CBA_fnc_hashRem;
} else {
    [_myForts,_type,_stock+_amount] call CBA_fnc_hashSet;
};

private _size = [_type, "size"] call FUNC(getConfigValue);
if (_amount < 0) then {_size = -_size};
if (_stock + _amount >= 0) then {
    _unit setVariable [QGVAR(inventoryCargo),(_unit getVariable [QGVAR(inventoryCargo),0]) + _size, true];
};

private _isPublic = !(_unit isKindOf "Man");
_unit setVariable [QGVAR(myFortsHash),_myForts,_isPublic];
if (_isPublic) then {
    [_unit,_myForts] remoteExecCall [QFUNC(updateItemList),0,false];
} else {
    [] call FUNC(updateItemList);
};
