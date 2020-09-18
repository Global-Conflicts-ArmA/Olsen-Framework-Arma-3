// Mission attributes which control many of your mission's settings.

// DO NOT CHANGE, spectator script needs people to respawn, to be declared as dead and put into spectator mode
// See: https://community.bistudio.com/wiki/Description.ext#respawn
respawn = "BASE";

// 5 seconds are needed to make sure people properly die and go into spectator
// See: https://community.bistudio.com/wiki/Description.ext#respawnDelay
respawndelay = 5;

// disabledAI does so not slotted units do not spawn as ai
// See: https://community.bistudio.com/wiki/Description.ext#disabledAI
disabledAI = 1;

// Disables the respawn button
// See: https://community.bistudio.com/wiki/Description.ext#respawnButton
respawnButton = 1;

// Disables the score screen while respawning
// See: https://community.bistudio.com/wiki/Description.ext#respawnDialog
respawnDialog = 0;

// Disables respawn countdown
// See: https://community.bistudio.com/wiki/Description.ext#respawnTemplates
respawnTemplates[] = {"Base"};

// Only for logged-in admins
// See: https://community.bistudio.com/wiki/Description.ext#enableDebugConsole
enableDebugConsole = 1;

// Sets the mode for corpse removal manager. 1 = All units are managed by the manager
// See: https://community.bistudio.com/wiki/Description.ext#corpseManagerMode
corpseManagerMode = 1;

// Sets the mode for wreck removal manager. 1 = All units are managed by the manager
// See: https://community.bistudio.com/wiki/Description.ext#wreckManagerMode
wreckManagerMode = 1;

// Enable CBA Target Debugging
// See: https://github.com/CBATeam/CBA_A3/wiki/Target-Debugging
enableTargetDebug = 1;
