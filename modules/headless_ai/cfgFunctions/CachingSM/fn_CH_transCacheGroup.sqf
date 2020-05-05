#include "..\..\script_macros.hpp"

params ["_group"];

SETVAR(_group,cached,true);

private _leader = leader _group;
{
    if (
        !(_x isEqualTo _leader) && 
        {!("driver" isEqualTo (assignedVehicleRole _x select 0))}
    ) then {
        _x enableSimulationGlobal false;
        _x hideObjectGlobal true;
    };
} forEach (units _group);




