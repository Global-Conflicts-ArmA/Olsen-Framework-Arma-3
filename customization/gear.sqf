#include "core\gearCore.sqf" //DO NOT REMOVE

// Call this with [this, "LOADOUT", (optional) "GROUPNAME"] call FNC_GearScript; in the Init field of the unit
// Example:
// [this, "SL", "1'1"] call FNC_GearScript;\
//
// more info: https://github.com/dklollol/Olsen-Framework-Arma-3/wiki/gear.sqf

//when set to false, facewear types that are whitelisted will not be removed
FW_force_remove_facewear = false;

//Forces items into a specified container on a unit/client, even if there isn't inventory space. Works only if container is specified!
FW_enableOverfill = true;

_unit call FNC_RemoveAllGear;

switch (_type) do {
	
//Edit the line below with the path and name all loadouts being used in your mission.
	#include "loadouts\ExampleLoadout.sqf"
};