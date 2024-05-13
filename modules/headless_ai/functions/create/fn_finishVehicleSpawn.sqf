#include "script_component.hpp"

params [
    ["_vehicle", objNull, [objNull]],
    ["_init", false, [false, {}]],
    ["_storedVars", [], [[]]]
];

if (_init isEqualType {}) then {
    //SETVAR(_vehicle,Init,_init);
    _vehicle call _init;
};

if (_storedVars isNotEqualTo []) then {
    //LOG_1("Setting vars: %1",_storedVars);
    _storedVars apply {
        _x params ["_varName", "_varValue"];
        _vehicle setvariable [_varName,_varValue];
        //LOG_2("Setting _varName: %1 with: %2",_varName,_varValue);
    };
};


private _driverGroup = group driver _vehicle;
private _effectiveCommanderGrp = group effectiveCommander _vehicle;
if (GETMVAR(VerboseDebug,false)) then {
    TRACE_2("finishVehSpawn",_driverGroup,_effectiveCommanderGrp);
};
SETMVAR(PFHBusy, false);
if (_effectiveCommanderGrp isNotEqualTo _driverGroup) then {
    private _leader = leader _driverGroup;
    _vehicle setEffectiveCommander _leader;
    if (GETMVAR(VerboseDebug,false)) then {
        TRACE_2("set EC",_leader,effectiveCommander _vehicle);
    };
    doStop driver _vehicle;
    driver _vehicle doFollow _leader;
};
