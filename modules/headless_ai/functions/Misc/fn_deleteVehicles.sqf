#include "script_component.hpp"


params ["_arr"];

_arr select {
    !(_x isKindOf "Logic")
} apply {
    private _vehicle = _x;
    private _tracked = EGETVAR(_vehicle,FW,Tracked,false);
    {
        private _object = _x;
        detach _object;
        deleteVehicle _object;
        private _tracked = EGETVAR(_object,FW,Tracked,false);
        if (_tracked) then {
            if (GETMVAR(VerboseDebug,false)) then {
                TRACE_2("deleting HC Synced tracked",_object, side _object);
            };
            [QEGVAR(FW,untrackEvent), [_object, side _object]] call CBA_fnc_serverEvent;
        };
    } foreach attachedObjects _vehicle;
    deleteVehicle _vehicle;
    if (GETMVAR(VerboseDebug,false)) then {
        TRACE_2("deleting HC Synced object",_vehicle, _tracked);
    };
    if (_tracked) then {
        if (GETMVAR(VerboseDebug,false)) then {
            TRACE_2("deleting HC Synced tracked",_vehicle, side _vehicle);
        };
        [QEGVAR(FW,untrackEvent), [_vehicle, side _vehicle]] call CBA_fnc_serverEvent;
    };
};
