// AUTHOR: StatusRed (EM-Creations.co.uk)

params ["_validWeapons", "_reviveAction"];

private ["_nearestunits", "_nearestunitofside", "_prevAnim"];

_prevAnim = animationState player; // Get the player's current animation

_nearestUnits = nearestObjects [player, ["Man"], 3]; // Get all units within range

_useUnits = []; // Instanatiate an array for units which can be targetted

// Check that they have a suitable weapon to knock down with
if ((primaryWeapon player) in _validWeapons) then { // If the player has a valid weapon
	if !(_nearestUnits isEqualTo []) then { // If there's at least one person nearby
		{
			_unit = _x;
			//_isOut = _unit getVariable "knockedDown";
			_isOut = false; // The above isn't working at the moment
			if (!_isOut && {(side player) != (side _unit)}) then { // If the unit is not the player, not on the same side and not already hit
				_useUnits = _useUnits + [_unit]; // Add it to the targetable units array
			};
		} foreach _nearestUnits; // For each of the nearby men

		if !(_useUnits isEqualTo []) then { // If there's at least one targetable unit

			[player, "acts_miller_knockout"] remoteExec ["switchMove", 0]; // Hitting animation

			[-2, {
				[(_this select 0), true] call ace_medical_fnc_setUnconscious;
			}, [(_useUnits select 0)]] call CBA_fnc_globalExecute; // Set them unconscious

			(_useUnits select 0) setVariable ["knockedDown", true, true]; // Set that this unit has been hit

			if (_reviveAction) then { // If the revive action is enabled
				//systemChat "Registering revive..";
				[-2, {
					revive = (_this select 0) addAction ["Revive", "modules\knock_down\revive.sqf", [], 6, false, true, "", "(_this distance _target < 3) && (alive _target)"];
				}, [(_useUnits select 0)]] call CBA_fnc_globalExecute; // Option to revive the person who's been hit
			};

			//[(_useUnits select 0), 1] call ace_blackoutAll;
			sleep 2; // Sleep for two seconds
			[-2, {
				(_this select 0) switchmove (_this select 1);
			}, [player, _prevAnim]] call CBA_fnc_globalExecute; // Go back to the previous animation
		};
	};
};
