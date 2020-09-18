/*
	Start in Parachute module by Briland and StatusRed

	This module starts all defined players inside a parachute at a defined altitude.
	This DOES NOT work for AI.

	Syntax:
	[target, altitude, altituderandom, parachuteisstearable] call FUNC(SIP_doParachute);

	Paramaters:
	target: either the SIDE, UNIT, or ARRAY of units that you want to parachute when they spawn
	altitude: the elevation above terrain level that the parachute will open
	(optional) altituderandom: A random number between 0 and altituderandom will be added to altitude for the effect to look better. default is 100
	(optional) parachuteisstearable: true for parachute to be stearable, false for nonstearable. false by default

	Examples:
	[blufor, 300] call FUNC(SIP_doParachute);
	[opfor, 200, 150] call FUNC(SIP_doParachute);
	[[coUnit, unit2], 200, 20, true] call FUNC(SIP_doParachute);

*/

[{!(isNull ACE_player)}, {

  [blufor, 300] call FUNC(SIP_doParachute);

}, []] call CBA_fnc_waitUntilAndExecute;
