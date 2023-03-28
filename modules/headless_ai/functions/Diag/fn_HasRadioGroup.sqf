#include "script_component.hpp"

params [["_group", grpNull, [grpNull]]];

if (_group isEqualTo grpNull) exitWith {
    [false, -1]
};

private _units = units _group;
private _return = _units select {
    alive _x &&
    {!(_x getVariable ["ACE_isUnconscious", false])}
} findIf {
    GETVAR(_x,hasRadio,false)
};

if (_return isEqualTo -1) then {
    [false, []]
} else {
    [true, _units select _return]
};
