#include "script_component.hpp"


params ["_unit","_target",["_rounds",1,[0]],["_fireMode","close",[""]]];
_unit doWatch _target;
