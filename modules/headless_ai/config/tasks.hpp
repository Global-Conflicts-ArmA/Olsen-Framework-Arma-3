class Move {
    isMove = true;
    needsPos = true;
};
class Attack {
    function = QFUNC(taskAttack);
    isMove = true;
    needsPos = true;
};
class Assault {
    function = QFUNC(taskAssault);
    isMove = true;
    needsPos = true;
};
class Bunker {
    function = QFUNC(taskBunker);
    isMove = false;
};
class Patrol {
    function = QFUNC(taskPatrol);
    isMove = true;
};
class Defend {
    function = QFUNC(taskDefend);
    isMove = true;
};
class Stationary {
    function = QFUNC(taskStationary);
    isMove = false;
};
