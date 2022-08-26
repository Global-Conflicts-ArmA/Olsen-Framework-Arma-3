#include "script_component.hpp"

params ["_Unit"];

//Add necessary eventhandlers.
_Unit addEventHandler ["Killed",{
  // Where is ClosestAllyWarn declared?
    _this spawn FUNC(ClosestAllyWarn);
}];
_Unit addEventHandler ["FiredMan",{
    [_this] call FUNC(SuppressingShots);
    // Where is HearingAids declared?
    [_this] call FUNC(HearingAids);
}];
_Unit addEventHandler ["Hit",{
    // Where is AIHit declared?
    _this call FUNC(AIHit);
}];
