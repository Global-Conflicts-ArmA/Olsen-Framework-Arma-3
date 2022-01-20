#include "script_component.hpp"

params [
    ["_area", "", [""]],
    ["_waitTime", 30, [30]],
    ["_sides", [west], [[]]]
];

if (getMarkerColor _area isEqualto "") exitWith {
    ERROR_1("Setup Area marker %1 does not exist!",_area);
};
if (_waitTime < 30) exitWith {
    ERROR_1("Setup Area %1 wait timer must be at least 30 seconds!",_area);
};

GVAR(SetupTimers) pushBackUnique [_area, _waitTime, _sides];
