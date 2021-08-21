["tin_var_artyObservers",[	//[OBJECT,"STRING",side]

[FO,"GLASS 0",west],[CO,"GLASS 1",west],[xo,"GLASS 2",west],[CSM,"GLASS 3",west],[FAC,"GLASS 4",west]





]] call tin_fnc_publicVariable;

["tin_var_artyFreq_west",5] call tin_fnc_publicVariable;
["tin_var_artyFreq_east",0] call tin_fnc_publicVariable;
["tin_var_artyFreq_independent",0] call tin_fnc_publicVariable;
["tin_var_artyFreq_civilian",0] call tin_fnc_publicVariable;

["tin_var_artyBatteries", [	//[[name,ready,[ammoClass,quantity],guns,dispersion,reloadTime,calcTime,flightTime,delayTime,side] - delayTime and calcTime can be an array [min,max]

	["STEEL RAIN 1",true,[
	["rhs_mag_155mm_m795_28",40],
	["rhs_mag_155mm_m825a1_2",20]
	],3,100,15,20,35,[0.1,1.0],west],

	["STEEL RAIN 2",true,[
	["rhs_mag_155mm_m795_28",40],
	["rhs_mag_155mm_m825a1_2",20]
	],3,100,15,20,35,[0.1,1.0],west],

	["STEEL RAIN 3",true,[
	["rhs_mag_155mm_m795_28",40],
	["rhs_mag_155mm_m825a1_2",20]
	],3,100,15,20,35,[0.1,1.0],west]

]] call tin_fnc_publicVariable;

["tin_var_fireMissions_west",[	

]] call tin_fnc_publicVariable;

["tin_var_fireMissions_east",[

]] call tin_fnc_publicVariable;

["tin_var_fireMissions_independent",[

]] call tin_fnc_publicVariable;

["tin_var_fireMissions_civilian",[

]] call tin_fnc_publicVariable;