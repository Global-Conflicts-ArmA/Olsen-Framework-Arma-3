#include "script_component.hpp"
params ["_fort","_unit"];

private _fortOwner = (_this select 0) getVariable [QGVAR(fortOwner),objNull];

private _isOwner = switch (typeName _fortOwner) do {
    case ("OBJECT"): {
        _unit == _fortOwner;
    };
    case ("GROUP"): {
        _unit in (units _fortOwner);
    };
    case ("SIDE"): {
        side _unit == _fortOwner;
    };
};

_isOwner
