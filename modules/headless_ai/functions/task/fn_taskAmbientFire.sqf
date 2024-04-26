#include "script_component.hpp"

params [
    "_group"
];

[_group] call FUNC(combatAmbientFire);
SETVAR(_group,Task,"AMBIENT");