// AUTHOR: StatusRed
#include "script_component.hpp"

params ["_entryList", "_text", "_control", "_selectedIndex"];

private _textHeightModifier = 0.05;
private _safeZoneModifier = 0.671968;
private _height = (ctrlTextHeight _text + _textHeightModifier);
private _safeZoneHeight = (_safeZoneModifier * safezoneH);

private _name = _control lbText _selectedIndex;
/* LOG_1("Selected briefing = %1", _name); */
private _activeEntryListIndex = switch _name do {
    case (GETMVAR(TeamName_Blufor,"BLUFOR")): {0};
    case (GETMVAR(TeamName_Opfor,"OPFOR")): {1};
    case (GETMVAR(TeamName_Indfor,"INDFOR")): {2};
    case (GETMVAR(TeamName_Civ,"CIVILIAN")): {3};
    case "Mission Notes": {4};
    case "Changelog": {5};
    default {5};
};
/* LOG_1("Active index = %1", _activeEntryListIndex); */
private _entryListEntries = GVAR(allBriefings) select _activeEntryListIndex;
SETVAR(_control,activeEntryListIndex,_activeEntryListIndex);
lbClear _entryList;
_entryListEntries apply {
    _entryList lbAdd (_x select 0);
};
_entryList lbSetCurSel 0;
private _string = ((_entryListEntries select 0) select 1);
_text ctrlSetStructuredText parseText _string;
_text ctrlSetPositionH (_height max _safeZoneHeight);
_text ctrlCommit 0;
false
