#include "script_component.hpp"
#include "..\..\settings.sqf"

private _hour = "";
private _min = "";

private _startTextArray = switch (playerSide) do {
	case blufor: {GETMVAR(START_TEXT_ARRAY_BLUFOR, [])};
	case opfor: {GETMVAR(START_TEXT_ARRAY_OPFOR, [])};
	case independent: {GETMVAR(START_TEXT_ARRAY_INDFOR, [])};
	case civilian: {GETMVAR(START_TEXT_ARRAY_CIVFOR, [])};
};

if (_startTextArray isEqualTo []) exitWith {};

private _month = switch (date select 1) do {
	case 1: {"January"};
	case 2: {"February"};
	case 3: {"March"};
	case 4: {"April"};
	case 5: {"May"};
	case 6: {"June"};
	case 7: {"July"};
	case 8: {"August"};
	case 9: {"September"};
	case 10: {"October"};
	case 11: {"November"};
	case 12: {"December"};
};

private _day = format ["%1th", date select 2];

if (((date select 2) mod 10) < 4) then {
	switch ((date select 2) mod 10) do {
		case 1: {_day = format ["%1st", date select 2]};
		case 2: {_day = format ["%1nd", date select 2]};
		case 3: {_day = format ["%1rd", date select 2]};
	};
};

private _h = date select 3;
if (date select 4 == 60) then {_h = _h + 1;};

if (_h < 10) then {
	_hour = "0" + format ["%1", _h];
} else {
	_hour = format ["%1", _h];
};
private _m = date select 4;
if (date select 4 == 60) then {_m = 0};
if (_m < 10) then {
	_min = "0" + format ["%1H", _m];
} else {
	_min = format ["%1H", _m];
};

private _unparsedText = "<t align='right' size='1.2'>";

_startTextArray apply {
    private _line = _x;
    _line params [
        ["_type", "", [""]],
        ["_value", "", [""]]
    ];

    switch _type do {
		case "TITLEQUOTE": {
			_unparsedText = _unparsedText + format ["<t font='PuristaBold' size='1.6'>""%1""</t>", _value];
		};
		case "TITLE": {
			_unparsedText = _unparsedText + format ["<t font='PuristaBold' size='1.6'>%1</t>", _value];
		};
		case "TEXT": {
			_unparsedText = _unparsedText + format ["%1", _value];
		};
		case "DATE": {
			_unparsedText = _unparsedText + format ["%2 %3", _day, _month];
		};
		case "TIME": {
			_unparsedText = _unparsedText + format ["%1", (_hour + _min)];
		};
		case "DATETIME": {
			_unparsedText = _unparsedText + format ["%1, %2 %3", (_hour + _min), _day, _month];
		};
	};

    if (_line isNotEqualTo (_startTextArray select (count _startTextArray - 1))) then {
		_unparsedText = _unparsedText + "<br/>";
	};
};

_unparsedText = _unparsedText + "</t>";

[{
	_this call BIS_fnc_textTiles;
}, [parsetext _unparsedText, true, nil, 10, 0.7, 0], GETMVAR(START_TEXT_DELAY, 10)] call CBA_fnc_waitAndExecute;
