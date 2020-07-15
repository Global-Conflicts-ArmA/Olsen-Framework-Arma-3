#include "script_component.hpp"

params [["_text", ""], ["_size", 1.5, [0]], ["_target", ACE_player, [objNull]], ["_width", 10, [0]]];

if !(_text isEqualType "TEXT") then {
    _text = parseText format _text;
};

[_text, _size, _target, _width] call ace_common_fnc_displayTextStructured;
