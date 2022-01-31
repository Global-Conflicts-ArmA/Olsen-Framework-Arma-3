/*
This module enables live spawning of arrays including AI and objects on the HC machine locally.
It is designed to spawn HC locally in order to improve performance, as well as enabling the
option of having randomized enemy composition, size, etc, or to allow for live spawning
of reinforcements or subsequent AOs.
*/

// Array objects
// eg: ["mainEnemy", "patrol_1", "patrol_2", "patrol_3"]
arrayObjects[] = {};

// Initial spawns are spawned upon init, at the start of the mission.
// eg: ["mainEnemy"]
initialSpawn[] = {};

// Initial random spawns are randomly selected upon init, at the start of the mission according to their weight value.
// Array is structured with array object name and random selection weight.
// eg: {"patrol_1", 2, "patrol_2", 1, "patrol_3", 1}
initialRandomSpawns[] = {};
// Amount of random spawns to choose upon init.
initialRandomSpawnsCount = 0;

// Debug message settings
debug = true;
verboseDebug = false;
groupDebug = false;
// Turn on map markers that track AI movement
useMarkers = true;

// Custom viewdistance for the AI
AIViewDistance = 2500;
// Forces Time on the HC to simulate better AI at night [HOUR,MINUTE]
forceTimeEnable = true;
forceTime[] = {12,00};

// AI system options
feature = true;
enemyUpdateFrequency = 5;
stateMachineFrames = 2;
//attempts to find a better safe area for a vehicle to spawn in. Should only be used when neccessary.
saferVehSpawning = false;

cacheFeature = true;
// The distance a unit needs to be away for PZAI scripts to temporary disable itself upon the unit? The AI unit will also need to be out of combat.
cacheDisableDistance = 3000;
cacheAllPlayers = true;

stanceFeature = true;

// How far can the AI hear gunshots from?
hearingDistance = 2000;
// How revealed an enemy is from a gunshot report
hearingMinIncrease = 1;
// Distance AI will respond to call of help from each other
radioDistance = 0;
radioWait = 30;
// Whether or not AI need ACRE radios to broadcast info to other groups
radioNeedRadio = false;
// Distance the AI will patrol to by default
patrolDistance = 200;
// Whether the AI will patrol between garrison positions. Pretty buggy, but nice for 'mersion
garrisonPatrol = false;
// Default group reinforcement behaviour
reinforce = true;
// Default distance for radio reinforcment calls
reinforceDistance = 2500;
// Default distance for radio reinforcment calls for QRF
QRF_Distance = 2500;
// Will AI garrison static weapons nearby?
mountStatics = true;
// Distance AI will mount empty statics from - maximum of 100m
mountStaticsDistance = 50;
// Should AI use smoke grenades? Besides default A3 behavior?
usesmoke = false;
// Percentage chance of AI using grenades
grenadechance = 45;
// AI will automatically disembark from vehicles when in combat.
AIDisembark = true;
// How low should an AI's mag count be for them to consider finding more ammo? This DOES NOT include the mag loaded in the gun already.
AIMagLimit = 2;
// Should the rain impact accuracy of AI? DEFAULT = true;
rainImpact = true;
// How much should rain impact the accuracy of AI? Default = 3. Default formula is -> _WeatherCheck = (rain)/3; "rain" is on a scale from 0 to 1. 1 Being very intense rain.
rainPercent = 3;
// Should AI have an additional layer of suppression that decreases aiming when suppressed?
suppression = false;
// How much should suppression impact AI aiming? Default is 5. Normal ArmA is 1.
suppressionVar = 5;
// Should AI be impacted by adrenaline? This provides AI with a small speed boost to animations to assist with cover seeking and positioning for a short time.
adrenaline = false;
// How much of a speed boost should AI recieve? Default = 1.35; (1 is ArmA's normal speed).
adrenalineVar = 1.35;
// Should the AI notice IR lasers?
IRLaser = true;
// The longer an AI's target stays in 1 location, the more accurate and aware of the target the AI becomes.
increasingAccuracy = true;
// Whether the AI will set up campfires at night if they are set to the Loiter task
campfires = false;
// Distance the AI will attempt to flank around the enemy. I.E. How far off a waypoint, or around the enemy squad, the AI are willing to go in combat.
waypointDistance = 300;
