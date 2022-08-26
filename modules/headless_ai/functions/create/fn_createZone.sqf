#include "script_component.hpp"


params [
    ["_initial",false,[false]],
    "_args",
    ["_specialArgs", [], [[]]]
];

_args params [
    ["_logic",objNull,[objNull]],
    ["_entities",[],[[]]]
];

LOG_3("CreateZone for %1 _args: %2 _initial: %3",_logic,_args,_initial);

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
    if (_initial) then {
        [_x, true, _specialArgs] call FUNC(createGroup);
    } else {
        GVAR(spawnQueue) pushBack [_x];
        if (GVAR(spawnGroupPFH) == -1) then {
            GVAR(spawnGroupPFH) = [FUNC(spawnGroupPFH), 1, []] call CBA_fnc_addPerFrameHandler;
        };
    }
};

true
