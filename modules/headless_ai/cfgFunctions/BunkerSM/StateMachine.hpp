#include "..\..\script_macros.hpp"

class GVAR(bunkerStateMachine) {
    list = QUOTE(allUnits select { \
        local _x && \
        {!isNull _x} && \
        {alive _x} && \
        {!isPlayer (leader _x)} && \
        {!(QGETVAR(_x,NOAI,false))} && \
        {QGETVAR(group _x,Spawned,false)} && \
        {side _x in GVAR(SideBasedExecution)} && \
        {((QGETVAR(group _x,Mission,'NONE')) isEqualTo 'BUNKER') || {(QGETVAR(_x,Bunker,false))}} \
    });
    skipNull = 1;
    repeatPerFrame = 4;
    class Initial {
        onStateEntered = QFUNC(onSEInitial);
        class isInitialized {
            targetState = QUOTE(Enemy_Check_);

            condition = QUOTE(true);
        };
    };
    class Enemy_Check_ {
        onStateEntered = QFUNC(onSEEnemyInRange);
        class Enemy_in__Range {
            targetState = QUOTE(Check_Nearby_Ene);

            condition = QUOTE(!((QGETVAR(_this,enemyInRange,[])) isEqualTo []));
        };
        class No_Enemy__in_Ran {
            targetState = QUOTE(Wait);

            condition = QUOTE(true);
        };
    };
    class Check_Nearby_Ene {
        onStateEntered = QFUNC(onSECheckNearbyEnemies);
        class Can_See {
            targetState = QUOTE(CombatMode);

            condition = QUOTE(!((QGETVAR(_this,enemyInView,[])) isEqualTo []));
        };
        class Can_Not_See {
            targetState = QUOTE(Wait);

            condition = QUOTE(true);
        };
    };
    class CombatMode {
        onStateEntered = QFUNC(onSECombatMode);
        class Vehicle {
            targetState = QUOTE(Enemy_Check_);

            condition = QUOTE(!(vehicle _this isEqualTo _this));
        };
        class Infantry {
            targetState = QUOTE(Target);

            condition = QUOTE((vehicle _this isEqualTo _this));
        };
    };
    class Target {
        onStateEntered = QFUNC(onSETarget);
        class Move_to__Aimed {
            targetState = QUOTE(Aimed);

            condition = QUOTE(true);
        };
    };
    class Fire {
        onStateEntered = QFUNC(onSEFire);
        class Return_To_Aim {
            targetState = QUOTE(Aimed);
            conditionFrequency = 0.05;
            condition = QUOTE(true);
        };
    };
    class Refill_Ammo {
        onStateEntered = QUOTE((vehicle _this) setAmmo [ARR_2(primaryWeapon (vehicle _this), 10000)]);
        class Return_to_AIm {
            targetState = QUOTE(Aimed);

            condition = QUOTE(true);
        };
    };
    class Burst_Reset {
        onStateEntered = QFUNC(onSEBurstReset);
        class Burst_Reset_Coun {
            targetState = QUOTE(Enemy_Check_);

            condition = QUOTE(((QGETVAR(_this,BurstResetCount,0)) >= QGETMVAR(MaxBurstResetCount,3)));
        };
        class Enemy_in__Range {
            targetState = QUOTE(Check_Nearby_Ene);

            condition = QUOTE(!((QGETVAR(_this,enemyInRange,[])) isEqualTo []));
        };
        class Can_Not_See {
            targetState = QUOTE(Enemy_Check_);

            condition = QUOTE(true);
        };
    };
    class Timeout_Reset {
        onStateEntered = QFUNC(onSETimeOutReset);
        class Return {
            targetState = QUOTE(Enemy_Check_);

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
    class Aimed {
        onStateEntered = QFUNC(onSEAimed);
        class Burst {
            targetState = QUOTE(Burst_Reset);

            condition = QUOTE(([_this] call FUNC(CondBurstCount)));
        };
        class Time_Out {
            targetState = QUOTE(Timeout_Reset);

            condition = QUOTE(((CBA_MissionTime >= ((QGETVAR(_this,TargetStartTime,CBA_MissionTime)) + 4)) || ((CBA_MissionTime >= ((QGETVAR(_this,TargetStartTime,CBA_MissionTime)) + 2)) && {(CBA_MissionTime >= ((QGETVAR(_this,LastFiredTime,CBA_MissionTime)) + 2))})));
        };
        class No_Ammo {
            targetState = QUOTE(Refill_Ammo);

            condition = QUOTE((_this ammo currentMuzzle _this) == 0);
        };
        class Aimed {
            targetState = QUOTE(Fire);

            condition = QUOTE(([_this] call FUNC(isAimed)));
        };
    };
};
