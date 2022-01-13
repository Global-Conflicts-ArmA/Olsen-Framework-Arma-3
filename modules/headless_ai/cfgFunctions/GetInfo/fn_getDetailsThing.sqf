#include "..\..\script_macros.hpp"

params ["_obj", ["_pos",[],[[]]]];
 private _init = (GETVAR(_obj,Init,""));
 if (_init isEqualType "") then {
     if !(_init isNotEqualTo "") then {
          _init = compile _init;
     } else {
          _init = false;
     };
 };
 if (_pos isEqualTo []) then {
     _pos = (getposATL _obj) apply {parseNumber (_x toFixed 2)};
 };
 private _vectorDir = (vectorDir _obj) apply {parseNumber (_x toFixed 2)};
 private _vectorUp = (vectorUp _obj) apply {parseNumber (_x toFixed 2)};
 private _damage = parseNumber (damage _obj toFixed 2);
 private _name = GETVAR(_obj,varName,"");
 [typeOf _obj,
 _pos,
 _vectorDir,
 _vectorUp,
 _damage,
 surfaceIsWater (getposATL _obj),
 _obj getVariable [QGVAR(Name),""],
 _init,
 (GETVAR(_obj,StoredVars,[])),
 _name]
