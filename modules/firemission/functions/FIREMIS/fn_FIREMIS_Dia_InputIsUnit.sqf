#include "script_component.hpp"

params[
  ["_value", objNull, [objNull]],
  ["_errorText", "", [""]]
];

private _ret = true;
if(_value isEqualTo objNull) then
{
  hint _errorText;
  _ret = false;
};
_ret
