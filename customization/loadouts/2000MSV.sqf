//AUTHOR: Gkenny
//Early 2000s MSV
//
//[this, "2000MSV_RF"] call FUNC(GearScript);
//[this, "2000MSV_MG"] call FUNC(GearScript);
//[this, "2000MSV_MGASST"] call FUNC(GearScript);
//[this, "2000MSV_RPK"] call FUNC(GearScript);
//[this, "2000MSV_RPG"] call FUNC(GearScript);
//[this, "2000MSV_RPGASST"] call FUNC(GearScript);
//[this, "2000MSV_EFR"] call FUNC(GearScript);
//[this, "2000MSV_SL"] call FUNC(GearScript);
//[this, "2000MSV_PL"] call FUNC(GearScript);
//[this, "2000MSV_COY"] call FUNC(GearScript);
//[this, "2000MSV_RTO"] call FUNC(GearScript);
//[this, "2000MSV_COYSGT"] call FUNC(GearScript);
//[this, "2000MSV_PLTSGT"] call FUNC(GearScript);
//[this, "2000MSV_MKS"] call FUNC(GearScript);
//[this, "2000MSV_GNR"] call FUNC(GearScript);
//[this, "2000MSV_DRVR"] call FUNC(GearScript);
//[this, "2000MSV_CMDR"] call FUNC(GearScript);
//[this, "2000MSV_MED"] call FUNC(GearScript);

#define package "2000MSV_"

SET_GROUP(uniform)
	["rhs_uniform_flora"] call FUNC(AddItem);
END_GROUP;
	
SET_GROUP(IFAK)
	["ACE_fieldDressing", 3, "uniform"] call FUNC(AddItem);
	["ACE_elasticBandage", 3, "uniform"] call FUNC(AddItem);
	["ACE_packingBandage", 3, "uniform"] call FUNC(AddItem);
	["ACE_quikclot", 3, "uniform"] call FUNC(AddItem);
	["ACE_morphine", 1, "uniform"] call FUNC(AddItem);
	["ACE_tourniquet", 1, "uniform"] call FUNC(AddItem);
END_GROUP;
	
SET_GROUP(items)
	["ItemMap"] call FUNC(AddItem);
	["ItemCompass"] call FUNC(AddItem);
	["ItemWatch"] call FUNC(AddItem);
	["ACE_earplugs"] call FUNC(AddItem);
END_GROUP;
	
SET_GROUP(helmet)
	["rhs_6b26","rhs_6b26_bala","rhs_6b26_ess","rhs_6b26_ess_bala"] call FUNC(AddItemRandom);
	//["rhs_6b26"] call FUNC(AddItem);
END_GROUP;
	
case (package + "RF"): { //Rifleman
	
	["rhs_6b23_rifleman"] call FUNC(AddItem);  //Vest
	ADD_GROUP(uniform);
	ADD_GROUP(helmet);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",7,"vest"] call FUNC(AddItem); //Magazines
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK	
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; //Flash hider
	
};
	


case (package + "RPG") : { //RPG Grenadier

	["rhs_6b23_rifleman"] call FUNC(AddItem);  //Vest
	["rhs_rpg_empty"] call FUNC(AddItem); // RPG Carrier
	
	ADD_GROUP(uniform);
	ADD_GROUP(helmet);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",7,"vest"] call FUNC(AddItem); //Magazines
	
	["rhs_rpg7_PG7VL_mag",2,"backpack"] call FUNC(AddItem); // RPGs
	["rhs_rpg7_OG7V_mag",1,"backpack"] call FUNC(AddItem);
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK	
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; //Flash hider
	
	["rhs_weap_rpg7"] call FUNC(AddItem); // RPG-7
	_unit addSecondaryWeaponItem "rhs_acc_pgo7v3"; //RPG Scope
	
};

case (package + "RPGASST") : { // RPG Assistant

	["rhs_6b23_rifleman"] call FUNC(AddItem);  //Vest
	["rhs_rpg_empty"] call FUNC(AddItem); // RPG Carrier
	
	ADD_GROUP(uniform);
	ADD_GROUP(helmet);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",7,"vest"] call FUNC(AddItem); //Magazines
	
	["rhs_rpg7_PG7VL_mag",1,"backpack"] call FUNC(AddItem);
	["rhs_rpg7_PG7VR_mag",1,"backpack"] call FUNC(AddItem);	// RPGs
	["rhs_rpg7_OG7V_mag",1,"backpack"] call FUNC(AddItem);
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK	
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; //Flash hider
	
};

