class Assault {
    function = QFUNC(taskAssault);
    isMove = true;
    needsPos = true;
};
class Attack {
    function = QFUNC(taskAttack);
    isMove = true;
    needsPos = true;
};
class Bunker {
    function = QFUNC(taskBunker);
    isMove = false;
    needsPos = true;
};
class Defend {
    function = QFUNC(taskDefend);
    isMove = false;
    needsPos = true;
};
class Garrison {
    isMove = QFUNC(taskGarrison);
    isMove = false;
    needsPos = true;
};
class Move {
    isMove = true;
    needsPos = true;
};
class Patrol {
    function = QFUNC(taskPatrol);
    isMove = true;
    needsPos = false;
};
class Stationary {
    function = QFUNC(taskStationary);
    isMove = false;
    needsPos = false;
};
