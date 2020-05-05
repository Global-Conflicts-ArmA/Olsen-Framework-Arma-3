#include "..\..\script_macros.hpp"


params ["_grp",["_AllowedModules",[],[[]]],["_AllowedSynced",[],[[]]],["_item",objNull,[objNull]],["_Allowed",false,[false]]];
private _grpldr = leader _grp;
if (!isNull assignedVehicle _grpldr) then {
    _item = assignedVehicle _grpldr;
} else {
    _item = _grpldr;
};
{
    private _syncModule = _x;
    if (_syncModule isKindOf "Logic") then {
        if (count _AllowedModules > 0) then {
            _Allowed = (typeof _syncModule) in _AllowedModules;
        } else {
            _Allowed = true;
        };
        if (_Allowed) then {
            _AllowedSynced pushBack _syncModule;
        };
    };
} foreach (synchronizedObjects _item);
_AllowedSynced
