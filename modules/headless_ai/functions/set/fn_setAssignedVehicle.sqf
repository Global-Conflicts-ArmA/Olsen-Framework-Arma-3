#include "script_component.hpp"

params [
    ["_unit",objNull,[objNull]],
    ["_vehRole",[],[[]]],
    ["_veh",objNull,[objNull]],
    ["_pos",[],[[]]],
    ["_vehType","",[""]]
];
if (isNull _veh) exitWith {
    ERROR_2("Vehicle type %2 for %1 not found",_unit,_vehType);
};
_vehRole params [
    ["_role","",[""]],
    ["_turret",[],[[]]]
];
private _group = group _unit;
switch (tolower _role) do {
    case "driver": {
        _unit assignAsDriver _veh;
        _unit moveInDriver _veh;
        if (leader _unit isEqualTo _unit) then {
            SETVAR(_veh,vehCrew,_group);
        };
    };
    case "cargo": {
        _unit assignAsCargo _veh;
        _unit moveInCargo _veh;
    };
    case "turret": {
        _unit assignAsTurret [_veh,_turret];
        _unit moveInTurret [_veh,_turret];
    };
    case "commander": {
        _unit assignAsCommander _veh;
        _unit moveInCommander _veh;
    };
    default {};
};
true
