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
	["rhsgref_uniform_ttsko_forest"] call FW_fnc_AddItem;
END_GROUP;
	
SET_GROUP(IFAK)
	["ACE_fieldDressing", 3, "uniform"] call FW_fnc_AddItem;
	["ACE_elasticBandage", 3, "uniform"] call FW_fnc_AddItem;
	["ACE_packingBandage", 3, "uniform"] call FW_fnc_AddItem;
	["ACE_quikclot", 3, "uniform"] call FW_fnc_AddItem;
	["ACE_morphine", 1, "uniform"] call FW_fnc_AddItem;
	["ACE_epinephrine", 1, "uniform"] call FW_fnc_AddItem;
	["ACE_tourniquet", 1, "uniform"] call FW_fnc_AddItem;
END_GROUP;
	
SET_GROUP(items)
	["ItemMap"] call FW_fnc_AddItem;
	["ItemCompass"] call FW_fnc_AddItem;
	["ItemWatch"] call FW_fnc_AddItem;
	["ACE_MapTools"] call FW_fnc_AddItem;
	["ACE_earplugs"] call FW_fnc_AddItem;
END_GROUP;
	
case (package + "RF"): { //Rifleman
	
	["rhs_6b5_ttsko"] call FW_fnc_AddItem;  //Vest
	
	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines
	
	["rhs_weap_aks74"] call FW_fnc_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
};

case (package + "RFLAT"): { //AT Rifleman
	
	["rhs_6b5_ttsko"] call FW_fnc_AddItem;  //Vest
	
	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines
	
	["rhs_weap_aks74"] call FW_fnc_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
	["rhs_weap_rpg26"] call FW_fnc_AddItem; //Anti tank launcher
	
};

case (package + "AR"): { //Automatic Rifleman
	
	["rhs_6b5_ttsko"] call FW_fnc_AddItem;	//Vest
	["rhs_sidor"] call FW_fnc_AddItem; //Backpack
	
	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_45Rnd_545X39_7N10_AK",5,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_45Rnd_545X39_7N10_AK",5,"backpack"] call FW_fnc_AddItem; //Magazines
	["rhs_45Rnd_545X39_AK_Green",2,"backpack"] call FW_fnc_AddItem; //Tracer Magazines
	
	["hlc_rifle_rpk"] call FW_fnc_AddItem;//Primary Rifle

};
	
case (package + "RFAT"): { //AT Rifleman
	
	["rhs_6b5_ttsko"] call FW_fnc_AddItem;  //Vest
	["rhs_rpg_empty"] call FW_fnc_AddItem;	//backpack
	
	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines
	["rhs_rpg7_PG7VL_mag",3,"backpack"] call FW_fnc_AddItem; //HEAT Rockets
	
	["rhs_weap_aks74"] call FW_fnc_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
	["rhs_weap_rpg7"] call FW_fnc_AddItem; //Rocket Launcher
	_unit addSecondaryWeaponItem "rhs_acc_pgo7v2";
	
};

case (package + "RFASST"): { //Assitant RPG Gunner
	
	["rhs_6b5_ttsko"] call FW_fnc_AddItem;  //Vest
	["rhs_rpg_empty"] call FW_fnc_AddItem;	//backpack
	
	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines
	["rhs_rpg7_PG7VL_mag",3,"backpack"] call FW_fnc_AddItem; //HEAT Rockets
	
	["rhs_weap_aks74"] call FW_fnc_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
};

case (package + "TL"): { //Team Leader/Efreitor

	["rhs_6b5_ttsko"] call FW_fnc_AddItem;  //Vest
	["rhs_sidor"] call FW_fnc_AddItem; //Backpack

	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines
	
	["rhs_VOG25",4,"backpack"] call FW_fnc_AddItem; //GP-25 HE and Smoke Grenades
	["rhs_GRD40_White",2,"backpack"] call FW_fnc_AddItem;
	["rhs_GRD40_Green",2,"backpack"] call FW_fnc_AddItem;
	["rhs_GRD40_Red",2,"backpack"] call FW_fnc_AddItem;

	["rhs_weap_aks74_gp25"] call FW_fnc_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider

};

case (package + "SL"): { //Squad Leader

	["rhs_6b5_ttsko"] call FW_fnc_AddItem; //Vest
	["usm_pack_st138_prc77"] call FW_fnc_AddItem; //Backpack Radio

	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["Binocular"] call FW_fnc_AddItem;

	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines

	["rhs_weap_aks74n"] call FW_fnc_AddItem;
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; //4X Optic

};

case (package + "PL"): { //Platoon Leader

	["rhs_6b5_officer_ttsko"] call FW_fnc_AddItem; //Vest
	["usm_pack_st138_prc77"] call FW_fnc_AddItem; //Backpack Radio

	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["Binocular"] call FW_fnc_AddItem;

	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines

	["rhs_weap_aks74n"] call FW_fnc_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; //4X Optic

};

case (package + "MRKSMN"): { //Marksman
	
	["rhs_6b5_sniper_ttsko"] call FW_fnc_AddItem;  //Vest
	
	["rhsgref_ssh68_ttsko_forest"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhsgref_10Rnd_792x57_m76",10,"vest"] call FW_fnc_AddItem; call FW_fnc_AddItem; //Magazines
	
	["rhs_weap_m76"] call FW_fnc_AddItem; //Marksman Rifle
	_unit addPrimaryWeaponItem "rhs_acc_pso1m2"; //Scope
	
};

case (package + "GNR"): { //Vehicle Gunner
	
	["rhs_6b5_ttsko"] call FW_fnc_AddItem;  //Vest
	["usm_pack_st138_prc77"] call FW_fnc_AddItem; //Backpack Radio
	
	["rhs_tsh4"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["Binocular"] call FW_fnc_AddItem;
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FW_fnc_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FW_fnc_AddItem; //Tracer Magazines
	
	["rhs_weap_aks74u"] call FW_fnc_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u"; //Flash Hider
	
};

case (package + "DRVR"): { //Vehicle Driver
	
	["rhs_6b5_ttsko"] call FW_fnc_AddItem;  //Vest
	["rhs_sidor"] call FW_fnc_AddItem; //Backpack
	
	["rhs_tsh4"] call FW_fnc_AddItem; //Helmet
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FW_fnc_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FW_fnc_AddItem; //Frag grenade
	
	["rhs_mag_9x18_8_57N181S",4,"vest"] call FW_fnc_AddItem; //Pistol Magazines
	["ToolKit",1,"backpack"] call FW_fnc_AddItem; //Toolkit to Repair Tracks
	
	["rhs_weap_makarov_pm"] call FW_fnc_AddItem; //Pistol
	
};