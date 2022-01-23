#include "script_component.hpp"

#include "..\..\dialog\defines.hpp"

disableSerialization;
private _dialog = findDisplay LN_DIALOG;
private _editBox = _dialog displayCtrl LN_EDITBOX;
private _message = ctrlText _editBox;

private _noteID = (player getVariable [QGVAR(notesHandled), 0]) + 1;
private _handwriting = player getVariable [QGVAR(handwriting),["", ["",""]]];

[_noteID, "add", _message, _handwriting] call FUNC(updateMyNotes);
player setVariable [QGVAR(amount), (player getVariable [QGVAR(amount), 1]) - 1];
