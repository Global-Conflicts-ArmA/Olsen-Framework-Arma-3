#include "script_component.hpp"

params ["_note",["_silent", false]];
if (isNil "_note") then {_note = player getVariable [QGVAR(activeNote), objNull]};

//ground note
if (_note isEqualType objNull) then {
    if (isNull _note) exitWith {hint "Cannot find note."};
    deleteVehicle _note;
};

//inventory note
if (_note isEqualType 0) then {
    [_note, "remove"] call FUNC(updateMyNotes);
};

if !(_silent) then {
    private _sound =  selectRandom [
        getMissionPath "modules\notes\sounds\rip1.ogg",
        getMissionPath "modules\notes\sounds\rip2.ogg",
        getMissionPath "modules\notes\sounds\rip3.ogg",
        getMissionPath "modules\notes\sounds\rip4.ogg"
    ];
    playSound3D [_sound, player, false];
};
