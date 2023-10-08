#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_direction", 0, [0, []]],
    ["_timeToSuppress", 3, [3]],
    ["_chosenMuzzle", [], [[]]]
];

private _invisibleTarget = [_unit] call FUNC(targetHelper);

private _targetPos = if (_direction isEqualType []) then {
    _direction
} else {
    private _relpos = _unit getPos [200, _direction];
    [(_relpos) select 0, (_relpos) select 1, (((getposASL _unit)) select 2) + 1.5]
};

_invisibleTarget setposASL _targetPos;
_unit reveal [_invisibleTarget, 4];
_unit doWatch _invisibleTarget;
_unit lookAt _invisibleTarget;
_unit doTarget _invisibleTarget;

[{
    params ["_argNested", "_idPFH"];
    _argNested params ["_unit", "_timeStart", "_timeToSuppress"];
    if (
        CBA_MissionTime >= _timeStart + _timeToSuppress || 
        !(_unit call EFUNC(FW,isAlive))
    ) exitWith {
        [_unit, true] call FUNC(targetHelper);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _otherFriendlies = (units group _unit) - [_unit];
    if (
        (vehicle _unit isNotEqualTo _unit ||
        ({
            !([getPosATL _unit, getDir _unit, 5, getPosATL _x] call BIS_fnc_inAngleSector)
        } forEach _otherFriendlies)) && 
        {_unit call FUNC(isAimed)}
    ) then {
        [_unit, _chosenMuzzle] call FUNC(fireWeapon);
        [{
            params ["_unit"];
            [_unit, _chosenMuzzle] call FUNC(fireWeapon);
        }, [_unit], 0.15] call CBA_fnc_waitAndExecute;
    };
}, 0.25, [_unit, CBA_MissionTime, _timeToSuppress]] call CBA_fnc_addPerFrameHandler;
