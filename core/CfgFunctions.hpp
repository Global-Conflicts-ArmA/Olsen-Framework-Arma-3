class Core {
	file = "core\functions";
	class addItemOrg {};
	class addItemRandomOrg {};
	class addItemVehicleOrg {};
	class addItemVehicleRandomOrg {};
	class addTeam {};
	class isAlive {};
	class areaCount {};
	class canAttachItem {};
	class canLinkItem {};
	class casualtyCount {};
	class casualtyPercentage {};
	class checkClassname {};
	class debugMessage {};
	class endMission {};
	class eventDisconnect {};
	class eventKilled {};
	class eventRespawned {};
	class eventSpawned {};
	class forceTerrainGrid {};
	class getDamagedAssets {};
	class getTeamVariable {};
	class getEmptyPositions {};
	class hasExtracted {};
	class makeUnitsList {};
	class notTrackUnit {};
	class registerModule {};
	class removeAllGear {};
	class removeAllVehicleGear {};
    class softEndMission {};
	class parsedTextDisplay {};
	class spectatePrep {};
	class trackAsset {};
	class untrackUnit {};
	class briefing {};
	class gearExport {};
	class gearScript {};
	class getCO {};
	class vehGearScript {};
	class postChecks {};
	class initLoadingScreen {};
	class initSafeStart {};
};

class Spectator {
	file = "core\functions\spectator";
	class startSpectator {};
	class initSpectateScreen {};
	class spectatorBriefing {};
	class parseBriefing {};
	class initCamera {};
	class cameraHandleKeyDown {};
	class freezeUnit {};
	class thawUnit {};
	class handleComboBoxChange {};
	class handleListChange {};
};

class XEH {
	file = "core\XEH";
	class initCAManBase {};
	class killedCAManBase {};
	class respawnCAManBase {};
};

class endscreen {
	file = "core\dia\endscreen";
	class endScreen {};
};

class debug {
	file = "core\dia\debug";
	class debug {};
};

class ShotCount {
	file = "core\functions\shotCount";
	class firedEH {};
	class getDisplayName {};
	class shotCount {};
	class shotDisplay {};
};

class Markers {
	file = "core\functions\markers";
	class arrowToMap {};
	class drawToMap {};
	class writeToMap {};
	class writeToMapFont {};
	class clearmarkers {};
};
