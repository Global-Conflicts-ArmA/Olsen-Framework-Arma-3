#include "..\..\core\script_macros.hpp"

private _version = 0.1;

["Start on team color", "Allows the mission maker to set the team colors in squads on start.", "Olsen &amp; StatusRed", _version] call FUNC(RegisterModule);

[] call FUNC(SOTC_Init);
