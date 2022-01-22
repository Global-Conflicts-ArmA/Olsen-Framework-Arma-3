#include "script_component.hpp"

params ["_message", "_note", ["_handwriting", ["",["",""]]]];

if (isNil "_note") exitWith {ERROR("_note is nil.")};
if (!(_note isEqualType objNull) && {!(_note isEqualType 0)}) exitWith {
    ERROR_1("_note is %1, expected object or number.", typeName _note);
};

if (_note isEqualType objNull) then {
    _message = _note getVariable ["message", ""];
};

player setVariable [QGVAR(activeNote), _note];
["READ", _note, _message, _handwriting] call FUNC(loadUI);
