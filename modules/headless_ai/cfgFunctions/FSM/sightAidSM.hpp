<<<<<<<< HEAD:modules/headless_ai/cfgFunctions/FSM/sightAidSM.hpp
========
#include "script_component.hpp"

>>>>>>>> origin/dev:modules/headless_ai/functions/SightAidSM/StateMachine.hpp
class GVAR(sightAidStateMachine) {
    list = QUOTE(allUnits select {\
        local _x && \
        {!isNull _x} && \
        {alive _x} && \
        {!isPlayer (leader _x)} && \
        {!(QGETVAR(_x,NOAI,false))} && \
        {QGETVAR(group _x,Spawned,false)} && \
        {((QGETVAR(group _x,Mission,'NONE')) isNotEqualTo 'BUNKER') && {!(QGETVAR(_x,Bunker,false))}} && \
        {(QGETMVAR(SightAidVehicles,true)) || {vehicle _x isEqualTo _x}} \
    });
    skipNull = 1;
    repeatPerFrame = 1;
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

            condition = QUOTE((QGETVAR(_this,SA_enemyInRange,[])) isNotEqualTo []);
        };
        class No_Enemy__in_Ran {
            targetState = QUOTE(Wait);

            condition = QUOTE(true);
        };
    };
    class Check_Nearby_Ene {
        onStateEntered = QFUNC(SA_OnSECheckNearbyEnemies);
        class Can_See {
            targetState = QUOTE(CombatCheck);

            condition = QUOTE((QGETVAR(_this,SA_enemyTarget,objnull)) isNotEqualTo objnull);
        };
        class Can_Not_See {
            targetState = QUOTE(Remove_Cant_See);

            condition = QUOTE(true);
        };
    };
    class CombatCheck {
        onStateEntered = QFUNC(SA_onSECombatMode);
        class WaitDoneCond {
            targetState = QUOTE(Wait);
            condition = QUOTE(true);
        };
    };
    class Remove_Cant_See {
        onStateEntered = QFUNC(SA_onSERemoveCantSeeEnemy);
        class Check_Next_Enemy {
            targetState = QUOTE(Check_Nearby_Ene);
            conditionFrequency = 0.1;
            condition = QUOTE((QGETVAR(_this,SA_enemyInRange,[])) isNotEqualTo []);
        };
        class Max_Checks {
            targetState = QUOTE(Wait);

            condition = QUOTE(QGETVAR(_this,SA_seeChecks,0) > 8);
        };
        class No_Enemy__in_Ran {
            targetState = QUOTE(Wait);

            condition = QUOTE(true);
        };
    };
    class Wait {
        onStateEntered = QFUNC(SA_onWait);
        class Wait_Completed {
            targetState = QUOTE(Enemy_Check_);
            conditionFrequency = 2;
            condition = QUOTE(true);
        };
    };
};
