// This module allows you to easily manage hostages, all you need is a unit and a marker.
//
// Usage:
// 1) Create a RECTANGLE/ELLIPSE marker that will represent the rescue zone for the hostage.
// 2) Create the hostage unit and give it a name (used for the end conditions).
// 3) In the hostage init place "[<HOSTAGE - OBJECT VAR>, <RESCUE MARKER - STRING>, <JOIN GROUP - BOOLEAN>, <CARELESS MODE - BOOLEAN>, <SITDOWN AFTER RESCUE - BOOLEAN>] call HOST_fnc_setHostage"
// 4) To check if the hostage has been rescued in the end conditions use this line: hostage call EFUNC(HOST,IsRescued)
//
// Example:
// if (hostage1 call EFUNC(HOST,IsRescued) && {hostage2 call EFUNC(HOST,IsRescued)}) exitWith {
//		"Hostages Rescued" call FUNC(EndMission);
// };
//
// if (!([hostage1] call FUNC(isAlive)) && {!([hostage2] call FUNC(isAlive))}) exitWith {
//		"Hostages Killed" call FUNC(EndMission);
// };
