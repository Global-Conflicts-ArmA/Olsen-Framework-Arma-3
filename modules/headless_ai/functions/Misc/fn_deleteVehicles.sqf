#include "script_component.hpp"


params ["_arr"];

_arr apply {
    private _vehicle = _x;
    if (
        !(_vehicle isKindOf "Logic") &&
        {!isNull _vehicle}
    ) then {
        private _tracked = EGETVAR(_vehicle,FW,Tracked,false);
        TRACE_2("deleting HC Synced object",_vehicle, _tracked);
        TRACE_2("deleting HC Synced tracked",_vehicle, side _vehicle);
        [QEGVAR(FW,untrackEvent), [_vehicle, side _vehicle]] call CBA_fnc_serverEvent;
        {
            private _object = _x;
            detach _object;
            deleteVehicle _object;
        } foreach attachedObjects _vehicle;
        deleteVehicle _vehicle;
    };
};
