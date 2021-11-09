#include "script_component.hpp"

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

private _playerBriefing = switch (side player) do {
	case west: {_westBriefing};
	case east: {_eastBriefing};
	case independent: {_indBriefing};
	case civilian: {_civBriefing};
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
	player createDiaryRecord _x;
};
