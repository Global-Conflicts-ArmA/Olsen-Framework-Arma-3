//AUTHOR: Olsen
//
//[this, "USMCRiflePlatoon_SL"] call FUNC(GearScript);
//[this, "USMCRiflePlatoon_TL"] call FUNC(GearScript);
//[this, "USMCRiflePlatoon_AR"] call FUNC(GearScript);
//[this, "USMCRiflePlatoon_MD"] call FUNC(GearScript);
//[this, "USMCRiflePlatoon_RF"] call FUNC(GearScript);
//[this, "USMCRiflePlatoon_RFAT"] call FUNC(GearScript);

#define package "USMCRiflePlatoon_"

SET_GROUP(uniform)
	["rhs_uniform_FROG01_d"] call FUNC(AddItem);
	["rhsusf_assault_eagleaiii_coy"] call FUNC(AddItem);
	["rhsusf_lwh_helmet_marpatd", "rhsusf_lwh_helmet_marpatd_ess", "rhsusf_lwh_helmet_marpatd_headset"] call FUNC(AddItemRandom);
END_GROUP;

//["rhs_uniform_FROG01_wd"] call FUNC(AddItem); Woodland Cammo
//["rhsusf_lwh_helmet_marpatwd","rhsusf_lwh_helmet_marpatwd_ess","rhsusf_lwh_helmet_marpatwd_headset"] call FUNC(AddItemRandom); Woodland Cammo
		
SET_GROUP(IFAK)
	["ACE_fieldDressing", 6, "uniform"] call FUNC(AddItem);
	["ACE_elasticBandage", 6, "uniform"] call FUNC(AddItem);
	["ACE_packingBandage", 6, "uniform"] call FUNC(AddItem);
	["ACE_quikclot", 6, "uniform"] call FUNC(AddItem);
	["ACE_morphine", 1, "uniform"] call FUNC(AddItem);
	["ACE_epinephrine", 1, "uniform"] call FUNC(AddItem);
	["ACE_tourniquet", 1, "uniform"] call FUNC(AddItem);
END_GROUP;
	
SET_GROUP(items)
	["ACRE_PRC343", 1] call FUNC(AddItem);
	["ItemMap"] call FUNC(AddItem);
	["ItemCompass"] call FUNC(AddItem);
	["ItemWatch"] call FUNC(AddItem);
	["ACE_MapTools"] call FUNC(AddItem);
	["ACE_earplugs"] call FUNC(AddItem);
END_GROUP;
	
case (package + "SL"): {
	
	["rhsusf_spc_squadleader"] call FUNC(AddItem); //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["ACE_Vector"] call FUNC(AddItem);
	
	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines
	
	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_compm4"] call FUNC(AddItem); //Red dot sight

};

case (package + "TL"): {
	
	["rhsusf_spc_teamleader"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines
	
	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade
	
	
	["1Rnd_HE_Grenade_shell", 12] call FUNC(AddItem); //Frag Grenade  (m203)
	["1Rnd_SmokeRed_Grenade_shell", 6] call FUNC(AddItem); //Red Smoke  (m203)
	
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke
	
	["rhs_weap_m4_m203S"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_compm4"] call FUNC(AddItem); //Red dot sight
	
};

case (package + "AR"): {
	
	["rhsusf_spc_mg"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_200rnd_556x45_M_SAW", 3] call FUNC(AddItem); //Magazines
	
	["rhs_weap_m249_pip_usmc"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_compm4"] call FUNC(AddItem); //Red dot sight
	["ACE_SpareBarrel", 1] call FUNC(AddItem);  // Spare Barrel
	
};

case (package + "RFAT"): {
	
	["rhsusf_spc_rifleman"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	
	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_compm4"] call FUNC(AddItem); //Red dot sight
	
	["rhs_weap_M136_hedp"] call FUNC(AddItem); //Anti tank launcher
	
};

case (package + "RF"): {
	
	["rhsusf_spc_rifleman"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	
	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_compm4"] call FUNC(AddItem); //Red dot sight
	
	["rhs_200rnd_556x45_M_SAW", 1] call FUNC(AddItem); //Spare AR ammo
	
};

case (package + "MD"): {
	
	["rhsusf_spc_corpsman"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 4] call FUNC(AddItem); //White smoke
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	
	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_compm4"] call FUNC(AddItem); //Red dot sight
	
	//Extra Medic Supplies
	["ACE_fieldDressing", 15] call FUNC(AddItem);
	["ACE_elasticBandage", 20] call FUNC(AddItem);
	["ACE_packingBandage", 20] call FUNC(AddItem);
	["ACE_quikclot", 15] call FUNC(AddItem);
	["ACE_atropine", 12] call FUNC(AddItem);
	["ACE_morphine", 8] call FUNC(AddItem);
	["ACE_epinephrine", 8] call FUNC(AddItem);
	["ACE_tourniquet", 5] call FUNC(AddItem);
	["ACE_salineIV_500", 1] call FUNC(AddItem);
	["ACE_surgicalKit", 3] call FUNC(AddItem);
	["ACE_personalAidKit", 3] call FUNC(AddItem);
	
};	