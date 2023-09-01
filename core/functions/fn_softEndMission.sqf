#include "script_component.hpp"

params [
    ["_endText", "", [""]],
    ["_warnText", "", [""]],
    ["_time", 10, [0]]
];

if (_warnText isEqualTo "") then {
    _warnText = _endText;
};

private _endMission = !(_time isEqualTo -1);

if (_time < 5) then {
    _time = 5;
};

[[_warnText, _time], {
    params ["_warnText", "_time"];
    [
        _warnText,
        0,
        0.25,
        _time,
        1
    ] spawn BIS_fnc_dynamicText;
}] remoteExec ["BIS_fnc_call", 0, true];

if (_endMission) then {
    [{
        _this call FUNC(endMission);
    }, [_endText], _time] call CBA_fnc_waitAndExecute;
};
