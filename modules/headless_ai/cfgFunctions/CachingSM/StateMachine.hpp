#include "..\..\script_macros.hpp"

class GVAR(cachingStateMachine) {
    list = QUOTE(allGroups select {\
        private _leader = leader _x; \
        local _leader && \
        {!(isNull _leader)} && \
        {(alive _leader)} && \
        {!isPlayer _leader} && \
        {!(QGETVAR(_leader,NOAI,false))} && \
        {QGETVAR(_x,Spawned,false)} && \
        {side _leader in GVAR(SideBasedExecution)} \
    });
    skipNull = 1;
    repeatPerFrame = ;
    class Initial {
        onStateEntered = "";
        class isInitialized {
            targetState = QUOTE(Distance_Check_);

            condition = QUOTE(true);
        };
    };
    class Distance_Check_ {
        onStateEntered = QFUNC(CH_onSEDistanceCheck);
        class No_Enemy_in__Ran {
            targetState = QUOTE(Cache_Group);

            condition = QUOTE(QGETVAR(_this,CH_enemyInRange,false) && {!((behaviour (leader _this)) in ['COMBAT','STEALTH'])});            onTransition = QFUNC(CH_transCacheGroup);
        };
        class Enemy__in_Range {
            targetState = QUOTE(Wait);

            condition = QUOTE(true);
        };
    };
    class Cache_Group {
        onStateEntered = QFUNC(CH_onSEDistanceCheck);
        class Enemy_in__Range {
            targetState = QUOTE(Uncache_Group_Wa);

            condition = QUOTE(QGETVAR(_this,CH_enemyInRange,false) && {!((behaviour (leader _this)) in ['COMBAT','STEALTH'])});            onTransition = QFUNC(CH_transUnCacheGroup);
        };
        class Can_Not_See {
            targetState = QUOTE(Wait_Cached);

            condition = QUOTE(true);
        };
    };
    class Uncache_Group_Wa {
        onStateEntered = "";
        class Wait {
            targetState = QUOTE(Distance_Check_);
            conditionFrequency = 2;
            condition = QUOTE(true);
        };
    };
    class Wait_Cached {
        onStateEntered = "";
        class Cached_Wait_Comp {
            targetState = QUOTE(Cache_Group);
            conditionFrequency = 2;
            condition = QUOTE(true);
        };
    };
    class Wait {
        onStateEntered = "";
        class Wait_Completed {
            targetState = QUOTE(Distance_Check_);
            conditionFrequency = 2;
            condition = QUOTE(true);
        };
    };
};
