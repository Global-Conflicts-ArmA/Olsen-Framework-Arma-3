#include "..\..\script_macros.hpp"


params [["_pos",[],[[]]],["_vc","",[""]],["_vr",[],[[]]],["_u",objNull,[objNull]]];
private _veh = _pos nearestObject _vc;
_vr params [["_role","",[""]],["_turret",[],[[]]]];
switch (tolower _role) do {
    case "driver": {
        _u assignAsDriver _veh;
    };
    case "cargo": {
        _u assignAsCargo _veh;
    };
    case "turret": {
        _u assignAsTurret [_veh,_turret];
    };
    default {};
};
true
