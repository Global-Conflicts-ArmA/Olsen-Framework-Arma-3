class PZAI_Group_StateMachine {
    list = QUOTE(allGroups select {
            local _x &&
            {(GETVAR(_x,Group_Spawned,false))} &&
            {!(GETVAR(_x,Group_NoAI,false))}
            });
    skipNull = 1;

    class Init {
        onStateEntered = QFUNC(onInitEntered);
        class DoTask {
            targetState = "DoTask";
            condition = QUOTE(CBA_missionTime > 0);
        };
    };

    class DoTask {
        onStateEntered = QFUNC(onDoTaskEntered);

        class TaskPatrol {
            targetState = "TaskPatrol";
            events[] = {QGVAR(patrol)};
        };

        class DoNothing {
            targetState = "DoNothing";
            events[] = {QGVAR(doNothing)};
        };
    };

    class TaskPatrol {
        onStateEntered = QFUNC(onPatrolEntered);
        onState = QFUNC(onPatrolRandom);

        class DoTask {
            targetState = "DoTask";
            events[] = {QGVAR(doTask)};
        };

        class PatrolBuildings {
            targetState = "PatrolBuildings";
            events[] = {QGVAR(patrolBuildings)};
        };

        class Embark {
            targetState = "Embark";
            events[] = {QGVAR(embark)};
        };

        class Disembark {
            targetState = "Disembark";
            events[] = {QGVAR(disembark)};
        };

        class Wait {
            targetState = "Wait";
            events[] = {QGVAR(wait)};
        };
    };

    class DoNothing {
        onStateEntered = "";
        class DoTask {
            targetState = "DoTask";
            condition = QFUNC(checkDoTask);
        };
    };

    class Wait {
        onStateEntered = QUOTE(_this setVariable [ARR_2(QQGVAR(waitUntil), CBA_missionTime + 30 + random 30)]);

        class DoTask {
            targetState = "DoTask";
            condition = QUOTE(CBA_missionTime >= _this getVariable [ARR_2(QQGVAR(waitUntil), CBA_missionTime)]);
        };
    };
};
