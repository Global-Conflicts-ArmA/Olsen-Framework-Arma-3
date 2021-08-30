#include "script_component.hpp"

private _marker = "";
{
  if((markerText (_x))  == _this) then
  {
    _marker = _x;
  };
}forEach allMapMarkers;
_marker;
