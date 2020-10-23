["Remove Maps", "Removes maps and compasses from specific gear cases.", "TinfoilHate"] call FUNC(RegisterModule);

if (hasInterface) then { // As this module is client-side only, only continue if this is a client
	#include "settings.sqf"

	[_keepMapClasses, _keepCompassClasses] call FUNC(RM_doRemoves);
};
