#include "script_component.hpp"

params ["_message"];
if (_message == "") exitWith {private _name = "Empty Note"; _name};

private _maxChars = 10;
private _name = "";
private _done = false;
private _words = _message splitString " ";

//add first word
if (count (_words select 0) < _maxChars) then {
    _name = _name + (_words select 0);

//first word is too big
} else {
    private _firstWordArray = toArray (_words select 0);
    _firstWordArray resize _maxChars;
    _name = toString _firstWordArray;
    _name = _name + "...";
};
if (count _name >= _maxChars) exitWith {_name};

//add more words
for "_i" from 0 to (count _words - 1) step 1 do {
    private _word = _words select _i;
    if (count _name + count _word < _maxChars) then {
        _name = _name + " " + _word;
    } else {
        _name = _name + "...";
        _done = true;
    };
    if (_done) exitWith {};
};

_name
