#include "script_component.hpp"

params ["_target"];

private _driver = GETVAR(_target,AD_driver,objnull);
[false] call FUNC(AD_ToggleDriverCam);

if !(_driver isEqualTo objnull) then {
    deleteVehicle _driver;
};

SETPVAR(_target,AD_driver,objnull);
GVAR(AD_Vehicle) = objNull;
hint "Driver Removed";
