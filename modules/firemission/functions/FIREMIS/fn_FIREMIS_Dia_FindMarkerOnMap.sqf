#include "script_component.hpp"
#include "defs.hpp"

private _marker = "";
{
  if((markerText (_x))  == _this) then
  {
    _marker = _x;
  };
}forEach allMapMarkers;
_marker;
