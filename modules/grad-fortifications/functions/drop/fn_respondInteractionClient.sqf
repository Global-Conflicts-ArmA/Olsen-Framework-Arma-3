#include "script_component.hpp"
params ["_crate","_unit","_mode"];

private _fortType = _crate getVariable [QGVAR(dropCrate_type),""];
_crate setVariable [QGVAR(dropCrate_type),""];
deleteVehicle _crate;

if (_fortType == "" || {isNull _crate}) exitWith {};

if (_mode == "TAKE") then {
    [_unit,_fortType,1] call FUNC(addFort);
};

if (_mode == "BUILD") then {
    [_fortType,"DROPPED"] remoteExecCall [QFUNC(startPlacement),_unit,false];
};
