#include "..\..\script_macros.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_groupStance", "AUTO", [""]],
    ["_unitStance", "AUTO", [""]]
];

//LOG_1("setstance: %1",_this);

private _stance = if (!(_groupStance isEqualTo "AUTO") && {_unitStance isEqualTo "AUTO"}) then {
    _groupStance
} else {
    _unitStance
};

if !(_stance isEqualTo "AUTO") then {
    _unit setUnitPos _stance;
};
