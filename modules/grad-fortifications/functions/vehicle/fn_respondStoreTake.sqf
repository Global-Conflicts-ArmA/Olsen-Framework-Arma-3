#include "script_component.hpp"
params ["_caller","_container","_type","_mode"];

private _containerForts = _container getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate];
private _containerStock = [_containerForts,_type] call CBA_fnc_hashGet;

private _callerForts = _caller getVariable [QGVAR(myFortsHash),[[],0] call CBA_fnc_hashCreate];
private _callerStock = [_callerForts,_type] call CBA_fnc_hashGet;

switch (_mode) do {
    case ("BUILD"): {
        if (_containerStock > 0) then {
            [_container,_type] call FUNC(removeFort);
            [_type,"DROPPED"] remoteExecCall [QFUNC(startPlacement),_caller,false];
        };
    };
    case ("STORE"): {
        if ([_container,_type] call FUNC(canTake)) then {
            [_container,_type] call FUNC(addFort);
        } else {
            //reimburse
            [_caller,_type] call FUNC(addFort);
        };
    };
    case ("TAKE"): {
        if (_containerStock > 0) then {
            [_container,_type] call FUNC(removeFort);
            [_caller,_type] call FUNC(addFort);
        };
    };
};
