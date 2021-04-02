class PZAI {
	tag = "PZAI";

	class Combat {
		file = "modules\headless_ai\cfgFunctions\Combat";
		class ArmEmptyStatic {};
		class CombatAttack {};
		class CombatAssault {};
		class CombatAssaultVehicle {};
		class CombatDefend {};
		class CombatDropOff {};
		class CombatLand {};
		class CombatMode {};
		class CombatMoveTo {};
		class CombatResponse {};
		class DefaultGroupPatrol {};
		class DestroyBuilding {};
		class FindCoverPos {};
		class FlankManeuver {};
		class FocusedAccuracy {};
		class ForceHeal {};
		class FormationChange {};
		class FragmentMove {};
		class Garrison {};
		class GarrisonClear {};
		class GarrisonClearPatrol {};
		class GroupLoiter {};
		class GroupPatrol {};
		class LightGarrison {};
		class LoiterAction {};
		class MoveInCombat {};
		class MoveToCover {};
		class PlaceMine {};
		class RadioCallForSupport {};
		class RadioCommsEnemy {};
		class RadioReportThreat {};
		class RearmGo {};
		class RearmSelf {};
		class ReinforcementResponse {};
		class ReGroup {};
		class SightAid {};
		class FireWeapon {};
		class SuppressingShots {};
		class ThrowGrenade {};
		class WatchEnemy {};
		class SearchBuilding {};
		class VehicleEject {};
	};

	class Commander {
		file = "modules\headless_ai\cfgFunctions\Commander";
		class assignToArea {};
		class CommanderHandler {};
		class CommanderInit {};
	};

	class StateMachine {
		file = "modules\headless_ai\cfgFunctions\statemachine";
		class addEventTransition {};
		class addState {};
		class addTransition {};
		class clockwork {};
		class create {};
		class createFromConfig {};
		class delete {};
		class getCurrentState {};
		class manualTransition {};
		class toString {};
		class updateList {};
		class dumpPerformanceCounters {};
	};

	class CommanderSM {
		file = "modules\headless_ai\cfgFunctions\CommanderSM";
		class CM_OnStateInitial {};
	};

	class SightAidSM {
		file = "modules\headless_ai\cfgFunctions\SightAidSM";
		class SA_OnSECheckNearbyEnemies {};
		class SA_OnSECombatMode {};
		class SA_onSEEnemyInRange {};
		class SA_OnSERemoveCantSeeEnemy {};
	};

	class UnitStanceSM {
		file = "modules\headless_ai\cfgFunctions\UnitStanceSM";
		class US_onSEInitial {};
		class US_onSEResetStance {};
		class US_onSEStanceCheck {};
		class US_onSEUnitChecks {};
	};

	//class UnitCombatSM {
	//	file = "modules\headless_ai\cfgFunctions\UnitCombatSM";
	//	class UC_onSECheckNearbyEnemies {};
	//	class UC_onSEUnitChecks {};
	//};

    class CachingSM {
		file = "modules\headless_ai\cfgFunctions\CachingSM";
		class CH_onSEDistanceCheck {};
		class CH_transCacheGroup {};
		class CH_transUnCacheGroup {};
	};

	class Main {
		file = "modules\headless_ai\cfgFunctions\Main";
		class GroupHandler {};
		class initMain {};
		class MapMarkers {};
	};

	class Misc {
		file = "modules\headless_ai\cfgFunctions\Misc";
		class checkifHC {};
		class setunitskill {};
		class UnitInit {};
		class SetInit {};
		class findUniqueName {};
		class deleteVehicles {};
		class searchNestedArray {};
	};

	class BunkerSM {
		file = "modules\headless_ai\cfgFunctions\BunkerSM";
		class OnSEInitial {};
		class OnSECheckNearbyEnemies {};
		class OnSERemoveCantSeeEnemy {};
		class OnSEEnemyInRange {};
		class OnSECombatMode {};
		class OnSETarget {};
		class OnSEFire {};
		class OnSEAimed {};
		class OnSETimeOutReset {};
		class OnSEBurstReset {};
		class CondBurstCount {};
	};

	class Eventhandlers {
		file = "modules\headless_ai\cfgFunctions\Eventhandlers";
		class onFiredMan {};
	};

	class create {
		file = "modules\headless_ai\cfgFunctions\create";
	    class createFunctions {};
	    class createGroup {};
	    class createUnit {};
	    class createVehicle {};
	    class createEmptyVehicle {};
	    class createObject {};
	    class createWaypoint {};
	    class createWaypointModified {};
	    class createWaypoints {};
	    class createZone {};
	    class spawnArray {};
	};

	class Diag {
		file = "modules\headless_ai\cfgFunctions\Diag";
		class AttachPosition {};
		class BuildingCheck {};
		class BuildingSpawnCheck {};
		class checkView {};
		class Classvehicle {};
		class ClosestEnemy {};
		class ClosestObject {};
		class DriverCheck {};
		class EnemyArray {};
		class getStance {};
		class hasMine {};
		class hasAT {};
		class HasRadioGroup {};
		class IRCheck {};
		class isAimed {};
		class isInCombat {};
		class LOSCheck {};
		class StanceModifier {};
		class UnitCheck {};
		class VehicleHandle {};
		class Waypointcheck {};
		class WepSupCheck {};
		class nearbyFriendlyEntities {};
	};

	class DangerCauses {
		file = "modules\headless_ai\cfgFunctions\DangerCauses";
		class CombatMovement {};
		class CurrentStance {};
		class DeadBodyDetection {};
		class ExplosionDetection {};
		class MoveToCoverGroup {};
		class RecentEnemyDetected {};
		class SetCombatStance {};
		class stopToShoot {};
		class VehicleHandleDanger {};
	};

	class get {
		file = "modules\headless_ai\cfgFunctions\get";
	    class getBuildingList {};
	    class getBuildings {};
	    class getGroupVariables {};
	    class getNearestBuilding {};
	    class getNearestBuildings {};
	    class getNearestGroupBuildings {};
	    class getNewPos {};
	    class getRandomBuilding {};
	    class getRandomBuildings {};
	    class getRandomGroupBuildings {};
	    class getRandomPositionCircle {};
	    class getSide {};
	    class getStartBuilding {};
	    class getTasks {};
	    class getTaskParams {};
	    class getTurrets {};
	    class getWaypointDetails {};
	    class getVehicleRoles {};
	};

	class GetInfo {
		file = "modules\headless_ai\cfgFunctions\GetInfo";
	    class getDetails {};
	    class getDetailsArray {};
	    class getDetailsGroup {};
	    class getDetailsThing {};
	    class getDetailsVehicle {};
	    class getDetailsVehicleEmpty {};
	    class getDetailsUnit {};
	    class getSynced {};
	    class getSyncedGroups {};
	    class getSyncedObjects {};
	};

	class set {
		file = "modules\headless_ai\cfgFunctions\set";
	    class setAssignedVehicle {};
	    class setBuildingPos {};
	    class setCompletedTasks {};
	    class setFlashlights {};
	    class setGroupBehaviour {};
	    class setGroupVariables {};
	    class setMarkerPos {};
	    class setMultiOccupy {};
	    class setPersistent {};
	    class setRadial {};
	    class setRespawn {};
	    class setStance {};
	    class setSurrender {};
	    class setTracker {};
	    class setVehicle {};
	    class setZone {};
	};

	class task {
		file = "modules\headless_ai\cfgFunctions\task";
	    class taskActivate {};
	    class taskAssign {};
	    class taskAssault {};
	    class taskCheck {};
	    class taskComplete {};
	    class taskDropOff {};
	    class taskForceFire {};
	    class taskGroup {};
	    class taskLoiter {};
	    class taskHoldUntil {};
	    class taskInit {};
	    class taskRelease {};
	    class taskBuildingPatrol {};
	    class taskBuildingDefend {};
	    class taskMonitor {};
	    class taskMoveBuilding {};
	    class taskMoveBuildings {};
	    class taskMoveGroupBuildingsDefend {};
	    class taskMoveGroupBuildingsPatrol {};
	    class taskMoveMultipleBuildingsDefend {};
	    class taskMoveMultipleBuildingsPatrol {};
	    class taskMoveNearestBuildingDefend {};
	    class taskMoveNearestBuildingPatrol {};
	    class taskMoveRandomBuildingDefend {};
	    class taskMoveRandomBuildingPatrol {};
	    class taskMoveRandomGroupBuildingsDefend {};
	    class taskMoveRandomGroupBuildingsPatrol {};
	    class taskMoveRandomMultipleBuildingsDefend {};
	    class taskMoveRandomMultipleBuildingsPatrol {};
	    class taskRegister {};
	    class taskRemoveZoneActivated {};
	    class taskSearchNearby {};
	    class taskSet {};
	    class taskPickup {};
	    class taskSetBunker {};
	    class taskSentry {};
	    class taskPlacement {};
	    class taskPatrol {};
	    class taskPatrolPerimeter {};
	};
};
