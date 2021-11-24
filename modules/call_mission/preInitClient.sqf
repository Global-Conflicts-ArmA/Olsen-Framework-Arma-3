#include "script_component.hpp"

private _version = 0.1;

["Call Mission", "Adds a new sections to the framework menu that allows COs and admins to call the mission.", "Starfox64 &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

GVAR(IsAdmin) = false;

[{!isnull (finddisplay 46)}, {
  // serverCommandAvailable must be executed from a UI Eh.
  (findDisplay 46) displayAddEventHandler ["MouseMoving", {
    if (serverCommandAvailable "#kick") then {
      GVAR(IsAdmin) = true;
    } else {
      GVAR(IsAdmin) = false;
    };
  }];
}, []] call CBA_fnc_waitUntilAndExecute;

if (!isDedicated) then {
  private _sleepTime = 0.1;
  
  [{
		#include "menu.sqf"
  }, [], _sleepTime] call CBA_fnc_waitAndExecute;
};
