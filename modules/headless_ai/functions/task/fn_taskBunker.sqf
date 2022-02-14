#include "script_component.hpp"

params [
    "_group"
];

(units _group) apply {
    SETVAR(_x,BUNKER,true);
};
SETVAR(_group,Task,"BUNKER");
