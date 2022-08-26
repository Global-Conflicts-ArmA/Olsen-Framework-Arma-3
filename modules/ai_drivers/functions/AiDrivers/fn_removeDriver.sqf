#include "script_component.hpp"

params ["_target"];

private _driver = GETVAR(_target,driver,objnull);
[false] call FUNC(ToggleDriverCam);

if !(_driver isEqualTo objnull) then {
    deleteVehicle _driver;
};

_target lockDriver false;

SETPVAR(_target,driver,objnull);
GVAR(Vehicle) = objNull;
hint "Driver Removed";
