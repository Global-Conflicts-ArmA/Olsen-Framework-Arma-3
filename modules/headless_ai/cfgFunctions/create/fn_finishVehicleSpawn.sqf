#include "..\..\script_macros.hpp"

params [
    ["_vehicle", objNull, [objNull]],
    ["_init", false, [false, {}]],
    ["_storedVars", [], [[]]]
];

if (_init isEqualType {}) then {
    //SETVAR(_vehicle,Init,_init);
    _vehicle call _init;
};

if (_storedVars isNotEqualTo []) then {
    //LOG_1("Setting vars: %1",_storedVars);
    _storedVars apply {
        _x params ["_varName", "_varValue"];
        _vehicle setvariable [_varName,_varValue];
        //LOG_2("Setting _varName: %1 with: %2",_varName,_varValue);
    };
};