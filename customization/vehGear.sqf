#include "core\vehGearCore.sqf" //DO NOT REMOVE

// Call this with [this, "LOADOUT"] call FW_fnc_VehicleGearScript; in the Init field of the vehile
// Example:
// [this, "HUMMVEE"] call FW_fnc_VehicleGearScript;

switch (_type) do {

	case "HUMMVEE": {

		_vehicle call FUNC(RemoveAllVehicleGear);

		["30Rnd_556x45_Stanag", 8] call FUNC(AddItemVehicle);
		["rhs_weap_m4a1_carryhandle"] call FUNC(AddItemVehicle);

	};
};