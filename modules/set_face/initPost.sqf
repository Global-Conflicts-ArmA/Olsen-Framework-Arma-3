#include "script_component.hpp"

params ["_unit"];

if !(local _unit) exitWith {};

private _side = side _unit;
private _enabled = GVAR(Blufor_SetFaces);
private _exceptionUnits = GVAR(Blufor_ExceptionUnits);
private _specUnits = GVAR(Blufor_SpecialUnits);
private _specFaces = GVAR(Blufor_SpecialFaces);
private _regFaces = GVAR(Blufor_RegularFaces);

switch (_side) do {
    case east: {
        _enabled = GVAR(Opfor_SetFaces);
        _exceptionUnits = GVAR(Opfor_ExceptionUnits);
        _specUnits = GVAR(Opfor_SpecialUnits);
        _specFaces = GVAR(Opfor_SpecialFaces);
        _regFaces = GVAR(Opfor_RegularFaces);
    };
    case independent: {
        _enabled = GVAR(Indfor_SetFaces);
        _exceptionUnits = GVAR(Indfor_ExceptionUnits);
        _specUnits = GVAR(Indfor_SpecialUnits);
        _specFaces = GVAR(Indfor_SpecialFaces);
        _regFaces = GVAR(Indfor_RegularFaces);
    };
    case civilian: {
        _enabled = GVAR(Civilian_SetFaces);
        _exceptionUnits = GVAR(Civilian_ExceptionUnits);
        _specUnits = GVAR(Civilian_SpecialUnits);
        _specFaces = GVAR(Civilian_SpecialFaces);
        _regFaces = GVAR(Civilian_RegularFaces);
    };
    default {
        _enabled = GVAR(Blufor_SetFaces);
        _exceptionUnits = GVAR(Blufor_ExceptionUnits);
        _specUnits = GVAR(Blufor_SpecialUnits);
        _specFaces = GVAR(Blufor_SpecialFaces);
        _regFaces = GVAR(Blufor_RegularFaces);
    };
};

if (_enabled && {!(_unit in _exceptionUnits)}) then {
    if (_unit in _specUnits) then {
        if (_specFaces isEqualTo []) exitWith {
            ERROR_2("setFace module has an incorrect input: missing special faces array",_unit,_side);
        };
        private _face = selectRandom _specFaces;
        [_unit, _face] remoteExec ["setFace", 0, _unit, true];
    } else {
        if (_regFaces isEqualTo []) exitWith {
            ERROR_2("setFace module has an incorrect input: missing regular faces array",_unit,_side);
        };
        private _face = selectRandom _regFaces;
        [_unit, _face] remoteExec ["setFace", 0, _unit, true];
    };
};
