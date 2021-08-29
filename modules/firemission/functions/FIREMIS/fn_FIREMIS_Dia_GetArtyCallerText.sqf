#include "script_component.hpp"
#include "defs.hpp"

private _unit = _this;
private _caller = _unit call FUNC(FIREMIS_Dia_GetArtyCaller);
private _returnName = "Non specified";
if(!(isNull  _caller)) then
{
  _returnName = name _caller;
};

_returnName
