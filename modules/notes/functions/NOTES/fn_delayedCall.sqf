#include "script_component.hpp"

[{
    (_this select 0) call (_this select 1)
}, _this, GVAR(interactionSleepTime)] call CBA_fnc_waitAndExecute;
