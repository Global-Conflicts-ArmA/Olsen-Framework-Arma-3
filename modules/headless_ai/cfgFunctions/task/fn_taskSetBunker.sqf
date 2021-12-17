#include "..\..\script_macros.hpp"

params [
    "_group"
];

(units _group) apply {
    SETVAR(_x,BUNKER,true);
};
SETVAR(_group,InitialWPSet,true);
SETVAR(_group,Task,"BUNKER");
true
