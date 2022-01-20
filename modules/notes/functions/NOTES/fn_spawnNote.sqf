#include "script_component.hpp"

params ["_requestedPos", "_requestedDir", "_message", "_handwriting"];

private _note = createVehicle [GVAR(noteObject), _requestedPos, [], 0, "NONE"];
_note setPos _requestedPos;
_note setVectorUp surfaceNormal _requestedPos;
_note setDir _requestedDir;

_note setVariable ["message", _message, true];
_note setVariable ["handwriting", _handwriting, true];

[_note] remoteExec [QGVAR(fnc_initNote), 0, true];
