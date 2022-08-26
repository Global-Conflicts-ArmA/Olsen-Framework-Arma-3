#include "script_component.hpp"

params ["_group"];

private _leader = leader _group;
private _task = GETVAR(_group,Task,"NONE");
private _position = getposATL _leader;
private _areaAssigned = GETVAR(_group,areaAssigned,"NONE");
private _assetType = GETVAR(_group,assetType,"Infantry");
private _behaviour = behaviour _leader;

private _combat = if (_task in ["ATTACK", "ASSAULT", "FLANK", "DEFEND"]) then {
    true
} else {
    if (_behaviour in ["COMBAT","STEALTH"]) then {
        true
    } else {
        false
    };
};

_combat
