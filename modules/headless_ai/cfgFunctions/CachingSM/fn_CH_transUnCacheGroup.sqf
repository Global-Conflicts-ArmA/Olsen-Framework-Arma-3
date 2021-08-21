#include "..\..\script_macros.hpp"

params ["_group"];

SETVAR(_group,cached,false);

{
    if !(simulationEnabled _x) then {
        _x enableSimulationGlobal true;
        _x hideObjectGlobal false;
        if (vehicle _x isEqualTo _x) then {
            _x setPosATL (formationPosition _x);
        };
    };
} forEach (units _group);



