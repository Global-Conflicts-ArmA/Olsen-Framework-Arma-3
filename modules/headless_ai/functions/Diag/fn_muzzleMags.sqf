#include "script_component.hpp"


params [
    ["_unit", objNull, [objNull]],
    ["_muzzle", "", [""]],
    ["_count", true, [true]]
];

private _magsC = [primaryWeapon _unit] call CBA_fnc_compatibleMagazines;
private _return = if (_count) then {
    {_x in _magsC} count magazines _unit
} else {
    magazines _unit select {_x in _magsC}
};
_return
