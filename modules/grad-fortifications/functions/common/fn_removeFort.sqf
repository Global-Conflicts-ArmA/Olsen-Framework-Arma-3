#include "script_component.hpp"
params ["_unit","_type",["_amount",1]];

if (_type == "") exitWith {};

_amount = -(abs _amount);

if (!local _unit) then {
    [_unit,_type,_amount] remoteExecCall [QFUNC(addFort),_unit,false];
} else {
    [_unit,_type,_amount] call FUNC(addFort);
};
