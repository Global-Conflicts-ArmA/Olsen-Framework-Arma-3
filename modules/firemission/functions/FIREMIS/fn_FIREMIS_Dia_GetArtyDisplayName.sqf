#include "script_component.hpp"
#include "defs.hpp"

private _unit = _this;
private	_text = _unit getVariable [VAR_SART_ARTCUSTOMNAME,""];
if(_text == "") then { _text = getText (configfile / "CfgVehicles" /  typeOf(_unit) / "displayName") };
_text
