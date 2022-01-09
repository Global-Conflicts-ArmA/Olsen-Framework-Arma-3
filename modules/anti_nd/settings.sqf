// This module's purpose is to prevent negligent discharges at spawn by removing any projectiles fired or thrown.
// You can make this work either on distance away from spawn location or time elapsed since mission start.
// Time:
// Time is recommended for defense mission.

// Distance:
// Distance is recommended for regular assault missions.

// If you want to disable a setting, set it to 0.

// Settings for BLUFOR
GVAR(BLUFOR_Time) = 30; // Seconds
GVAR(BLUFOR_Distance) = 200; // Metres

// Settings for OPFOR
GVAR(OPFOR_Time) = 30;
GVAR(OPFOR_Distance) = 200;

// Settings for INDFOR
GVAR(INDFOR_Time) = 30;
GVAR(INDFOR_Distance) = 200;

// Settings for CIVFOR
GVAR(CIVFOR_Time) = 30;
GVAR(CIVFOR_Distance) = 200;
