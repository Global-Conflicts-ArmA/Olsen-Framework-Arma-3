#include "..\..\script_macros.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_groupStance", "Auto", [""]],
    ["_unitStance", "Auto", [""]]
];

LOG_1("setstance: %1",_this);

private _stance = if (!(_groupStance isEqualTo "Auto") && {_unitStance isEqualTo "Auto"}) then {
    _groupStance
} else {
    _unitStance
};

if !(_stance isEqualTo "Auto") then {
    _unit setUnitPos _stance;
};
