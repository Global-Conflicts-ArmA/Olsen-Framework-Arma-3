#include "script_component.hpp"

params ["_message", "_handwriting"];
if (surfaceIsWater getPos player) exitWith {
    [(player getVariable [QGVAR(notesHandled), 0]) + 1, "add", _message, _handwriting] call FUNC(updateMyNotes);
    hint "It would get wet here. Your note has been saved instead.";
};

private _notePos = player getRelPos [GVAR(playerDistance), 0];
[_notePos, (getDir player)-90, _message, _handwriting] remoteExec [QFUNC(spawnNote), 2, false];
