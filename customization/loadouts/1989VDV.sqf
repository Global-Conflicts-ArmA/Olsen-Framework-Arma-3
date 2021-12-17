//AUTHOR: SgtDeadly12
//
//[this, "1989VDV_RF"] call FW_fnc_GearScript;
//[this, "1989VDV_RFLAT"] call FW_fnc_GearScript;
//[this, "1989VDV_AR"] call FW_fnc_GearScript;
//[this, "1989VDV_RFAT"] call FW_fnc_GearScript;
//[this, "1989VDV_RFASST"] call FW_fnc_GearScript;
//[this, "1989VDV_TL"] call FW_fnc_GearScript;
//[this, "1989VDV_SL"] call FW_fnc_GearScript;
//[this, "1989VDV_PL"] call FW_fnc_GearScript;
//[this, "1989VDV_MRKSMN"] call FW_fnc_GearScript;
//[this, "1989VDV_GNR"] call FW_fnc_GearScript;
//[this, "1989VDV_DRVR"] call FW_fnc_GearScript;

#define package "1989VDV_"

SET_GROUP(uniform)
	["rhsgref_uniform_ttsko_forest"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(IFAK)
	["ACE_fieldDressing", 3, "uniform"] call FUNC(AddItem);
	["ACE_elasticBandage", 3, "uniform"] call FUNC(AddItem);
	["ACE_packingBandage", 3, "uniform"] call FUNC(AddItem);
	["ACE_quikclot", 3, "uniform"] call FUNC(AddItem);
	["ACE_morphine", 1, "uniform"] call FUNC(AddItem);
	["ACE_epinephrine", 1, "uniform"] call FUNC(AddItem);
	["ACE_tourniquet", 1, "uniform"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(items)
	["ItemMap"] call FUNC(AddItem);
	["ItemCompass"] call FUNC(AddItem);
	["ItemWatch"] call FUNC(AddItem);
	["ACE_MapTools"] call FUNC(AddItem);
	["ACE_earplugs"] call FUNC(AddItem);
END_GROUP;

case (package + "RF"): { //Rifleman

	["rhs_6b5_ttsko"] call FUNC(AddItem);  //Vest

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines

	["rhs_weap_aks74"] call FUNC(AddItem); //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider

};

case (package + "RFLAT"): { //AT Rifleman

	["rhs_6b5_ttsko"] call FUNC(AddItem);  //Vest

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines

	["rhs_weap_aks74"] call FUNC(AddItem); //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider

	["rhs_weap_rpg26"] call FUNC(AddItem); //Anti tank launcher

};

case (package + "AR"): { //Automatic Rifleman

	["rhs_6b5_ttsko"] call FUNC(AddItem);	//Vest
	["rhs_sidor"] call FUNC(AddItem); //Backpack

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_45Rnd_545X39_7N10_AK",5,"vest"] call FUNC(AddItem); //Magazines
	["rhs_45Rnd_545X39_7N10_AK",5,"backpack"] call FUNC(AddItem); //Magazines
	["rhs_45Rnd_545X39_AK_Green",2,"backpack"] call FUNC(AddItem); //Tracer Magazines

	["hlc_rifle_rpk"] call FUNC(AddItem);//Primary Rifle

};

case (package + "RFAT"): { //AT Rifleman

	["rhs_6b5_ttsko"] call FUNC(AddItem);  //Vest
	["rhs_rpg_empty"] call FUNC(AddItem);	//backpack

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines
	["rhs_rpg7_PG7VL_mag",3,"backpack"] call FUNC(AddItem); //HEAT Rockets

	["rhs_weap_aks74"] call FUNC(AddItem); //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider

	["rhs_weap_rpg7"] call FUNC(AddItem); //Rocket Launcher
	_unit addSecondaryWeaponItem "rhs_acc_pgo7v2";

};

case (package + "RFASST"): { //Assitant RPG Gunner

	["rhs_6b5_ttsko"] call FUNC(AddItem);  //Vest
	["rhs_rpg_empty"] call FUNC(AddItem);	//backpack

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines
	["rhs_rpg7_PG7VL_mag",3,"backpack"] call FUNC(AddItem); //HEAT Rockets

	["rhs_weap_aks74"] call FUNC(AddItem); //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider

};

case (package + "TL"): { //Team Leader/Efreitor

	["rhs_6b5_ttsko"] call FUNC(AddItem);  //Vest
	["rhs_sidor"] call FUNC(AddItem); //Backpack

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines

	["rhs_VOG25",4,"backpack"] call FUNC(AddItem); //GP-25 HE and Smoke Grenades
	["rhs_GRD40_White",2,"backpack"] call FUNC(AddItem);
	["rhs_GRD40_Green",2,"backpack"] call FUNC(AddItem);
	["rhs_GRD40_Red",2,"backpack"] call FUNC(AddItem);

	["rhs_weap_aks74_gp25"] call FUNC(AddItem); //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider

};

case (package + "SL"): { //Squad Leader

	["rhs_6b5_ttsko"] call FUNC(AddItem); //Vest
	["usm_pack_st138_prc77"] call FUNC(AddItem); //Backpack Radio

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["Binocular"] call FUNC(AddItem);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines

	["rhs_weap_aks74n"] call FUNC(AddItem);
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; //4X Optic

};

case (package + "PL"): { //Platoon Leader

	["rhs_6b5_officer_ttsko"] call FUNC(AddItem); //Vest
	["usm_pack_st138_prc77"] call FUNC(AddItem); //Backpack Radio

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["Binocular"] call FUNC(AddItem);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines

	["rhs_weap_aks74n"] call FUNC(AddItem); //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; //4X Optic

};

case (package + "MRKSMN"): { //Marksman

	["rhs_6b5_sniper_ttsko"] call FUNC(AddItem);  //Vest

	["rhsgref_ssh68_ttsko_forest"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhsgref_10Rnd_792x57_m76",10,"vest"] call FUNC(AddItem); call FUNC(AddItem); //Magazines

	["rhs_weap_m76"] call FUNC(AddItem); //Marksman Rifle
	_unit addPrimaryWeaponItem "rhs_acc_pso1m2"; //Scope

};

case (package + "GNR"): { //Vehicle Gunner

	["rhs_6b5_ttsko"] call FUNC(AddItem);  //Vest
	["usm_pack_st138_prc77"] call FUNC(AddItem); //Backpack Radio

	["rhs_tsh4"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["Binocular"] call FUNC(AddItem);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FUNC(AddItem); //Tracer Magazines

	["rhs_weap_aks74u"] call FUNC(AddItem); //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u"; //Flash Hider

};

case (package + "DRVR"): { //Vehicle Driver

	["rhs_6b5_ttsko"] call FUNC(AddItem);  //Vest
	["rhs_sidor"] call FUNC(AddItem); //Backpack

	["rhs_tsh4"] call FUNC(AddItem); //Helmet

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 1] call FUNC(AddItem); //Frag grenade

	["rhs_mag_9x18_8_57N181S",4,"vest"] call FUNC(AddItem); //Pistol Magazines
	["ToolKit",1,"backpack"] call FUNC(AddItem); //Toolkit to Repair Tracks

	["rhs_weap_makarov_pm"] call FUNC(AddItem); //Pistol

};
