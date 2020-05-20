#include "script_component.hpp"

private _briefing = [];

#define NEWTAB(NAME) _briefing set [count _briefing, ["Diary",[NAME,"
#define ENDTAB "]]];

switch (side player) do {
	case west: {
		#include "..\..\customization\briefings\blufor.sqf"
	};
	case east: { 
		#include "..\..\customization\briefings\opfor.sqf"
	};
	case independent: {
		#include "..\..\customization\briefings\indfor.sqf"
	};
	case civilian: {
		#include "..\..\customization\briefings\civilian.sqf"
	};
};
	
#include "..\..\customization\briefings\missionNotes.sqf"

private _size = count _briefing - 1;
for '_i' from 0 to _size step 1 do {
	player createDiaryRecord (_briefing select _size - _i);
};