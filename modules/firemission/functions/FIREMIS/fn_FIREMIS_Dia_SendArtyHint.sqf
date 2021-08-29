#include "script_component.hpp"
#include "defs.hpp"

private  _unit = _this select 0;
private  _text = _this select 1;
["Event_ArtyReceiveHint", _text, _unit] call CBA_fnc_targetEvent;
