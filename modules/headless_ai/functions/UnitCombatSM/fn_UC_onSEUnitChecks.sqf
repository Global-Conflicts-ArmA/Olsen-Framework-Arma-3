#include "script_component.hpp"

params ["_unit"];

private _enemyTargets = _unit targets [true, 0];
private _weaponType = ((currentWeapon _unit) call BIS_fnc_itemType) select 1;
private _hasAmmo = (_unit ammo (currentWeapon _unit)) > 0;
private _throwMagazineArray = (magazines _unit) select {_x isKindOf ["HandGrenade", configfile >> "cfgMagazines"]};
private _smokeGrenadeArray = _throwMagazineArray select {_x isKindOf ["SmokeShell", configfile >> "cfgMagazines"]};
private _chemLightArray = _throwMagazineArray select {_x isKindOf ["ChemLight_green", configfile >> "cfgMagazines"]};
private _fragGrenadeArray = (_throwMagazineArray - _smokeGrenadeArray) - _chemLightArray;
//private _hasATLauncher =
//private _hasATAmmo =

SETVAR(_unit,UC_enemyTargets,_chosenTarget);
SETVAR(_unit,UC_weaponType,_weaponType);
SETVAR(_unit,UC_hasAmmo,_hasAmmo);
SETVAR(_unit,UC_smokeGrenades,(count _smokeGrenadeArray));
SETVAR(_unit,UC_chemLights,(count _chemLightArray));
SETVAR(_unit,UC_fragGrenades,(count _fragGrenadeArray));
