#define preinit

#include "core\script_macros.hpp"

FW_DebugMessages = [];
FW_Modules = [];

PREP(getTeamVariable);
PREP(setTeamVariable);
PREP(eventKilled);
PREP(eventPlayerSpawned);
PREP(eventSpawned);
PREP(eventRespawned);
PREP(eventDisconnect);
PREP(forceTerrainGrid);
PREP(trackUnit);
PREP(untrackUnit);
PREP(StartingCount);
PREP(stackNames);
PREP(getDamagedAssets);
PREP(createRespawnMarker);
PREP(inArea);
PREP(areaCount);
PREP(endMission);
PREP(casualtyPercentage);
PREP(casualtyCount);
PREP(alive);
PREP(hasEmptyPositions);
PREP(inVehicle);
PREP(addTeam);
PREP(spectateCheck);
PREP(spectatePrep);
PREP(countTeam);
PREP(spawnVehicle);
PREP(hasExtracted);
PREP(notTrackUnit);
PREP(debugMessage);
PREP(randomRange);
PREP(trackAsset);
PREP(canLinkItem);
PREP(canAttachItem);
PREP(addItemOrg);
PREP(addItemRandomOrg);
PREP(addItemVehicleOrg);
PREP(addItemVehicleRandomOrg);
PREP(removeAllGear);
PREP(removeAllVehicleGear);
PREP(registerModule);
PREP(checkClassname);
PREP(makeUnitsList);

FNC_Briefing = compile preprocessFileLineNumbers "customization\briefing.sqf";
//FNC_Briefing = compile preprocessFileLineNumbers "customization\enhanced_briefing.sqf";
FNC_Menu = compile preprocessFileLineNumbers "core\menu.sqf";
FNC_GearScript = compile preprocessFileLineNumbers 'customization\gear.sqf';
FNC_VehicleGearScript = compile preprocessFileLineNumbers 'customization\vehGear.sqf';

#include "modules\modules.sqf" //DO NOT REMOVE
