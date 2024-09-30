#include "script_component.hpp"

//unit 1, unit 2
params [
    ["_unit", objNull, [objNull]],
    ["_engageMode", false, [false]],
    ["_target", objNull, [objNull]]
];

private _invisibleTarget = [_unit] call FUNC(targetHelper);

private _getposTarget = getposASL _target;


if (_engageMode) then {
    if (GETMVAR(VerboseDebug,false)) then {
    	LOG_2("_unit: %1 targeting: %2 in normal mode",_unit,_target);
    };
    private _targetPos = [_getposTarget select 0, _getposTarget select 1,(_getposTarget select 2) + (GVAR(AimTargetHeightAdjust))];
    private _laserTarget = GETVAR(_unit,laserTarget,objNull);
    _laserTarget setposASL _getposTarget;
    _invisibleTarget setposASL _targetPos;
    _unit reveal [_invisibleTarget,4];
    _unit doWatch _targetPos;
    _unit doTarget _invisibleTarget;
    [{
        params ["_unit"];
        [_unit, true] call FUNC(targetHelper);
    }, [_unit], 30] call CBA_fnc_waitAndExecute;
} else {
    if (GETMVAR(VerboseDebug,false)) then {
    	LOG_1("_unit: %1 resetting target",_unit);
    };
    if !(_target isNotEqualTo objNull) then {
        _unit reveal [_target, 4];
        _unit doWatch _getposTarget;
        _unit doTarget _target;
    };
    [_unit, true] call FUNC(targetHelper);
};

true
