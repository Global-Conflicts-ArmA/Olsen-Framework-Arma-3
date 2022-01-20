#include "script_component.hpp"

#include "..\..\dialog\defines.hpp"

private _note = player getVariable [QGVAR(activeNote), objNull];

//take
if (_note isEqualType objNull) then {
    if (isNull _note) exitWith {hint "Somebody already took it."};

    [_note, true] call FUNC(destroyNote);
    private _message = _note getVariable ["message", ""];
    private _handwriting = _note getVariable ["handwriting", ["",["",""]]];
    [(player getVariable [QGVAR(notesHandled), 0]) + 1, "add", _message, _handwriting] call FUNC(updateMyNotes);
};

//drop
if (_note isEqualType 0) then {
    private _nodeName = format ["GVAR(myNotes_)%1", _note];
    private _message = player getVariable [_nodeName + "_message", ""];
    private _handwriting = player getVariable [_nodeName + "_handwriting", ["", ["",""]]];
    [_note, "remove"]call FUNC(updateMyNotes);
    [_message, _handwriting] call FUNC(dropNote);
};
