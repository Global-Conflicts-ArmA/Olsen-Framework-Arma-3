#include "script_component.hpp"

private _unit  = _this select 0;
private _ret = [];
_ret pushBack (_unit getVariable [VAR_SART_OBSACCURACY,OBSACCURACY]);
_ret pushBack (_unit getVariable [VAR_SART_OBSSPEED,OBSSPEED]);
_ret
