#include "script_component.hpp"

#include "..\..\dialog\defines.hpp"

disableSerialization;
private _dialog = findDisplay LN_DIALOG;
private _editBox = _dialog displayCtrl LN_EDITBOX;
private _message = ctrlText _editBox;
private _handwriting = player getVariable [QGVAR(handwriting),["",["",""]]];

[_message, _handwriting] call FUNC(dropNote);
player setVariable [QGVAR(amount), (player getVariable [QGVAR(amount), 1]) - 1];
