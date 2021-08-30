#include "script_component.hpp"

private _unit = _this select 0;
private _caller = _this select 1;
_unit setVariable [VAR_SART_CALLER,_caller,true];
