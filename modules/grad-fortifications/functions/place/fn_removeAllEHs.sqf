#include "script_component.hpp"

(findDisplay 46) displayRemoveEventHandler ["MouseZChanged",GVAR(mousewheelEH)];
(findDisplay 46) displayRemoveEventHandler ["MouseButtonUp",GVAR(mousebuttonEH)];
(findDisplay 46) displayRemoveEventHandler ["KeyDown",GVAR(keydownEH)];
(findDisplay 46) displayRemoveEventHandler ["KeyUp",GVAR(keyupEH)];

[GVAR(updatePFH)] call CBA_fnc_removePerFrameHandler;
[GVAR(checkCollisionPFH)] call CBA_fnc_removePerFrameHandler;

ACE_player removeAction GVAR(fireOverride);
