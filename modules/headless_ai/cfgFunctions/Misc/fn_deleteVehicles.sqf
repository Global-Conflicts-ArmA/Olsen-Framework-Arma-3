#include "..\..\script_macros.hpp"


params ["_arr"];

{
    private _vehicle = _x;
    if (!(_vehicle isKindOf "Logic") && {!isNull _vehicle}) then {
        if (_vehicle getVariable ["FW_Tracked", false]) then {
            ["FW_eventUntrack", [_vehicle]] call CBA_fnc_serverEvent;
        };
        {
            private _object = _x;
            detach _object;
            deleteVehicle _object;
        } foreach attachedObjects _vehicle;
        deleteVehicle _vehicle;
        deleteGroup (group _vehicle);
    };
} forEach _arr;
