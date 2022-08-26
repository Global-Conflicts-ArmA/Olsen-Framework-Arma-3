#include "script_component.hpp"

params[
  ["_value", -1, [-1]],
  ["_errorText", "", [""]]
];

private _ret = true;
if(_value < 0) then
{
  hint _errorText;
  _ret = false;
};
_ret
