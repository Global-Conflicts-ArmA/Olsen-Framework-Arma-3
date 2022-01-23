#include "script_component.hpp"

params [
    ["_area", "", [""]],
    ["_waitTime", 30, [30]],
    ["_sides", sideUnknown, [sideUnknown, []]]
];

if (markerShape _area isEqualto "") exitWith {
    ERROR_1("Setup Area marker %1 does not exist!",_area);
};
if (_waitTime < 30) exitWith {
    ERROR_1("Setup Area %1 wait timer must be at least 30 seconds!",_area);
};
if (_sides isEqualto []) then {
    _sides = [west, east, independent, civilian];
};
if (_sides isEqualType sideUnknown) then {
    if (_sides isEqualto sideUnknown) then {
        _sides = [west, east, independent, civilian];
    } else {
        _sides = [_sides];
    };
};

GVAR(SetupTimers) pushBackUnique [_area, _waitTime, _sides];
LOG_1("added to setupTimers array: %1", GVAR(SetupTimers));
