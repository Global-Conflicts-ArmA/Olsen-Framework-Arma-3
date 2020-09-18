#include "script_component.hpp"
params ["_crate","_unit","_mode"];

private _fortType = _crate getVariable [QGVAR(dropCrate_type),""];

if (_mode == "TAKE") then {
    if ([_unit,_fortType,1,true] call FUNC(canTake)) then {
        [_crate,_unit,_mode] remoteExecCall [QFUNC(respondInteractionClient),2,false];
    } else {
        playSound "AddItemFailed";
    };
} else {
    [_crate,_unit,_mode] remoteExecCall [QFUNC(respondInteractionClient),2,false];
};
