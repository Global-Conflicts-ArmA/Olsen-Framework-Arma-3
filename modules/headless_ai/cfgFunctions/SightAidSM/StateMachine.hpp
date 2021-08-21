#include "..\..\script_macros.hpp"

class GVAR(sightAidStateMachine) {
    list = QUOTE(allUnits select {\
        local _x && \
        {!isNull _x} && \
        {alive _x} && \
        {!isPlayer (leader _x)} && \
        {!(QGETVAR(_x,NOAI,false))} && \
        {QGETVAR((group _x),Spawned,false)} && \
        {!((behaviour _x) isEqualTo 'CARELESS')} && \
        {!((combatMode group _x) in [ARR_3('BLUE', 'GREEN', 'WHITE')])} && \
        {side _x in GVAR(SideBasedExecution)} && \
        {!((QGETVAR(group _x,Mission,'NONE')) isEqualTo 'BUNKER') && {!(QGETVAR(_x,Bunker,false))}} && \
        {(QGETMVAR(SightAidVehicles,true)) || {vehicle _x isEqualTo _x}} \
    });
    skipNull = 1;
    repeatPerFrame = 2;
    class Initial {
        onStateEntered = "";
        class isInitialized {
            targetState = QUOTE(Enemy_Check_);

            condition = QUOTE(true);
        };
    };
    class Enemy_Check_ {
        onStateEntered = QFUNC(SA_onSEEnemyInRange);
        class Enemy_in__Range {
            targetState = QUOTE(Check_Nearby_Ene);

            condition = QUOTE(!((QGETVAR(_this,SA_enemyInRange,[])) isEqualTo []));
        };
        class No_Enemy__in_Ran {
            targetState = QUOTE(Wait);

            condition = QUOTE(true);
        };
    };
    class Check_Nearby_Ene {
        onStateEntered = QFUNC(SA_OnSECheckNearbyEnemies);
        class Can_See {
            targetState = QUOTE(CombatMode);

            condition = QUOTE(([ARR_2((vehicle _this),QGETVAR(_this,SA_enemyTarget,objnull))] call FUNC(LOSCheck)));
        };
        class Can_Not_See {
            targetState = QUOTE(Remove_Cant_See);

            condition = QUOTE(true);
        };
    };
    class CombatMode {
        onStateEntered = QFUNC(onSECombatMode);
        class Wait {
            targetState = QUOTE(Enemy_Check_);
            conditionFrequency = 2;
            condition = QUOTE(true);
        };
    };
    class Remove_Cant_See {
        onStateEntered = QFUNC(SA_onSERemoveCantSeeEnemy);
        class Max_Checks {
            targetState = QUOTE(Wait);

            condition = QUOTE(QGETVAR(_this,SA_seeChecks,0) > 8);
        };
        class Check_Next_Enemy {
            targetState = QUOTE(Check_Nearby_Ene);

            condition = QUOTE(!((QGETVAR(_this,SA_enemyInRange,[])) isEqualTo []));
        };
        class No_Enemy__in_Ran {
            targetState = QUOTE(Wait);

            condition = QUOTE(true);
        };
    };
    class Wait {
        onStateEntered = "";
        class Wait_Completed {
            targetState = QUOTE(Enemy_Check_);
            conditionFrequency = 2;
            condition = QUOTE(true);
        };
    };
};
