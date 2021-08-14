// Author: StatusRed
if !(hasinterface) exitwith {};

[-2, {
	(_this select 0) removeaction revive;
	[(_this select 0), false] call ace_medical_fnc_setUnconscious;
	(_this select 0) setVariable ["ace_w_heal", true];
}, [(_this select 0)]] call CBA_fnc_globalExecute;

(_this select 0) setVariable ["knockedDown", false, true]; // Set this player to no longer hit
