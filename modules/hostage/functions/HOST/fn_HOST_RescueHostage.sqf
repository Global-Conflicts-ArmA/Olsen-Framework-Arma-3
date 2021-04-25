#include "script_component.hpp"

params ["_unit", "_caller"];

TRACE_2("Hostage Rescue called",_unit,_caller);

if ((GETVAR(_unit,IsRescued,false)) || {GETVAR(_unit,IsUntied,false)}) exitWith {};
if !((animationState _unit find "acts_aidlpsitmstpssurwnondnon") isEqualto -1) then {
    _unit removeEventHandler ["AnimDone", (GETVAR(_unit,EhAnimDone,0))];
    [_unit, "", 1] call ace_common_fnc_doAnimation;
    _unit enableAI "ANIM";
    _unit enableAI "MOVE";
};

if (GETVAR(_unit,FreedBehaviorModifier,true)) then {
    _unit setBehaviour (GETVAR(_unit,FreedBehavior,"careless"));
};

if (GETVAR(_unit,FreedJoinSquad,true)) then {
    [_unit] joinSilent (group _caller);
};

SETPVAR(_unit,IsUntied,true);
