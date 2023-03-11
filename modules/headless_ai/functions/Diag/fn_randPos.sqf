#include "script_component.hpp"

/*
 * Author: PiZZADOX
 * Generates a random position based on condition options. Extension of CBA_fnc_randPos function.
 *
 * Arguments:
 * 0: Position <POSITION or OBJECT>
 * 1: Radius <NUMBER>
 * 2: Road Mode ("NO", "YES", "ANY") <STRING>
 * 3: Water Mode ("NO", "YES", "ANY") <STRING>
 *
 * Return Value:
 * Position <POSITION>
 *
 * Example:
 * [player, 50] call ace_[module]_fnc_[functionName]
 *
 * Public: No
 */

params [
    ["_pos", [0,0,0], [[], objNull]],
    ["_radius", 30, [0]],
    ["_road", "NO", [""]],
    ["_water", "NO", [""]]
];

if (_pos isEqualType objNull) then {
    _pos = getPosATL _pos;
};

private _randomPos = [0,0,0];

for "_i" from 0 to 30 step 1 do {
    private _tempPos =  [_pos, _radius] call CBA_fnc_randPos;
    if (
        (_road isEqualTo "ANY" ||
        (isOnRoad _tempPos && {_road in ["YES"]}) ||
        (!isOnRoad _tempPos && {_road in ["NO"]})) &&
        {
            _water isEqualTo "ANY" ||
            (surfaceIsWater _tempPos && {_water in ["YES"]}) ||
            (!surfaceIsWater _tempPos && {_water in ["NO"]})
        }
    ) exitWith {
        _randomPos = _tempPos;
    };
};

if (_randomPos isEqualTo [0,0,0]) then {
    TRACE_1("Failed to generate good position",_pos);
};

_randomPos
