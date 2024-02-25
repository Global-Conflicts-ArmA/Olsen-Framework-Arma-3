#include "script_component.hpp"

params [
    ["_side", blufor, [blufor]],
    ["_testMode", false, [false]]
];

if !(_testMode) then {
    _side = side player;
} else {
    GVAR(DiaryRecords) apply {
        ACE_Player removeDiaryRecord ["Diary", _x];
    };
};

#define NEWTAB(NAME) _briefing set [count _briefing, ["Diary",[NAME,"
#define ENDTAB "]]];

private _briefing = [];
#include "..\..\customization\briefings\blufor.sqf"
private _westBriefing = _briefing;

private _briefing = [];
#include "..\..\customization\briefings\opfor.sqf"
private _eastBriefing = _briefing;

private _briefing = [];
#include "..\..\customization\briefings\indfor.sqf"
private _indBriefing = _briefing;

private _briefing = [];
#include "..\..\customization\briefings\civilian.sqf"
private _civBriefing = _briefing;

private _playerBriefing = switch _side do {
	case west: {_westBriefing};
	case east: {_eastBriefing};
	case independent: {_indBriefing};
	default {_civBriefing};
};

private _briefing = [];
#include "..\..\customization\briefings\missionNotes.sqf"
private _missionNotes = _briefing;

private _briefing = [];
#include "..\..\customization\briefings\changelog.sqf"
private _changeLog = _briefing;

_playerBriefing append _missionNotes;
_playerBriefing append _changeLog;

if (!isNil "uo_fnc_hasGMAccess" && {call uo_fnc_hasGMAccess}) then {
	private _briefing = [];
	#include "..\..\customization\briefings\adminNotes.sqf"
	private _adminNotes = _briefing;

	_playerBriefing append _adminNotes;
};

reverse _playerBriefing;
_playerBriefing apply {
	private _record = player createDiaryRecord _x;
    GVAR(DiaryRecords) pushBackUnique _record;
};
