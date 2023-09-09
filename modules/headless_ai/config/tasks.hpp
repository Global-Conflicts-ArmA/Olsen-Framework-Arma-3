// basic move task
class Move {
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
// basic patrol task
class Patrol: Move {
    function = QFUNC(taskPatrol);
    needsPos = false;
};
