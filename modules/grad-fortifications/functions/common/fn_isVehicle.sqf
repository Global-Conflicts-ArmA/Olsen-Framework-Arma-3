/*  Checks if type is vehicle
*
*/

#include "script_component.hpp"
params ["_type"];

private _isVehicle = switch (true) do {
    case (_type isKindOf "StaticWeapon"): {true};
    case (_type isKindOf "LandVehicle"): {true};
    case (_type isKindOf "Air"): {true};
    case (_type isKindOf "Ship"): {true};
    default {false};
};

_isVehicle
