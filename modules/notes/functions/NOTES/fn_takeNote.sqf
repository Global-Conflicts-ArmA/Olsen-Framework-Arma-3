#include "script_component.hpp"

params ["_note"];

private _message = _note getVariable ["message", ""];
private _handwriting = _note getVariable ["handwriting", ["",["",""]]];
deleteVehicle _note;

[(player getVariable [QGVAR(notesHandled), 0]) + 1, "add", _message, _handwriting] call FUNC(updateMyNotes);
