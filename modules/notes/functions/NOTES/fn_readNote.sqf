#include "script_component.hpp"

params ["_message", "_note", ["_handwriting", ["",["",""]]]];
private ["_message"];

if (isNil "_note") exitWith {ERROR("_note is nil.")};
if (typeName _note != "OBJECT" && typeName _note  != "SCALAR") exitWith {ERROR(format ["_note is %1, expected object or number.", typeName _note])};

if (typeName _note == "OBJECT") then {
    _message = _note getVariable ["message", ""];
};

player setVariable [QGVAR(activeNote), _note];
["READ", _note, _message, _handwriting] call FUNC(loadUI);
