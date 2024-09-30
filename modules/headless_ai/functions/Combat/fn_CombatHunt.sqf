#include "script_component.hpp"

params ["_group", "_targetPos", ["_radius", 50, [0]]];
TRACE_1("combatHunt started",_this);

units _group apply {
    private _unit = _x;
    doStop _x;
    _unit setCombatBehaviour "COMBAT";
    [{
        params ["_argNested", "_idPFH"];
        _argNested params [
            "_unit",
            "_targetPos",
            "_radius"
        ];
        if (
            !([_unit] call FUNC(isAlive)) ||
            (group _unit getVariable [QGVAR(Task), "PATROL"]) isNotEqualTo "HUNT"
        ) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _closestEnemy = [_unit] call FUNC(closestEnemy);
        if (_closestEnemy distance2D _targetPos < _radius) then {
            // detect in sight enemies first
            private _enemyArray = [side _unit] call FUNC(EnemyArray);
            private _enemyArrayIndex = _enemyArray findIf {
                _x distance _unit <= _radius &&
                [_unit, _x] call FUNC(LOSCheck)
            };
            if (_enemyArrayIndex isNotEqualTo -1) then {
                private _chosenEnemy = _enemyArray select _enemyArrayIndex;
                private _inBuilding = insideBuilding _chosenEnemy >- 0.4;
                private _isVehicle = vehicle _chosenEnemy isNotEqualTo _chosenEnemy;
                if (
                    _isVehicle || _inBuilding &&
                    {[_unit] call FUNC(hasAT)}
                ) then {
                    [_unit, _chosenEnemy] call FUNC(fireAT);
                } else {
                    private _muzzle = _unit call FUNC(hasUGL);
                    if (_muzzle isNotEqualTo "") then {
                        [_unit, _muzzle, _chosenEnemy] call FUNC(fireUGL);
                    };
                };
            } else {
                _unit setUnitpos "UP";
            	_unit doMove (getposATL _closestEnemy);
            };
        };
    }, 1, [
        _unit,
        _targetPos,
        _radius
    ]] call CBA_fnc_addPerFrameHandler;
};
