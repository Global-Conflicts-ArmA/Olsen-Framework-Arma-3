#include "script_component.hpp"

params ["_note",["_silent", false]];
if (isNil "_note") then {_note = player getVariable [QGVAR(activeNote), objNull]};

//ground note
if (typeName _note == "OBJECT") then {
    if (isNull _note) exitWith {hint "Jemand ist mir zuvorgekommen."};
    deleteVehicle _note;
};

//inventory note
if (typeName _note == "SCALAR") then {
    [_note, "remove"] call FUNC(updateMyNotes);
};

if (!_silent) then {
    private _sounds = [
        QGVAR(sounds_rip1),
        QGVAR(sounds_rip2),
        QGVAR(sounds_rip3),
        QGVAR(sounds_rip4)
    ];
    [player, selectRandom _sounds] remoteExec ["say3D", 0, false];
};
