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
    combatResponse = "";
    reinforce = false;
};
class Assault: Attack {
    function = QFUNC(taskAssault);
    combatResponse = "";
    reinforce = false;
};
class Hunt: Attack {
    function = QFUNC(taskHunt);
    combatResponse = "";
    reinforce = false;
};
class DropOff: Move {
    function = QFUNC(taskDropOff);
    isMove = true;
    needsPos = true;
    combatResponse = QFUNC(responseAttack);
    reinforce = false;
};
class Cover: Move {
    function = QFUNC(taskCover);
    isMove = true;
    needsPos = true;
    combatResponse = "";
    reinforce = false;
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
    combatResponse = "";
    needsPos = true;
};
class Stationary: Defend {
    function = QFUNC(taskStationary);
    combatResponse = "";
    needsPos = false;
};
class AmbientFire: Stationary {
    function = QFUNC(taskAmbientFire);
    needsPos = false;
    isMove = false;
    combatResponse = "";
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
