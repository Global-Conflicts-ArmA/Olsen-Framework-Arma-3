#include "..\..\script_macros.hpp"


params [["_initmode",false,[false]],"_args"];
_args params [["_logic",objNull,[objNull]],["_entities",[],[[]]]];

LOG_3("CreateZone for %1 _args: %2 _initmode: %3",_logic,_args,_initmode);

_entities params [
    ["_groups",[],[[]]],
    ["_emptyVehs",[],[[]]],
    ["_objects",[],[[]]]
];

_emptyVehs apply {
    _x call FUNC(createEmptyVehicle);
};
_objects apply {
    _x call FUNC(createObject);
};

_groups apply {
    private _groupSet = _x select 1;
    _groupSet params [
        /* 0 */ "_side",
        /* 1 */ "_groupPos",
        /* 2 */ "_behaviour",
        /* 3 */ "_combat",
        /* 4 */ "_speed",
        /* 5 */ "_formation",
        /* 6 */ "_groupStance",
        /* 7 */ "_groupInit",
        /* 8 */ "_createRadius",
        /* 9 */ "_taskRadius",
        /* 10 */ "_wait",
        /* 11 */ "_startBld",
        /* 12 */ "_task",
        /* 13 */ "_taskTimer", 
        /* 14 */ "_multi", 
        /* 15 */ "_occupyOption", 
        /* 16 */ "_vehAssigned",
        /* 17 */ "_waypoints",
        /* 18 */ "_onWater",
        /* 19 */ "_fl",
        /* 20 */ "_surrender", 
        /* 21 */ "_tracker", 
        /* 22 */ "_storedVars"
    ];
    if ((_occupyOption > 0) && {!(_vehAssigned)}) then {
        //rewrite _x call FUNC(createOccupyGroup);
    } else {
        _x call FUNC(createGroup);
    };
};

true
