#include "..\..\script_macros.hpp"


params ["_name"];
private _return = "NotAClass";

if ((typeName _name) isEqualTo "STRING") then {
  _return = (configFile >> "cfgVehicles" >> _name);
};

_return
