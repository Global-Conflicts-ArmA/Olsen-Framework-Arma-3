//This module allows a fullscreen loading/splash image to be displayed to all clients when connecting to the mission.
//simply add your loading image to the general tab in the Eden editor, and this module will pull the image and then fullscreen it.
//All you have to do is the above and also rename your mission below so it appears correct in the loading screen.


OnLoadName = "MY MISSION NAME HERE";

corpseManagerMode = 0;	//0:None, 1:All, 2:Respawned, 3:Non-respawned
corpseLimit = 100;
corpseRemovalMinTime = 300;
corpseRemovalMaxTime = 2800;

wreckManagerMode = 0;	//0:None, 1:All, 2:Respawned, 3:Non-respawned
wreckLimit = 15;
wreckRemovalMinTime = 60;
wreckRemovalMaxTime = 2800;

minPlayerDistance = 10;