case (package + "EFR") : { //Efreitor
	
	ADD_GROUP(uniform);
	["rhs_6b23_6sh92_vog_headset"] call FUNC(AddItem); //vest
	["rhs_6b26_ess"] call FUNC(AddItem); // helmet
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["ACRE_PRC343",1,"uniform"] call FUNC(AddItem); // SR Radio
	
	["rhs_mag_rgn",1,"vest"] call FUNC(AddItem); // Frag
	["rhs_mag_rdg2_white",1,"vest"] call FUNC(AddItem); // Smoke
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); // Ammo
	
	["rhs_VOG25",7,"vest"] call FUNC(AddItem); // Frag Vogs
	["rhs_GRD40_White",2,"vest"] call FUNC(AddItem); // Smoke Vogs
	["rhs_GRD40_Green",1,"vest"] call FUNC(AddItem);
	["rhs_GRD40_Red",1,"vest"] call FUNC(AddItem);
	
	["rhs_weap_ak74m_gp25"] call FUNC(AddItem); // AK GP
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
};

case (package + "SL") : { //Section Leader
	
	ADD_GROUP(uniform);
	["rhs_6b23_6sh92_headset_mapcase"] call FUNC(AddItem); //vest
	["rhs_6b26"] call FUNC(AddItem); // helmet
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["Binocular"] call FUNC(AddItem); // Binoculars
	
	["ACRE_PRC343",1,"uniform"] call FUNC(AddItem); // SR Radio
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	
	["rhs_mag_rgn",2,"vest"] call FUNC(AddItem); // Frag
	["rhs_mag_rdg2_white",2,"vest"] call FUNC(AddItem); // Smoke
	
	["rhs_30Rnd_545x39_7N10_AK",7,"vest"] call FUNC(AddItem); // Ammo
	
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK 
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
	
};
	
case (package + "PL") : { // PLT Commander
	
	ADD_GROUP(uniform);
	["rhs_6b23_crewofficer"] call FUNC(AddItem); // vest
	["rhs_assault_umbts"] call FUNC(AddItem); // Radio Backpack
	["rhs_6b26_ess","rhs_6b26"] call FUNC(AddItemRandom); // helmet
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["Binocular"] call FUNC(AddItem); // Binoculars
	
	["ACRE_PRC343",1,"uniform"] call FUNC(AddItem); // SR Radio
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	["ACRE_PRC117F",1,"backpack"] call FUNC(AddItem); // COY Radio
	
	["rhs_mag_rgn",1,"vest"] call FUNC(AddItem); // Frag
	["rhs_mag_rdg2_white",1,"vest"] call FUNC(AddItem); // Smoke
	
	["rhs_30Rnd_545x39_7N10_AK",4,"vest"] call FUNC(AddItem); // Ammo
	["rhs_mag_9x18_8_57N181S",1,"uniform"] call FUNC(AddItem);	
	["rhs_mag_9x18_8_57N181S",1,"vest"] call FUNC(AddItem);	
	
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK 
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; // Scope
	
	["rhs_weap_makarov_pm"] call FUNC(AddItem); // Makarov PM
};

