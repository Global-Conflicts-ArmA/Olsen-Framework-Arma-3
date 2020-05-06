class FW {
	tag = "FW";

	class Core {
		file = "core\functions";
		class addItemOrg {};
		class addItemRandomOrg {};
		class addItemVehicleOrg {};
		class addItemVehicleRandomOrg {};
		class addTeam {};
		class alive {};
		class areaCount {};
		class canAttachItem {};
		class canLinkItem {};
		class casualtyCount {};
		class casualtyPercentage {};
		class checkClassname {};
		class countTeam {};
		class createRespawnMarker {};
		class debugMessage {};
		class endMission {};
		class eventDisconnect {};
		class eventKilled {};
		class eventPlayerSpawned {};
		class eventRespawned {};
		class eventSpawned {};
		class forceTerrainGrid {};
		class getDamagedAssets {};
		class getTeamVariable {};
		class hasEmptyPositions {};
		class hasExtracted {};
		class inVehicle {};
		class makeUnitsList {};
		class notTrackUnit {};
		class randomRange {};
		class registerModule {};
		class removeAllGear {};
		class removeAllVehicleGear {};
		class setTeamVariable {};
		class spectatePrep {};
		class stackNames {};
		class startingCount {};
		class trackAsset {};
		class trackUnit {};
		class untrackUnit {};
		class briefing {};
		class gear {};
		class vehGear {};
		class postChecks {};
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
		class SC_FiredEH {};
		class SC_getDisplayName {};
		class SC_shotCount {};
		class SC_shotDisplay {};
	};
};
