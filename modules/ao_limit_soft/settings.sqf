//This module allows you to setup side based AO limitations.
//The AO limits can be connected and units can move freely between them as long as their side corresponds with the AO limits side.
//A unit is only limited by the AO limit if the unit spawns inside it, and the units side corresponds with the AO limits side.
//If a unit crash landed outside the AO limit, or a squad is deployed outside the AO limit they are allowed to enter the AO limit but cannot exit.

// The amount of time in seconds a land based unit is allowed to stay outside the AO (-1 = Infinity)
GVAR(AOTimer) = 30;
// The amount of time in seconds an air based unit is allowed to stay outside the AO (-1 = Infinity)
GVAR(AOTimerAir) = -1;
// If there's an audible warning or not when a player leaves the AO, note... this isn't very polite
GVAR(AudibleWarning) = false;

//[SIDE, NAME] call FUNC(addAOMarker);
//SIDE is the side of the AO marker, NAME is the name of the AO marker.
//If you want all teams to have this AO limit use sideEmpty.

//Example:
//[east, "Kavala"] call FUNC(addAOMarker);
//[blufor, "marker_20"] call FUNC(addAOMarker);
//[sideEmpty, "marker_20"] call FUNC(addAOMarker);