case (package + "COY") : { // Company Commander
	
	ADD_GROUP(uniform);
	["rhs_6b23_crewofficer"] call FUNC(AddItem); // vest
	["rhs_6b26_ess","rhs_6b26"] call FUNC(AddItemRandom); // helmet
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["Binocular"] call FUNC(AddItem); // Binoculars
	
	["ACRE_PRC343",1,"uniform"] call FUNC(AddItem); // SR Radio
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	
	["rhs_mag_rdg2_white",1,"vest"] call FUNC(AddItem); // Smoke
	
	["rhs_30Rnd_545x39_7N10_AK",4,"vest"] call FUNC(AddItem); // Ammo
	["rhs_mag_9x18_8_57N181S",2,"vest"] call FUNC(AddItem);	
	
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK 
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; // Scope
	
	["rhs_weap_makarov_pm"] call FUNC(AddItem); // Makarov PM
};
case (package + "COYSGT") : { // Company Sergeant
	
	ADD_GROUP(uniform);
	["rhs_6b23_6sh92_vog_headset"] call FUNC(AddItem); //vest
	["rhs_6b26_ess","rhs_6b26"] call FUNC(AddItemRandom); // helmet
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["Binocular"] call FUNC(AddItem); // Binoculars
	
	["ACRE_PRC343",1,"uniform"] call FUNC(AddItem); // SR Radio
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	
	["rhs_mag_rgn",1,"vest"] call FUNC(AddItem); // Frag
	["rhs_mag_rdg2_white",1,"vest"] call FUNC(AddItem); // Smoke
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); // Ammo
	
	["rhs_VOG25",6,"vest"] call FUNC(AddItem); // Frag Vogs
	["rhs_GRD40_White",2,"vest"] call FUNC(AddItem); // Smoke Vogs
	["rhs_GRD40_Green",1,"vest"] call FUNC(AddItem);
	["rhs_GRD40_Red",1,"vest"] call FUNC(AddItem);
	
	["rhs_weap_ak74m_gp25"] call FUNC(AddItem); // AK GP
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; // Scope
};
case (package + "PLTSGT") : { // PLT Sergeant

	ADD_GROUP(uniform);
	["rhs_6b23_6sh92_vog_headset"] call FUNC(AddItem); //vest
	["rhs_6b26_ess","rhs_6b26"] call FUNC(AddItemRandom); // helmet
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["Binocular"] call FUNC(AddItem); // Binoculars
	
	["ACRE_PRC343",1,"uniform"] call FUNC(AddItem); // SR Radio
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	
	["rhs_mag_rgn",1,"vest"] call FUNC(AddItem); // Frag
	["rhs_mag_rdg2_white",1,"vest"] call FUNC(AddItem); // Smoke
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); // Ammo
	
	["rhs_VOG25",6,"vest"] call FUNC(AddItem); // Frag Vogs
	["rhs_GRD40_White",2,"vest"] call FUNC(AddItem); // Smoke Vogs
	["rhs_GRD40_Green",1,"vest"] call FUNC(AddItem);
	["rhs_GRD40_Red",1,"vest"] call FUNC(AddItem);
	
	["rhs_weap_ak74m_gp25"] call FUNC(AddItem); // AK GP
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
};
case (package + "RTO"): { // RTO
	
	["rhs_6b23_rifleman"] call FUNC(AddItem);  //Vest
	
	
	
	ADD_GROUP(uniform);
	ADD_GROUP(helmet);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["rhs_assault_umbts"] call FUNC(AddItem); // Radio Backpack
	
	["ACRE_PRC117F",1,"backpack"] call FUNC(AddItem); // COY Radio
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); //Magazines
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK	
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; //Flash hider
	
};

case (package + "MKS") : { // Marksman	
	
	ADD_GROUP(uniform);
	["rhs_6b23_sniper"] call FUNC(AddItem);
	ADD_GROUP(helmet);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_mag_9x18_8_57N181S",3,"vest"] call FUNC(AddItem); // PM ammo	
	["rhs_10Rnd_762x54mmR_7N1",9,"vest"] call FUNC(AddItem); // SVD ammo
	
	["rhs_weap_svdp"] call FUNC(AddItem); // SVD
	_unit addPrimaryWeaponItem "rhs_acc_pso1m2"; //Scope

	["rhs_weap_makarov_pm"] call FUNC(AddItem); // Makarov PM
};

case (package + "MG") : { //Machinegunner
	
	ADD_GROUP(uniform);
	["rhs_6b23_rifleman"] call FUNC(AddItem);  //Vest
	["rhs_sidor"] call FUNC(AddItem); // Backpack
	ADD_GROUP(helmet);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_100Rnd_762x54mmR",1,"vest"] call FUNC(AddItem); // PKM Ammo
	["rhs_100Rnd_762x54mmR",2,"backpack"] call FUNC(AddItem);
	
	["ruPal_rhs_weap_pkm"] call FUNC(AddItem); // PKM
};
case (package + "MGASST") : { // MG Assistant
	
	["rhs_6b23_rifleman"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(helmet);
	["rhs_sidor"] call FUNC(AddItem); // Backpack
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["Binocular"] call FUNC(AddItem); // Binoculars
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",7,"vest"] call FUNC(AddItem); //Magazines
	["rhs_100Rnd_762x54mmR",2,"backpack"] call FUNC(AddItem); // PKM Ammo
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK	
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; //Flash hider
	
};

case (package + "DRVR") : { // Driver
	
	ADD_GROUP(uniform);
	["rhs_6b23_engineer"] call FUNC(AddItem); // Vest
	["rhs_tsh4_ess","rhs_tsh4_ess_bala"] call FUNC(AddItemRandom); //Helmets 
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); // Ammo
	
	["rhs_weap_aks74u"] call FUNC(AddItem); // AK
	_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u"; // Flash Hider
	
};

