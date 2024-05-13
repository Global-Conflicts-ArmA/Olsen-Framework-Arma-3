#include "script_component.hpp"

class GVAR(sightAidStateMachine) {
    list = QUOTE(allUnits select {\
        local _x && \
        {!isNull _x} && \
        {alive _x} && \
        {!isPlayer (leader _x)} && \
        {!(QGETVAR(_x,NOAI,false))} && \
        {QGETVAR(group _x,Spawned,false)} && \
        {!((QGETVAR(group _x,Mission,'NONE')) isEqualTo 'BUNKER') && {!(QGETVAR(_x,Bunker,false))}} && \
        {(QGETMVAR(SightAidVehicles,true)) || {vehicle _x isEqualTo _x}} \
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
        //onStateEntered = QFUNC(SA_onSEWait);
        class Same_Enemy_ {
            targetState = QUOTE(Combat);
            condition = QUOTE([_this] call FUNC(SA_condSameEnemy));
        };
        class Enemy_in__Range {
            targetState = QUOTE(Check_Nearby_Ene);
            condition = QUOTE([_this] call FUNC(SA_condEnemyInRange));
        };
        class No_Enemy__in_Ran {
            targetState = QUOTE(Wait);
            condition = QUOTE(true);
        };
    };
    class Check_Nearby_Ene {
        class Can_See {
            targetState = QUOTE(Combat);
            condition = QUOTE([_this] call FUNC(SA_condCanSee));
        };
        class Can_Not_See {
            targetState = QUOTE(Wait);
            condition = QUOTE(true);
        };
    };
    class Combat {
        onStateEntered = QFUNC(SA_onSECombat);
        class Wait {
            targetState = QUOTE(Wait);
            conditionFrequency = 1;
            condition = QUOTE(true);
        };
    };
    class Wait {
        onStateEntered = "";
        class Wait_Completed {
            targetState = QUOTE(Enemy_Check_);
            conditionFrequency = 1;
            condition = QUOTE(true);
        };
    };
};
