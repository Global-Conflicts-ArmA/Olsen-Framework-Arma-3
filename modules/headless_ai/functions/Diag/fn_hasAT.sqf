#include "script_component.hpp"


params ["_group"];

private _response = false;
private _aliveUnits = units _group select {alive _x};

{
    if !((secondaryWeapon _x) isEqualTo "") exitwith {_response = true};
} forEach _aliveUnits;

_response