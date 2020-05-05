#include "..\..\script_macros.hpp"

class GVAR(sightAidStateMachine) {
    list = QUOTE(allUnits select {\
        local _x && \
        {!isPlayer _x} &&\
        {!(QGETVAR(_x,NOAI,false))} &&\
        {(side (leader _x)) in GVAR(SideBasedExecution)} &&\
        {(vehicle _x isEqualTo _x) || (QGETMVAR(SightAidVehicles,false))}\
    });
    skipNull = 1;
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

            condition = QUOTE((QGETVAR(_this,SA_seeChecks,0) > 3));
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
