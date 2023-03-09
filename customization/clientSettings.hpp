
viewDistance = 2500; //View distance for the player

class StartOnSafe {
    enabled = true;
    lowered = false;
    unloaded = false;
};

/*
    Respawn works by setting either the RespawnTickets to -1, giving the players unlimited individual respawn,
    Disabling respawn entirely by setting the RespawnTickets to 0, or by limiting the respawn tickets by either
    Setting a finite number of individual RespawnTickets (ie. RespawnTickets = 5) or by limiting the team respawn tickets in
    the serverSettings file. Set a team ticket setting to -1 for unlimited team tickets (only restricted by the client setting)
*/
respawnTickets = 0;

 // Enable this to force high terrain setting. This will prevent faraway objects from appearing as floating. Useful for missions with long sightlines.
forceTerrainGrid = true;
// value between 3.125 and 50, the lower the more terrain detail
terrainGridValue = 3.125

class Spectator {
    // Whether all sides can be viewed by spectator
    viewAllSides = true;
    // Whether AI can be viewed by the spectator (true/false)
    viewAI = true;
    // Whether Free camera mode is available (true/false)
    freeCamera = true;
    // Whether 3th Person Perspective camera mode is available (true/false)
    thirdPersonCamera = true;
    // Whether to show Focus Info stats widget (true/false)
    showInfo = true;
    // Whether or not to show camera buttons widget (true/false)
    showCameraButtons = true;
    // Whether to show controls helper widget (true/false)
    showControls = true;
    // Whether to show header widget (true/false)
    showHeader = true;
    // Whether to show entities / locations lists (true/false)
    showEntitiesList = true;
    // Define where the spectator camera starts. (add a marker with the name inside the "")
    marker = "";
    // Activate showing information about killer
    killCam = true;
    // Makes screen turn black instantly and mutes all audio when killed
    instantDeath = true;
};
