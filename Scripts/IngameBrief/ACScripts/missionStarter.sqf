bluforStarter = BlueBoard addAction ["Begin Mission", "ingameBrief\ACScripts\startTheMissionBlu.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == west)"];

opforStarter = RedBoard addAction ["Begin Mission", "ingameBrief\ACScripts\startTheMissionRed.sqf", nil, 0, false, true, "", "(_target distance _this) < 4 && (side player == east)"];

[] spawn {
	[] execVM "ingameBrief\ACScripts\beginTheMission.sqf";
  }; 