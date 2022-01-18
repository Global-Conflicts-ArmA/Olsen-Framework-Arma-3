#include "script_component.hpp"

#include "settings.sqf"

[{!isNil "cTab_vehicleClass_has_FBCB2"}, {
    if (!(isNil QGVAR(HAS_FBCB2)) && {!(isNil "cTab_vehicleClass_has_FBCB2")}) then {
      cTab_vehicleClass_has_FBCB2 = GVAR(HAS_FBCB2);
    };
    if (!(isNil QGVAR(HAS_TAD)) && {!(isNil "cTab_vehicleClass_has_TAD")}) then {
      cTab_vehicleClass_has_TAD = GVAR(HAS_TAD);
    };
    if (!(isNil QGVAR(HAS_HELMET_CAM)) && {!(isNil "cTab_helmetClass_has_HCam")}) then {
      cTab_helmetClass_has_HCam = GVAR(HAS_HELMET_CAM);
    };
}] call CBA_fnc_waitUntilAndExecute;
