// AUTHOR: StatusRed (EM-Creations.co.uk)

// Register this module
["Knock Down", "Allows melee knocking out of units.", "StatusRed, Krause"] call FUNC(RegisterModule);

if (hasInterface) then { // As this module is client-side only, only continue if this is a client
	#include "settings.sqf"

	if ((side player) in FRAMEWORK_KNOCKDOWN_TEAMS) then { // If this player is in the list of teams who can use the knock down feature
		["Framework", "knock_down", "Knock Down", { [FRAMEWORK_KNOCKDOWN_WEAPONS, FRAMEWORK_KNOCKDOWN_REVIVE_ACTION] execVM "modules\knock_down\action.sqf";  }, "",
		[FRAMEWORK_KNOCKDOWN_KEY, [FRAMEWORK_KNOCKDOWN_KEY_SHIFT, FRAMEWORK_KNOCKDOWN_KEY_CONTROL, FRAMEWORK_KNOCKDOWN_KEY_ALT]]] call CBA_fnc_addKeybind;
	};

};
