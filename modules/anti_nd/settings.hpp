// This module's purpose is to prevent negligent discharges at spawn by removing any projectiles fired or thrown.
// You can make this work either on distance away from spawn location or time elapsed since mission start.
// Time:
// Time is recommended for defense mission.

// Distance:
// Distance is recommended for regular assault missions.

// Disables quick grenades (default G to throw item) and only enables ACE throwing.
// User will get an annoying message if they do not have their grenade key unbound and attempt to throw.
disableQuickGrenades = true;

// If you want to disable a setting for a team, set it to 0.
class BLUFOR {
    time = 60;
    distance = 200;
};

class OPFOR {
    time = 60;
    distance = 200;
};

class INDFOR {
    time = 60;
    distance = 200;
};

class CIV {
    time = 60;
    distance = 200;
};
