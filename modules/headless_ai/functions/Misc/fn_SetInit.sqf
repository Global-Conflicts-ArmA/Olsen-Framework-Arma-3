#include "script_component.hpp"


private _object = _this deleteAt 0;

private _storedVars = [];

{
    private _varName = _x;
    if (GETMVAR(VerboseDebug,false)) then {
        LOG_2("Setting _varName: %1 on: %2",_varName,_object);
    };
    if (_varName isEqualType "") then {
        private _value = _this deleteAt (_forEachIndex + 1);
        private _varNameF = format [QUOTE(DOUBLES(COMPONENT,%1)),_varName];
        _object setVariable [_varNameF, _value];
        _storedVars pushBack [_varNameF,_value];
        if (GETMVAR(VerboseDebug,false)) then {
            LOG_2("Setting _varName: %1 with: %2",_varNameF,_value);
        };
    };
} forEach _this;

SETVAR(_object,StoredVars,_storedVars);
