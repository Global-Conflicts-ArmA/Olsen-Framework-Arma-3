#include "..\..\script_macros.hpp"


params [["_varName", "", [""]]];

private _return = if !(isNil _varName) then {
    for "_i" from 1 to 100 step 1 do {
        private _testName = format ["%1_%2",_varName,_i];
        if (isNil _testName) exitwith {
            _testName
        };
    };
} else {
    _varName
};

_return
