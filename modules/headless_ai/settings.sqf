#include "script_macros.hpp"
/*
This module enables live spawning of arrays including AI and objects on the HC machine locally.
It is designed to spawn HC locally in order to improve performance, as well as enabling the
option of having randomized enemy composition, size, etc, or to allow for live spawning
of reinforcements or subsequent AOs.
*/

// Array objects
// eg: ["mainEnemy", "patrol_1", "patrol_2", "patrol_3"]
GVAR(ArrayObjects) = [
    "hc1",
    "hc2",
    "hc3"
];

// Initial spawns are spawned upon init, at the start of the mission.
// eg: ["mainEnemy"]
GVAR(InitialSpawn) = [];

// Initial random spawns are randomly selected upon init, at the start of the mission according to their weight value.
// Array is structured with array object name and random selection weight.
// eg: [["patrol_1", 2], ["patrol_2", 1], ["patrol_3", 1]]
GVAR(InitialRandomSpawns) = [];
// Amount of random spawns to choose upon init.
GVAR(InitialRandomSpawnsCount) = 0;

// Custom viewdistance for the AI
GVAR(AIViewDistance) = 2500;
// Forces Time on the HC to simulate better AI at night [HOUR,MINUTE]
GVAR(ForceTimeEnable) = true;
GVAR(ForceTime) = [12,00];

// Debug message settings
GVAR(Debug) = true;
GVAR(VerboseDebug) = false;
GVAR(GroupDebug) = false;
// Turn on map markers that track AI movement
GVAR(UseMarkers) = true;

// AI system options
GVAR(Enabled) = true;
// The distance a unit needs to be away for PZAI scripts to temporary disable itself upon the unit? The AI unit will also need to be out of combat.
GVAR(CacheDisableDistance) = 3000;
GVAR(CacheAllPlayers) = true;
GVAR(EnemyUpdateFrequency) = 5;
GVAR(StateMachineFrames) = 4;
//attempts to find a better safe area for a vehicle to spawn in. Should only be used when neccessary. 
GVAR(SaferVehSpawning) = false;
// How far can the AI hear gunshots from?
GVAR(HearingDistance) = 2000;
// How revealed an enemy is from a gunshot report
GVAR(HearingMinIncrease) = 1;
// Distance AI will respond to call of help from each other
GVAR(RadioDistance) = 0;
GVAR(RadioWait) = 30;
// Whether or not AI need ACRE radios to broadcast info to other groups
GVAR(RadioNeedRadio) = false;
// Distance the AI will patrol to by default
GVAR(PatrolDistance) = 200;
// Whether the AI will patrol between garrison positions. Pretty buggy, but nice for 'mersion
GVAR(GarrisonPatrol) = false;
// Default group reinforcement behaviour
GVAR(Reinforce) = true;
// Default distance for radio reinforcment calls
GVAR(ReinforceDistance) = 2500;
// Default distance for radio reinforcment calls for QRF
GVAR(QRF_Distance) = 2500;
// Will AI garrison static weapons nearby?
GVAR(MountStatics) = true;
// Distance AI will mount empty statics from - maximum of 100m
GVAR(MountStaticsDistance) = 50;
// Should AI use smoke grenades? Besides default A3 behavior?
GVAR(USESMOKE) = false;
// Percentage chance of AI using grenades
GVAR(GRENADECHANCE) = 45;
// AI will automatically disembark from vehicles when in combat.
GVAR(AIDisembark) = true;
// How low should an AI's mag count be for them to consider finding more ammo? This DOES NOT include the mag loaded in the gun already.
GVAR(AIMagLimit) = 2;
// Should the rain impact accuracy of AI? DEFAULT = true;
GVAR(RainImpact) = true;
// How much should rain impact the accuracy of AI? Default = 3. Default formula is -> _WeatherCheck = (rain)/3; "rain" is on a scale from 0 to 1. 1 Being very intense rain.
GVAR(RainPercent) = 3;
// Should AI have an additional layer of suppression that decreases aiming when suppressed?
GVAR(Suppression) = false;
// How much should suppression impact AI aiming? Default is 5. Normal ArmA is 1.
GVAR(SuppressionVar) = 5;
// Should AI be impacted by adrenaline? This provides AI with a small speed boost to animations to assist with cover seeking and positioning for a short time.
GVAR(Adrenaline) = false;
// How much of a speed boost should AI recieve? Default = 1.35; (1 is ArmA's normal speed).
GVAR(AdrenalineVar) = 1.35;
// Should the AI notice IR lasers?
GVAR(IRLaser) = true;
// The longer an AI's target stays in 1 location, the more accurate and aware of the target the AI becomes.
GVAR(IncreasingAccuracy) = true;
// GVAR(SideBasedMovement)- Remove sides from the array below to exclude that AI side to not execute any advance movement code. (I.E. Moving to reinforce allies, being alerted by distant gunshots and etc). AI with this will still react normally in combat.
GVAR(SideBasedMovement) = [EAST,INDEPENDENT,CIVILIAN,BLUFOR];
// GVAR(SideBasedExecution)- Remove sides from the array below to exclude that AI side from executing any of the AI scripts. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
GVAR(SideBasedExecution) = [EAST,INDEPENDENT,CIVILIAN,BLUFOR];
// Whether the AI will set up campfires at night if they are set to the Loiter task
GVAR(Campfires) = false;
// Distance the AI will attempt to flank around the enemy. I.E. How far off a waypoint, or around the enemy squad, the AI are willing to go in combat.
GVAR(WaypointDistance) = 300;

#include "settings\commander.hpp"
#include "settings\bunker.hpp"
#include "settings\skill.hpp"
#include "settings\sight.hpp"

