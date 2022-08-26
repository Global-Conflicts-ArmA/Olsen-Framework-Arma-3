#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_groupStance", "Auto", [""]],
    ["_unitStance", "Auto", [""]]
];

//LOG_1("setstance: %1",_this);
TRACE_3("setstance",_unit,_groupStance,_unitStance);

private _stance = if ((_groupStance != "Auto") && {_unitStance == "Auto"}) then {
    _groupStance
} else {
    _unitStance
};

if (_stance != "Auto") then {
    TRACE_2("setstance",_unit,_stance);
    _unit setUnitPos _stance;
};
