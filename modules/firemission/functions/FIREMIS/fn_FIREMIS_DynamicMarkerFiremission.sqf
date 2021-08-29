#include "script_component.hpp"

if (isServer) then
{

  private _marker = (_this select 1) call FUNC(FIREMIS_Dia_FindMarkerOnMap);
  if(_marker  != "") then
  {
    _pos = getMarkerPos _marker;
    _pos set [2,getTerrainHeightASL [_pos select 0,_pos select 1]];
    [_this select 0,_pos,_this select 2,_this select 3,_this select 4,_this select 5,_this select 6,_this select 7] call FUNC(FIREMIS_PointFiremission);
  };

};
