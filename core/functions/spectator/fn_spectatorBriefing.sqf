#include "script_component.hpp"

params ["_mode", ["_args", [], [[]]]];
//TRACE_2("",_mode,_args);

private _controls = GETMVAR(SpectatorBriefingDisplayControls,[]);
if (_controls isEqualTo [] && {!isNull findDisplay 60492}) exitwith {
    //[] call FUNC(initSpectateScreen);
};
_controls params ["_controlGroup", "_frame", "_teamCombo", "_entryList", "_text"];

switch (toUpper _mode) do {
    case "SHOW": {
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
        _args params ["_control", "_selectedIndex"];
        private _name = _control lbText _selectedIndex;
        private _activeEntryListIndex = switch _name do {
            case (GETMVAR(TeamName_Blufor,"BLUFOR")): {0};
            case (GETMVAR(TeamName_Opfor,"OPFOR")): {1};
            case (GETMVAR(TeamName_Indfor,"INDFOR")): {2};
            case (GETMVAR(TeamName_Civ,"CIVILIAN")): {3};
            case "Mission Notes": {4};
            default {4};
        };
        private _entryListEntries = GVAR(allBriefings) select _activeEntryListIndex;
        SETVAR(_control,activeEntryListIndex,_activeEntryListIndex);
        lbClear _entryList;
        _entryListEntries apply {
            _entryList lbAdd (_x select 0);
        };
        _entryList lbSetCurSel 0;
        private _string = ((_entryListEntries select 0) select 1);
        _text ctrlSetStructuredText parseText _string;
        _text ctrlSetPositionH ((ctrlTextHeight _text + 0.05) max (0.671968 * safezoneH));
        _text ctrlCommit 0;
        false
    };
    case "LISTCHANGE": {
        _args params ["_control", "_selectedIndex"];
        private _name = _control lbText _selectedIndex;
        private _activeEntryListIndex = GETVAR(_teamCombo,activeEntryListIndex,0);
        private _entryListEntries = GVAR(allBriefings) select _activeEntryListIndex;
        _entryListEntries apply {
            _x params ["_entryName", "_entryText"];
            if (_name isEqualTo _entryName) exitwith {
                _text ctrlSetStructuredText parseText _entryText;
                _text ctrlSetPositionH ((ctrlTextHeight _text + 0.05) max (0.671968 * safezoneH));
                _text ctrlCommit 0;
            };
        };
        false
    };
    default {false};
};

