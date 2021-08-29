#include "script_component.hpp"

if (isServer) then
{
	[_this select 0,getMarkerPos (_this select 1),_this select 2,_this select 4,_this select 5,_this select 6,_this select 7,_this select 8] call FUNC(FIREMIS_PointFiremission);
};
