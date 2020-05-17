#include "..\..\script_macros.hpp"

LOG("Starting UnitQueue Function");

if (isNil QGVAR(UnitQueue)) then {
    GVAR(UnitQueue) = [];
};

GVAR(QueueHandlePFH) = [{
    if (GVAR(UnitQueue) isEqualTo []) exitwith {};
    //LOG_1("UnitQueue:%1 check",GVAR(UnitQueue));
    private _unit = GVAR(UnitQueue) select 0;
    private _Disabled = GETVAR(_unit,NoAI,false);
    if ((typeOf _unit) isEqualTo "HeadlessClient_F") then {
        _Disabled = true;
    };
    if ((vehicle _unit) isKindOf "Plane") then {
        _Disabled = true;
        SETVAR(_unit,NoAI,true);
    };
    //LOG_3("Unit:%1 FSM check disabled: %2 isNull: %3",_unit,_Disabled,(isNull _unit));
    if (!(isNull _unit) && {!(_Disabled)}) then {
        private _leader = leader _unit;
        if ((side _leader in GVAR(SideBasedExecution)) || ((((INDEPENDENT in GVAR(SideBasedExecution)) || (RESISTANCE in GVAR(SideBasedExecution))) && (str(side _leader) isEqualTo "GUER")))) then {
            //LOG_1("Unit:%1 added to FSM",_unit);
            //[_unit] execFSM "modules\headless_ai\cfgFunctions\FSM\AIBEHAVIORTEST.fsm";
            GVAR(ActiveList) pushback _unit;
        } else {
            //LOG_1("Unit:%1 invalid for FSM",_unit);
            _unit forcespeed -1;
        };
            GVAR(UnitQueue) deleteAt 0;
    } else {
            GVAR(UnitQueue) deleteAt 0;
            _unit forcespeed -1;
            //LOG_1("Unit:%1 invalid for FSM",_unit);
    };
}, 0.2] call CBA_fnc_addPerFrameHandler;
