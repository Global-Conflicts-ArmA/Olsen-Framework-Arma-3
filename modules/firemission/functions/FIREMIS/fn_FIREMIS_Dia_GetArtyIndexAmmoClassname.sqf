#include "script_component.hpp"
#include "defs.hpp"

private _unit =_this select 0;
private _index =_this select 1;
private _ret = ((_unit call FUNC(FIREMIS_Dia_GetArtyAmmo)) select _index) select 0;
_ret
