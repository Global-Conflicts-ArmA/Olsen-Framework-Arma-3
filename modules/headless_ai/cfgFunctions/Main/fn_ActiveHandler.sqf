#include "..\..\script_macros.hpp"


GVAR(ActiveList) = [];

GVAR(ActiveHandlePFH) = [{
    if (isNil QGVAR(ActiveList)) exitwith {GVAR(ActiveList) = [];};
    {
        if (isNull _x) then {
            GVAR(ActiveList) deleteAt _foreachIndex;
        };
    } foreach GVAR(ActiveList);
}, 0.2] call CBA_fnc_addPerFrameHandler;
