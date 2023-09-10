// special manual task
class Manual {
    function = "";
    isMove = false;
    needsPos = false;
    combatResponse = "";
    reinforce = false;
};
// basic move task
class Move {
    function = QFUNC(taskPatrol);
    isMove = true;
    needsPos = true;
    combatResponse = QFUNC(responseAttack);
    reinforce = true;
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
    combatResponse = "";
    reinforce = false;
};
// basic defend task
class Defend: Move {
    function = QFUNC(taskDefend);
    isMove = false;
    combatResponse = QFUNC(responseDefend);
    reinforce = false;
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
    combatResponse = QFUNC(responseChance);
};
// basic patrol task
class Patrol: Move {
    function = QFUNC(taskPatrol);
    needsPos = false;
    combatResponse = QFUNC(responseChance);
};
class Sentry: Patrol {
    function = QFUNC(taskSentry);
    needsPos = false;
};
