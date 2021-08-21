#include "..\..\script_macros.hpp"


params ["_Unit"];

//Add necessary eventhandlers.
_Unit addEventHandler ["Killed",{
    _this spawn FUNC(ClosestAllyWarn);
}];
_Unit addEventHandler ["FiredMan",{
    [_this] call FUNC(SuppressingShots);
    [_this] call FUNC(HearingAids);
}];
_Unit addEventHandler ["Hit",{
    _this call FUNC(AIHit);
}];

if (GETMVAR(VerboseDebug,false)) then {
    LOG_1("%1 completed UnitInit",_unit);
};
