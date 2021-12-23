#include "..\..\script_macros.hpp"


//unit 1, unit 2
params ["_unit", ["_dir", 0, [0]], ["_testHeight", -1, [-1]], ["_target", objnull, [objnull]]];

private _unitPos = getPosATL _unit;
private _samplePosUnit = if (_testHeight > -1) then {
    AGLToASL ([_unitPos select 0, _unitPos select 1, _testHeight])  
} else {
    eyePos _unit
};

private _samplePos = [0,0,0];
if (_target isEqualTo objnull) then {
    private _relPos = _unit getPos [2, _dir];
    _samplePos = if (_testHeight > -1) then {
        AGLToASL [_relPos select 0, _relPos select 1, _testHeight]
    } else {
        private _convGetPos = AGLToASL _relPos;
        [_convGetPos select 0, _convGetPos select 1, eyePos _unit select 2]
    };
} else {
    _samplePos = getPosASL _target
};

private _cansee = (([_unit, "VIEW", objNull] checkVisibility [_samplePosUnit, _samplePos]) >= 0.1);

_cansee