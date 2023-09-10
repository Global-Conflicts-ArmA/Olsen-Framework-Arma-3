// special manual task
class Manual {
    function = "";
    isMove = false;
    needsPos = false;
};
// basic move task
class Move {
    function = QFUNC(taskPatrol);
    isMove = true;
    needsPos = true;
};
class Attack: Move {
    function = QFUNC(taskAttack);
};
class Assault: Attack {
    function = QFUNC(taskAssault);
};
// basic bunker task
class Bunker: Move {
    function = QFUNC(taskBunker);
    isMove = false;
};
// basic defend task
class Defend: Move {
    function = QFUNC(taskDefend);
    isMove = false;
};
class Garrison: Defend {
    function = QFUNC(taskGarrison);
    needsPos = true;
};
class Stationary: Defend {
    function = QFUNC(taskStationary);
    needsPos = false;
};
class Loiter: Defend {
    function = QFUNC(taskLoiter);
    needsPos = false;
};
// basic patrol task
class Patrol: Move {
    function = QFUNC(taskPatrol);
    needsPos = false;
};
class Sentry: Patrol {
    function = QFUNC(taskSentry);
    needsPos = false;
};
