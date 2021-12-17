#include "..\..\script_macros.hpp"


params ["_group"];

private _return = false;

(units _group) apply {
	if ([_x] call acre_api_fnc_hasRadio) exitwith {
        _return = true;
    };
};

_return
