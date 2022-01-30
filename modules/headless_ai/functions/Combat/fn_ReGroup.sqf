#include "script_component.hpp"

params ["_GroupUnits","_Group"];

_GroupUnits apply {
	[_x] joinSilent _group;
	SETVAR(_x,LOITERING,false);
	if (_x isEqualTo (leader _x)) then {
		SETVAR(_x,FLANKING,false);
	};
	SETVAR(_x,MovedRecently,false);
};

SETVAR(_group,Task,"DEFEND");
