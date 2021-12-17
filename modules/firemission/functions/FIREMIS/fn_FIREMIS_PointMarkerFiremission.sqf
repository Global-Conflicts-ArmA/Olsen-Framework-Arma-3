#include "script_component.hpp"

params[
  "_var1",
  "_var2",
	"_var3",
	"_var4",
	"_var5",
	"_var6",
	"_var7",
	"_var8",
	"_var9"
];

if (isServer) then
{
	[_var1, getMarkerPos (_var2), _var3, _var5, _var6, _var7, _var8, _var9] call FUNC(FIREMIS_PointFiremission);
};
