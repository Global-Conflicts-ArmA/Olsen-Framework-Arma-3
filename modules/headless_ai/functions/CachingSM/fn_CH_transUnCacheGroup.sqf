#include "script_component.hpp"

params ["_group"];

SETVAR(_group,cached,false);

units _group select {
    !(simulationEnabled _x) 
} apply {
    if (vehicle _x isEqualTo _x) then {
        _x setPosATL (formationPosition _x);
    };
};



