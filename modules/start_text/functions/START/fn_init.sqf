#include "script_component.hpp"
#include "..\..\settings.sqf"

private _hour = "";
private _min = "";

private _startTextArray = switch (playerSide) do {
	case blufor: {GETMVAR(ARRAY_BLUFOR, [])};
	case opfor: {GETMVAR(ARRAY_OPFOR, [])};
	case independent: {GETMVAR(ARRAY_INDFOR, [])};
	case civilian: {GETMVAR(ARRAY_CIVFOR, [])};
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

private _day = switch ((date select 2)) do {
	case 1: {format ["%1st", date select 2]};
	case 2: {format ["%1nd", date select 2]};
	case 3: {format ["%1rd", date select 2]};
    default {format ["%1th", date select 2]};
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

{
    private _line = _x;
    _line params [
        ["_type", "", [""]],
        ["_value", "", [""]],
        ["_size", 1.2, [0]],
        ["_font", "PuristaBold", [""]]
    ];

    _size = str _size;

    switch _type do {
		case "TEXTQUOTE": {
			_unparsedText = _unparsedText + "<t font='" + _font + "' size='" + _size + "'>'" + _value + "'</t>";
		};
		case "TEXT": {
            _unparsedText = _unparsedText + "<t font='" + _font + "' size='" + _size + "'>" + _value + "</t>";
		};
		case "DATE": {
            _unparsedText = _unparsedText + "<t font='" + _font + "' size='" + _size + "'>" + _day + " " + _month + "</t>";
		};
		case "TIME": {
            _unparsedText = _unparsedText + "<t font='" + _font + "' size='" + _size + "'>" + _hour + _min + "</t>";
		};
		case "DATETIME": {
            _unparsedText = _unparsedText + "<t font='" + _font + "' size='" + _size + "'>" + _hour + _min + ", " + _day + " " + _month + "</t>";
		};
	};

    if (_forEachIndex < (count _startTextArray - 1)) then {
		_unparsedText = _unparsedText + "<br/>";
	};

} forEach _startTextArray;

_unparsedText = _unparsedText + "</t>";

TRACE_1("",_unparsedText);

[{
    _this call BIS_fnc_textTiles;
}, [parsetext _unparsedText, true, nil, 10, 0.7, 0], GETMVAR(delay, 5)] call CBA_fnc_waitAndExecute;
