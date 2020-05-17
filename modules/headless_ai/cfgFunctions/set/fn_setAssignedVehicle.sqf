#include "..\..\script_macros.hpp"


params [["_u",objNull,[objNull]],["_vr",[],[[]]],["_veh",objNull,[objNull]],["_pos",[],[[]]],["_vc","",[""]]];
if (isNull _veh) then {
    _veh = _pos nearestObject _vc;
};
_vr params [["_role","",[""]],["_turret",[],[[]]]];
switch (tolower _role) do {
    case "driver": {
        _u assignAsDriver _veh;
        _u moveInDriver _veh;
    };
    case "cargo": {
        _u assignAsCargo _veh;
        _u moveInCargo _veh;
    };
    case "turret": {
        _u assignAsTurret [_veh,_turret];
        _u moveInTurret [_veh,_turret];
    };
    case "commander": {
        _u assignAsCommander _veh;
        _u moveInCommander _veh;
    };
    default {};
};
true
