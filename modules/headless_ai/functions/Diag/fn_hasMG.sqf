#include "script_component.hpp"


params ["_unit"];

private _isMG = ((primaryweapon _unit) call BIS_fnc_itemtype) select 1 == "MachineGun";

_isMG