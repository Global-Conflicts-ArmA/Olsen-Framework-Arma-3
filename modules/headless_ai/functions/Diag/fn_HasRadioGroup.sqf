#include "script_component.hpp"


params [["_group", grpNull, [grpNull]]];

private _return = (units _group) select {
    alive _x &&
    {!(_x getVariable ["ACE_isUnconscious", false])}
} findIf {
    [_x] call acre_api_fnc_hasRadio
};

[_return isNotEqualTo -1, _return]
