#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_direction", 0, [0]],
    ["_timeToSuppress", 3, [3]]
];

private _invisibleTarget = [_unit] call FUNC(targetHelper);

private _relpos = _unit getPos [40, _direction];
private _laserPos = [(_relpos) select 0, (_relpos) select 1, (((getposASL _unit)) select 2) + 1.5];
_invisibleTarget setposASL _laserPos;
_unit reveal [_invisibleTarget, 4];
_unit doWatch _laserPos;
_unit doTarget _invisibleTarget;
_unit doSuppressiveFire _laserPos;

[{
    params ["_argNested", "_idPFH"];
    _argNested params ["_unit", "_timeStart", "_timeToSuppress"];
    if (CBA_MissionTime >= _timeStart + _timeToSuppress) exitWith {
        private _invisibleTarget = GETVAR(_unit,InvisibleTarget,objNull);
        _invisibleTarget setPosASL [0,0,0];
        _unit doTarget objNull;
        _unit doWatch objNull;
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _otherFriendlies = (units group _unit) - [_unit];
    if (({
            !([getPosATL _unit, getDir _unit, 5, getPosATL _x] call BIS_fnc_inAngleSector)
        } forEach _otherFriendlies) && {_unit call FUNC(isAimed)}) then {
        [_unit] call FUNC(fireWeapon);
        [{
            params ["_unit"];
            [_unit] call FUNC(fireWeapon);
        }, [_unit], 0.15] call CBA_fnc_waitAndExecute;
    };
}, 0.25, [_unit, CBA_MissionTime, _timeToSuppress]] call CBA_fnc_addPerFrameHandler;
