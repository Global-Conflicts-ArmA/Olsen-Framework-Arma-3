#include "script_component.hpp"

if (!isDedicated) then {
  #include "..\..\settings.sqf"

  "" spawn {
    private _color = GETVAR(player, FW_TeamColor, "NONE");

  	sleep 0.01;

  	if (_color != "NONE") then {
  		["CBA_teamColorChanged", [player, _color]] call CBA_fnc_globalEvent;
      SETVAR(player, FW_TeamColor, nil);

  	};
  };
};
