#include "script_component.hpp"

params [
    ["_group", grpNull, [grpNull]]
];

_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";

[{
    params ["_argNested", "_idPFH"];
    _argNested params ["_group"];
    private _leader = leader _group;
    // exit loiter upon enemy contact
    if (
        behaviour _leader in ["COMBAT","STEALTH"] &&
        {_leader findNearestEnemy _leader isNotEqualTo objNull}
    ) then {
        [_group, _leader findNearestEnemy _leader] call FUNC(CombatResponse);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    // choose random actions for units to do
    units _group apply {
        private _unit = _x;
        _unit setUnitPos "AUTO";
        doStop _unit;
        private _selectedAction =
        if (GETVAR(_unit,Sitting,false)) then {
            if (RNG(0.9)) then {
                "Sitting"
            } else {
                selectRandom ["Wander", "Building"];
            };
        } else {
            selectRandom ["Wander", "SitDown", "Building"];
        };
        switch _selectedAction do {
            case "Sitting": {
                // continue sitting
            };
            case "SitDown": {
                private _pos = [getPosATL _unit, 5 + random 10, "NO", "NO"] call FUNC(randPos);
                _unit doMove _pos;
                [{
                    params ["_unit", "_pos"];
                    _unit distance _pos <= 2
                }, {
                    params ["_unit", "_pos"];
                    _unit action ["SitDown", _unit];
                    SETVAR(_unit,Sitting,true);
                }, [_unit, _pos], 8, {}] call CBA_fnc_waitUntilAndExecute;
            };
            // default wander
            default {
                private _pos = [getPosATL _unit, 5 + random 10, "NO", "NO"] call FUNC(randPos);
                _unit doMove _pos;
                [{
                    params ["_unit", "_pos"];
                    _unit distance _pos <= 2
                }, {
                    params ["_unit", "_pos"];
                    private _randomAnim = selectRandom ["Acts_CivilTalking_1","Acts_CivilTalking_2", "Acts_CivilIdle_1", "Acts_CivilIdle_2", "Acts_ShieldFromSun_loop"];
                    [_unit, _randomAnim, 1] call ace_common_fnc_doAnimation;
                }, [_unit, _pos], 8, {}] call CBA_fnc_waitUntilAndExecute;
            };
        };
    };
}, 10, [_group]] call CBA_fnc_addPerFrameHandler;
