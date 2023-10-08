class COMPONENT {
	tag = COMPONENT;

    class BunkerSM {
		file = "modules\headless_ai\functions\BunkerSM";
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
		class CondBurstCount {}; //TODO: rename to proper format
	};

    class CachingSM {
    	file = "modules\headless_ai\functions\CachingSM";
    	class CH_onSEDistanceCheck {};
    	class CH_transCacheGroup {};
    	class CH_transUnCacheGroup {};
    };

	class Combat {
		file = "modules\headless_ai\functions\Combat";
		class ArmEmptyStatic {};
		class combatAmbientFire {};
		class CombatAttack {};
		class CombatAssault {};
		class CombatAssaultVehicle {};
		class CombatCover {};
		class CombatCoverVehicle {};
		class CombatDefend {};
		class CombatDropOff {};
        class CombatGarrison {};
		class CombatLand {};
		class CombatMode {};
		class CombatHunt {};
		class CombatMoveTo {};
		class CombatResponse {};
		class DefaultGroupPatrol {};
		class DestroyBuilding {};
		class FindCoverPos {};
        class FireAT {};
		class FireUGL {};
		class FlankManeuver {};
		class FocusedAccuracy {};
		class ForceHeal {};
		class FormationChange {};
		class FragmentMove {};
		class LightGarrison {};
		class LoiterAction {};
		class MoveInCombat {};
		class MoveToCover {};
		class PlaceMine {};
		class RadioCallForSupport {};
		class RadioCommsEnemy {};
		class ReinforcementResponse {};
		class FireWeapon {};
		class SuppressDirection {};
		class SuppressingShots {};
		class ThrowGrenade {};
		class WatchEnemy {};
		class PrepToFire {};
		class exitFiring {};
		class SearchBuilding {};
		class VehicleEject {};
	};

	class Commander {
		file = "modules\headless_ai\functions\Commander";
		class assignToArea {};
		class CommanderHandler {};
		class CommanderInit {};
        class RadioReportThreat {};
	};

    class create {
    	file = "modules\headless_ai\functions\create";
        class createFunctions {};
        class createGroup {};
        class createUnit {};
        class createVehicle {};
        class createEmptyVehicle {};
        class createObject {};
        class createWaypoint {};
        class createWaypointModified {};
        class createWaypoints {};
        class createSubGroup {};
        class createZone {};
        class finishGroupSpawn {};
        class finishVehicleSpawn {};
        class setAssignedVehicle {};
        class spawnArray {};
        class spawnGroupPFH {};
        class spawnUnitsGroupPFH {};
        class spawnUnitsVehiclePFH {};
    };

    class DangerCauses {
    	file = "modules\headless_ai\functions\DangerCauses";
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

    class Diag {
    	file = "modules\headless_ai\functions\Diag";
    	class checkView {};
    	class clearSight {};
    	class closestEnemy {};
    	class ClosestObject {};
    	class DriverCheck {};
    	class EnemyArray {};
    	class getGrenades {};
    	class getMuzzles {};
    	class getStance {};
    	class getWeaponType {};
    	class hasMine {};
    	class hasAT {};
    	class hasMG {};
    	class hasUGL {};
    	class UGLRoundType {};
    	class muzzleMags {};
    	class HasRadioGroup {};
    	class IRCheck {};
    	class isAimed {};
    	class isInCombat {};
    	class isMoveTask {};
    	class LOSCheck {};
    	class tempRemovePrimaryMags {};
    	class nearbyFriendlyEntities {};
    	class randPos {};
    };

    class Eventhandlers {
		file = "modules\headless_ai\functions\Eventhandlers";
		class onFiredMan {};
	};

    class get {
		file = "modules\headless_ai\functions\get";
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
	    class getStartBuilding {};
	    class getTurrets {};
	    class getWaypointDetails {};
	    class getVehicleRoles {};
	};

	class GetInfo {
		file = "modules\headless_ai\functions\GetInfo";
	    class getDetailsGroup {};
	    class getDetailsThing {};
	    class getDetailsVehicle {};
	    class getDetailsVehicleEmpty {};
	    class getDetailsUnit {};
	    class getSynced {};
	    class getSyncedObjects {};
	};

    class Main {
		file = "modules\headless_ai\functions\Main";
		class GroupHandler {};
		class initMain {};
	};

	class Misc {
		file = "modules\headless_ai\functions\Misc";
		class checkifHC {};
        class deleteVehicles {};
        class findUniqueName {};
        class initPostMan {};
        class searchNestedArray {};
        class setInit {};
		class setunitskill {};
		class targetHelper {};
		class unitInit {};
	};

    class Responses {
		file = "modules\headless_ai\functions\Responses";
		class responseDefend {};
		class responseAttack {};
		class responseChance {};
	};

    class set {
		file = "modules\headless_ai\functions\set";
	    class setBuildingPos {};
	    class setFlashlights {};
	    class setGroupBehaviour {};
	    class setGroupVariables {};
        class setMultiOccupy {};
	    class setRespawn {};
	    class setStance {};
	    class setSurrender {};
	    class setVehicle {};
	};

    class SightAidSM {
		file = "modules\headless_ai\functions\SightAidSM";
		class SA_condEnemyInRange {};
		class SA_condSameEnemy {};
		class SA_condCanSee {};
		class SA_onSECombat {};
		class SA_onSEWait {};
	};

	class StateMachine {
		file = "modules\headless_ai\functions\statemachine";
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

	class task {
		file = "modules\headless_ai\functions\task";
	    class taskAmbientFire {};
	    class taskAssign {};
	    class taskAssault {};
	    class taskCover {};
	    class taskDropOff {};
	    class taskLoiter {};
	    class taskHoldUntil {};
	    class taskRelease {};
	    class taskSearchNearby {};
	    class taskPickup {};
	    class taskHunt {};
	    class taskBunker {};
        class taskDefend {};
        class taskAttack {};
	    class taskSentry {};
	    class taskStationary {};
	    class taskPatrol {};
	    class taskPatrolPerimeter {};
        class taskGarrison {};
	};

    class UnitStanceSM {
		file = "modules\headless_ai\functions\UnitStanceSM";
		class US_onSEInitial {};
		class US_onSEResetStance {};
		class US_onSEStanceCheck {};
		class US_onSEUnitChecks {};
	};
};
