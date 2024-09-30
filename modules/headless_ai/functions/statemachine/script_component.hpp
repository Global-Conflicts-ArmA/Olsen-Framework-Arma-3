#include "..\..\script_component.hpp"

#define TRANSITIONS(var) (var + "_transitions")
#define EVENTTRANSITIONS(var) (var + "_eventTransitions")
#define ONSTATE(var) (var + "_onState")
#define ONSTATEENTERED(var) (var + "_onStateEntered")
#define ONSTATELEAVING(var) (var + "_onStateLeaving")
#define GET_FUNCTION(var,cfg) private var = getText (cfg); \
    if (isNil var) then { \
        var = compile var; \
    } else { \
        var = missionNamespace getVariable var;\
    }
