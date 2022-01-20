#include "script_component.hpp"

params ["_target", "_caller", "_args"];
_args params ["_noteID", "_message", "_handwriting"];

[_noteID, "remove", _message, _handwriting] call FUNC(updateMyNotes);
[_target, _caller, _message, _handwriting] remoteExec [QGVAR(fnc_receiveNote),0,false];
[] call FUNC(playGiveAnimation);
