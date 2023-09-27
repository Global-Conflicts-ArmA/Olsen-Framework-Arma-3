#include "script_component.hpp"

params [
    "_group",
    "_supportedGroup",
    "_targetPos",
    ["_compRadius", 50, [0]]
];
LOG_1("combatCover started _this: %1",_this);

private _leader = leader _group;
if (INVEHICLE(_leader)) exitWith {
    _this call FUNC(CombatCoverVehicle);
};

SETVAR(_group,Task,"COVER");