case (package + "GNR") : { // Gunner
	
	ADD_GROUP(uniform);
	["rhs_6b23_engineer"] call FUNC(AddItem); // Vest
	["rhs_tsh4","rhs_tsh4_bala"] call FUNC(AddItemRandom); //Helmets 
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); // Ammo
	
	["rhs_weap_aks74u"] call FUNC(AddItem); // AK
	_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u"; // Flash Hider
	
};

case (package + "MED") : { // Medic
	
	ADD_GROUP(uniform);
	["rhs_6b23_medic"] call FUNC(AddItem); // vest
	["rhs_medic_bag"] call FUNC(AddItem); // medic bag
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	ADD_GROUP(helmet);
	
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	
	["ACE_fieldDressing",10,"vest"] call FUNC(AddItem); // MED Supplies
	["ACE_elasticBandage",10,"vest"] call FUNC(AddItem);
	["ACE_quikclot",10,"vest"] call FUNC(AddItem);
	["ACE_epinephrine",10,"vest"] call FUNC(AddItem);
	["ACE_morphine",5,"vest"] call FUNC(AddItem);
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); // Ammo
	["rhs_mag_rgn",1,"vest"] call FUNC(AddItem); // Frag Grenadier
	["rhs_mag_rdg2_white",2,"vest"] call FUNC(AddItem); // White Smoke
	
	["ACE_morphine",15,"backpack"] call FUNC(AddItem); // Med Supplies
	["ACE_packingBandage",20,"backpack"] call FUNC(AddItem);
	["ACE_fieldDressing",10,"backpack"] call FUNC(AddItem);
	["ACE_elasticBandage",10,"backpack"] call FUNC(AddItem);
	["ACE_quikclot",10,"backpack"] call FUNC(AddItem);
	["ACE_salineIV_500",3,"backpack"] call FUNC(AddItem);
	["ACE_salineIV",1,"backpack"] call FUNC(AddItem);
	["ACE_salineIV_250",2,"backpack"] call FUNC(AddItem);
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
	
};

case (package + "RPK") : { //RPK

	ADD_GROUP(uniform);
	["rhs_6b23_rifleman"] call FUNC(AddItem);  //Vest
	["rhs_sidor"] call FUNC(AddItem); // Backpack
	ADD_GROUP(helmet);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_45Rnd_545X39_7N10_AK",4,"vest"] call FUNC(AddItem); // RPK Ammo
	["rhs_45Rnd_545X39_7N10_AK",5,"backpack"] call FUNC(AddItem);
	["rhs_45Rnd_545X39_AK_Green",1,"backpack"] call FUNC(AddItem);
	
	["hlc_rifle_rpk"] call FUNC(AddItem); // RPK
};

case (package + "CMDR") : { // Gunner
	
	ADD_GROUP(uniform);
	["rhs_6b23_engineer"] call FUNC(AddItem); // Vest
	["rhs_tsh4","rhs_tsh4_bala"] call FUNC(AddItemRandom); //Helmets 
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	["Binocular"] call FUNC(AddItem); // Binoculars
	
	["ACRE_PRC148",1,"uniform"] call FUNC(AddItem); // PLT Radio
	
	
	["rhs_mag_rdg2_white", 1] call FUNC(AddItem); //White smoke
	["rhs_mag_rgn", 1] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FUNC(AddItem); // Ammo
	
	["rhs_weap_ak74m"] call FUNC(AddItem); // AK
	_unit addPrimaryWeaponItem "rhs_acc_dtk"; // Flash Hider
	
};