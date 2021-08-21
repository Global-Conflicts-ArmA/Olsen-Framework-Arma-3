#include "..\..\script_macros.hpp"

params ["_unit"];
if (
	!(isNull _unit) 
	&& {local _unit} 
	&& {!(_unit isKindOf "CAManBase")} 
	&& {!(_unit isEqualTo objNull)} 
	&& {((side _unit) isEqualType sideEmpty)}
) then {
	if (isPlayer _unit) then {
		_unit call FUNC(playerInit);
	} else {
		_unit call FUNC(onInit);
	};

};
//LOG_2("_unit started initPost: %1 side: %2",_unit,side _unit);

