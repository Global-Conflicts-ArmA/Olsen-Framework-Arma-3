#include "..\..\script_macros.hpp"

params ["_unit"];
//LOG_1("_unit started onInit: %1",_unit);

if (isNil QGVAR(UnitQueue)) then {
    GVAR(UnitQueue) = [_unit];
} else {
    GVAR(UnitQueue) append [_unit];
};

_unit disableAI "FSM";

//LOG_1("UnitQueue: %1",GVAR(UnitQueue));
