#include "script_component.hpp"

params [
    "_group",
    "_pos",
    ["_radius",100,[0]]
];

//[_group, _pos, _radius] call CBA_fnc_taskDefend;

private _blgPos = [_pos, _radius, true] call FUNC(getBuildings);
private _firstPos = _blgPos select 0;

doStop units _group;

units _group select {
    !(INVEHICLE(_x))
} apply {
    private _unitPos = if (_blgPos isEqualTo []) then {_firstPos} else {_blgPos deleteAt 0};
    [
        {
            params ["_unit", "_pos"];
            _unit moveTo _pos;
            _unit setDestination [_pos, "LEADER PLANNED", true];
        }, [_x, _unitPos], 0.5 + random 2
    ] call CBA_fnc_waitAndExecute;
};
