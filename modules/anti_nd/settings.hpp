// This module's purpose is to prevent negligent discharges at spawn by removing any projectiles fired or thrown.
// You can make this work either on distance away from spawn location or time elapsed since mission start.
// Time:
// Time is recommended for defense mission.

// Distance:
// Distance is recommended for regular assault missions.

// If you want to disable a setting, set it to 0.

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
