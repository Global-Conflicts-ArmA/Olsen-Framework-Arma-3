#include "script_component.hpp"

params ["_group"];
TRACE_1("vehicleEject started",_group);

private _units = units _group;
_units apply {
    moveOut _x;
};
