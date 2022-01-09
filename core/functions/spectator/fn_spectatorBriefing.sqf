#include "script_component.hpp"

params ["_mode", ["_args", [], [[]]]];
//TRACE_2("",_mode,_args);

private _controls = GETMVAR(SpectatorBriefingDisplayControls,[]);
if (_controls isEqualTo [] && {!isNull findDisplay 60492}) exitwith {
    //[] call FUNC(initSpectateScreen);
};
_controls params ["_controlGroup", "_frame", "_teamCombo", "_entryList", "_text"];
_args params [
  ["_control", _teamCombo, [_teamCombo]],
  ["_selectedIndex", 0, [0]]
];

switch (toUpper _mode) do {
    case "SHOW": {
        [_entryList, _text, _control, _selectedIndex] call FUNC(handleComboBoxChange);
        [_teamCombo, _text, _control, _selectedIndex] call FUNC(handleListChange);

        _controls apply {
            _x ctrlShow true
        };
        SETMVAR(SpectatorBriefingDisplayOpen,true);
    };
    case "HIDE": {
        _controls apply {
            _x ctrlShow false
        };
        SETMVAR(SpectatorBriefingDisplayOpen,false);
    };
    case "COMBOCHANGE": {
        [_entryList, _text, _control, _selectedIndex] call FUNC(handleComboBoxChange);
    };
    case "LISTCHANGE": {
        [_teamCombo, _text, _entryList, _selectedIndex] call FUNC(handleListChange);
    };
    default {false};
};
