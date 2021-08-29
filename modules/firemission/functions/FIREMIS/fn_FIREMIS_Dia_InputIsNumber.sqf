#include "script_component.hpp"
#include "defs.hpp"

private _value = _this select 0;
private _errorText = _this select 1;
private _ret = true;
if(_value < 0) then
{
  hint _errorText;
  _ret = false;
};
_ret
