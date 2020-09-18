#include "script_component.hpp"

params ["_string"];

if !(_string find "<marker name=" isEqualTo -1) then {
    private _lastIndex = 0;
    private _offset = 13;
    _string = [_string, "</marker>", ""] call CBA_fnc_replace;
    for "_i" from 0 to 8 step 1 do {
        private _index = ([_string, "<marker name=", _lastIndex] call CBA_fnc_find);
        if (_index isEqualTo -1) exitWith {};
        private _beforeStr = (_string select [0, _index]);
        private _symbolIndex = ([_string, "'>", _index + _offset] call CBA_fnc_find);
        if (_symbolIndex isEqualTo -1) exitWith {};
        if (_symbolIndex - (_index + _offset) <= 14) then {
            private _result = _string select [_symbolIndex + 2];
            _string = _beforeStr + _result;
            _lastIndex = _symbolIndex + 2;
        } else {
            _lastIndex = (_index + _offset);
        };
    };
};

if !(_string find "<img" isEqualTo -1) then {
    private _lastIndex = 0;
    private _offset = 6;
    for "_m" from 0 to 8 step 1 do {
        private _indexImg = ([_string, "<img", _lastIndex] call CBA_fnc_find);
        if (_indexImg isEqualTo -1) exitWith {};
        private _sizeIndex = ([_string, "size='", _indexImg] call CBA_fnc_find);
        if (!(_sizeIndex isEqualTo -1) && {_sizeIndex - _indexImg <= 10}) then {
            private _numCount = 1;
            for "_i" from 0 to 4 step 1 do {
                private _char = _string select [_sizeIndex + _i, 1];
                if (_char in ["1","2","3","4","5","6","7","8","9","0"]) then {
                    _numCount = _numCount + 1;
                };
            };
            private _newSize = if (_numCount == 1) then {
                8
            } else {
                (4 * (parseNumber (_string select [_sizeIndex, _numCount]))) min 16;
            };
            private _beforeStr = (_string select [0, _sizeIndex + _offset]) + str _newSize;
            private _result = _string select [_sizeIndex + _offset + (count str _newSize)];
            _string = _beforeStr + _result;
            _lastIndex = _sizeIndex + _offset + _numCount;
        } else {
            private _beforeStr = (_string select [0, _indexImg + 4]) + " size='15'";
            private _result = (_string select [_indexImg + 4]);
            _string = _beforeStr + _result;
            _lastIndex = _indexImg + 4;
        };
    };
};

if !(_string find "<font" isEqualTo -1) then {
    private _beforeStr = "";
    private _result = "";
    private _lastIndex = 0;
    private _offset = 6;
    for "_m" from 0 to 8 step 1 do {
        private _indexFont = ([_string, "<font", _lastIndex] call CBA_fnc_find);
        if (_indexFont isEqualTo -1) exitWith {};
        private _sizeIndex = ([_string, "size='", _indexFont] call CBA_fnc_find);
        if (_sizeIndex isEqualTo -1 || {_sizeIndex - _indexFont > 30}) exitWith {};
        private _numCount = 1;
        for "_i" from 0 to 4 step 1 do {
            private _char = _string select [_sizeIndex + _i, 1];
            if !(_char in ["1","2","3","4","5","6","7","8","9","0"]) exitWith {};
            _numCount = _numCount + 1;
        };
        private _number = if (_numCount == 1) then {
            2
        } else {
            parseNumber (_string select [_sizeIndex, _numCount]);
        };
        private _newSize = (_number / 8) max 1.25;
        private _newSizeCount = count str _newSize;
        _beforeStr = (_string select [0, _sizeIndex + _offset]) + str _newSize;
        _result = _string select [_sizeIndex + _offset + (_newSizeCount - 2) - 1];
        _string = _beforeStr + _result;
        _lastIndex = _sizeIndex + _numCount;
    };
    _string = [_string, "<font", "<t"] call CBA_fnc_replace;
    _string = [_string, "</font>", "</t>"] call CBA_fnc_replace;
    _string = [_string, "face=", "font="] call CBA_fnc_replace;
};
_string = "<br/><br/>" + _string;
_string