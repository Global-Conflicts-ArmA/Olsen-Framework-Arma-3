["Ammo Counter", "Counts ammunition types fired and displays it in the mission endscreen.", "TinfoilHate"] call FUNC(RegisterModule);

//Ammo Counter Initilization
//Much script by beta, some script by TinfoilHate
//Sets up ammo counting
/*	It's dangerous to go alone, take this:
	_ammoArray = [];
	{
		{
			_ammoClass = getText (configFile >> "CfgMagazines" >> _x >> "ammo");
			if !(_ammoClass in _ammoArray) then {
				_ammoArray set [count _ammoArray,_ammoClass];
			};
		} forEach magazines _x;
	} forEach allMissionObjects "ALL";
	diag_log _ammoArray;
*/

