//This script allows users to brief in-game. 
//Resctricted to a sized setup zone untill both teams interact with a chosen object and "ready up", at which point the mission will become live after 10 seconds and players may then leave the zone.


//You can find an example mission here: https://globalconflicts.net/wiki/index.php?title=Mission_template/Examples




----


1) Drop the ingameBrief folder into your main mission directory/folder. 

2) Add the following to your missions init.sqf: [] execVM "ingameBrief\init.sqf";

3) For each setup zone you want to create, place a gamelogic in the center of the desired area, and add the following to it's init: script = [this, size of zone, side of players to be contained] execVM "ingameBrief\scripts\sandi_barrier\setup.sqf";
Example - script = [this, 180, east] execVM "ingameBrief\scripts\sandi_barrier\setup.sqf";

4) Place down one object in each sides start zone, it can be any object, and give each object the relevant variable name for the correct side, either "BlueBoard" or "RedBoard"

5) Place down a logic and name it "barrierChecker"

