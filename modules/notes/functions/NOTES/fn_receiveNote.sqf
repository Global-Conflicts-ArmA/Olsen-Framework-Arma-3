#include "script_component.hpp"

params ["_target", "_caller", "_message", "_handwriting"];

if (player isNotEqualTo _target) exitWith {};

hint format ["You have received a note from %1.", name _caller];
[(player getVariable [QGVAR(notesHandled), 0]) + 1,"add", _message, _handwriting] call FUNC(updateMyNotes);
