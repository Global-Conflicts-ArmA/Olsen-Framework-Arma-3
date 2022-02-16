#include "script_component.hpp"

params [
    ["_unit",objNull,[objNull]],
    ["_veh",objNull,[objNull]],
    ["_role","",[""]],
    ["_index", 0, [0,[]]]
];

if (_veh isEqualTo objnull) exitWith {
    ERROR_1("Vehicle for %1 not found",_unit);
};


//private _group = group _unit;
switch (toLower _role) do {
    case "driver": {
        _unit assignAsDriver _veh;
        _unit moveInDriver _veh;
    };
    case "cargo": {
        if !(_index isEqualType 0) exitWith {
            ERROR_1("veh index lacking proper role number: %1",_unit);
        };
        _unit assignAsCargoIndex [_veh, _index];
        private _return = _unit moveInCargo _veh;
        LOG_4("cargoIndex index: %1 for unit: %2 veh: %3 success: %4",_index, _unit, _veh,_return);
    };
    case "gunner": {
        _unit assignAsGunner _veh;
        _unit moveInGunner _veh;
    };
    case "turret": {
        if (_index isEqualTo []) exitWith {
            ERROR_1("veh index lacking proper role for turret",_index);
        };
        _unit assignAsTurret [_veh, _index];
        _unit moveInTurret [_veh, _index];
    };
    case "commander": {
        _unit assignAsCommander _veh;
        _unit moveInCommander _veh;
    };
    default {};
};
