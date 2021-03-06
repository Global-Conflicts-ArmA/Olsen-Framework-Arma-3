#include "..\..\script_macros.hpp"

params ["_group"];

SETVAR(_group,cached,true);

private _leader = leader _group;

units _group select {
    !(_x isEqualTo _leader) && 
    {!((assignedVehicleRole _x select 0) isEqualTo "driver")}
} apply {
    _x enableSimulationGlobal false;
    _x hideObjectGlobal true;
};




