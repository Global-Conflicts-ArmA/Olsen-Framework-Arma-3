// AUTHOR: StatusRed
#include "script_component.hpp"

params ["_teamCombo", "_text", "_control", "_selectedIndex"];

private _textHeightModifier = 0.05;
private _safeZoneModifier = 0.671968;
private _height = (ctrlTextHeight _text + _textHeightModifier);
private _safeZoneHeight = (_safeZoneModifier * safezoneH);

private _name = _control lbText _selectedIndex;
private _activeEntryListIndex = GETVAR(_teamCombo,activeEntryListIndex,0);
private _entryListEntries = GVAR(allBriefings) select _activeEntryListIndex;
_entryListEntries apply {
    _x params ["_entryName", "_entryText"];
    if (_name isEqualTo _entryName) exitwith {
        _text ctrlSetStructuredText parseText _entryText;
        _text ctrlSetPositionH (_height max _safeZoneHeight);
        _text ctrlCommit 0;
    };
};
false
