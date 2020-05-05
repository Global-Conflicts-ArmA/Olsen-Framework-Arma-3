#include "..\..\script_macros.hpp"


params ["_unit"];

private _ItemList = weaponsitems _unit;
private _Return = false;

if !(((_ItemList select 0) select 1) isEqualTo "") then {
    _Return = true;
};

_Return
