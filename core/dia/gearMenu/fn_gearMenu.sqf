#include "..\..\script_macros.hpp"

params [
    ["_mode", "close", [""]],
    ["_args", ""]
];

[{(findDisplay 500) isNotEqualTo displayNull}, {
    params [
        ["_mode", "close", [""]],
        ["_args", ""]
    ];
    private _display = findDisplay 500;
    TRACE_2("", _mode, _display);

    switch _mode do {
        case "open": {
            private _lbControl = _display displayCtrl 2100;
            TRACE_2("",_display,_lbControl);
            GVAR(UsedGearTypes) apply {
                _lbControl lbAdd _x;
            };
            lbSort _lbControl;
            _lbControl lbSetCurSel 0;
        };
        case "apply": {
            private _lbControl = _display displayCtrl 2100;
            TRACE_2("",_display,_lbControl);
            private _current = lbCurSel _lbControl;
            private _value = _lbControl lbText _current;
            TRACE_2("", _current, _value);
            private _text = format ["Gear type applied: %1", _value];
            [_text, 1.5, ACE_Player, 10] call ace_common_fnc_displayTextStructured;
            [ACE_player, _value] call FUNC(gearScript);
            _display closeDisplay 1
        };
        default {
            _display closeDisplay 1
        };
    };
}, [_mode, _args]] call CBA_fnc_waitUntilAndExecute;
