//AUTHOR: Jubxxxjub
//
//[this, "USMCRiflePlatoon_SL"] call FW_fnc_GearScript;
//[this, "USMCRiflePlatoon_TL"] call FW_fnc_GearScript;
//[this, "USMCRiflePlatoon_AR"] call FW_fnc_GearScript;
//[this, "USMCRiflePlatoon_MD"] call FW_fnc_GearScript;
//[this, "USMCRiflePlatoon_RF"] call FW_fnc_GearScript;
//[this, "USMCRiflePlatoon_RFAT"] call FW_fnc_GearScript;

#define package "USMCRiflePlatoon_"

SET_GROUP(uniform)
	["rhs_uniform_FROG01_d"] call FUNC(AddItem);
	["CUP_B_USMC_MOLLE"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(uniformNR)
	["rhs_uniform_FROG01_d"] call FUNC(AddItem);
END_GROUP;

//rhsusf_lwh_helmet_marpatd_headset
//rhsusf_assault_eagleaiii_coy
//

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
	["ACE_splint", 1, "uniform"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(items)
	["ItemMap"] call FUNC(AddItem);
	["vn_b_item_compass"] call FUNC(AddItem);
	["ACE_Altimeter"] call FUNC(AddItem);
	["ACE_MapTools"] call FUNC(AddItem);
	["ACE_earplugs"] call FUNC(AddItem);
	["scrim_net_glasses_olive","rhsusf_oakley_goggles_clr","rhs_googles_black", "G_Lowprofile"] call FUNC(AddItemRandom);
	["rhsusf_acc_grip1","rhsusf_oakley_goggles_clr","rhs_googles_black", "G_Lowprofile"] call FUNC(AddItemRandom);
END_GROUP;

case (package + "SL"): {

	["rhsusf_spc_squadleader"] call FUNC(AddItem); //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACE_Vector"] call FUNC(AddItem);

	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);

};

case (package + "RTO"): {

	["rhsusf_spc_squadleader"] call FUNC(AddItem); //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACRE_PRC117F", 1] call FUNC(AddItem); //Long range radio
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_weap_m16a4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);

};

case (package + "TL"): {

	["rhsusf_spc_teamleader"] call FUNC(AddItem);  //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	["rhsusf_bino_m24_ARD", 1] call FUNC(AddItem); //SR
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 8] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 1] call FUNC(AddItem); //Frag grenade

	["rhs_mag_M433_HEDP", 15] call FUNC(AddItem); //Frag Grenade  (m203)
	["1Rnd_SmokeRed_Grenade_shell", 6] call FUNC(AddItem); //Red Smoke  (m203)

	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke

	["rhs_weap_m4_m203"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);

};

case (package + "AR"): {

	["rhsusf_spc_mg"] call FUNC(AddItem);  //Vest
	["rhsusf_lwh_helmet_marpatwd","rhsusf_lwh_helmet_marpatwd_ess","rhsusf_mich_helmet_marpatd"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_200rnd_556x45_M_SAW", 3] call FUNC(AddItem); //Magazines

	["rhs_weap_m249_pip_ris"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog_rmr"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_kac_grip_saw_bipod","rhsusf_acc_grip4_bipod","rhsusf_acc_saw_lw_bipod","rhsusf_acc_saw_bipod", "rhsusf_acc_kac_grip_saw_bipod"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);

};

case (package + "ARA"): {

	["rhsusf_spc_rifleman"] call FUNC(AddItem);  //Vest
	["rhsusf_lwh_helmet_marpatwd","rhsusf_lwh_helmet_marpatwd_ess","rhsusf_mich_helmet_marpatd"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_200rnd_556x45_M_SAW", 3] call FUNC(AddItem); //Magazines

	["rhs_weap_m16a4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);
	["ACE_SpareBarrel", 1] call FUNC(AddItem);  // Spare Barrel

};

case (package + "RFAT"): {

	["rhsusf_spc_rifleman"] call FUNC(AddItem);  //Vest
	["rhsusf_lwh_helmet_marpatwd","rhsusf_lwh_helmet_marpatwd_ess","rhsusf_mich_helmet_marpatd"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines

	["rhs_weap_m16a4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);

	["rhs_weap_M136_hedp"] call FUNC(AddItem); //Anti tank launcher

};


case (package + "MD"): {

	["rhsusf_spc_corpsman"] call FUNC(AddItem);  //Vest
	["rhsusf_lwh_helmet_marpatwd","rhsusf_lwh_helmet_marpatwd_ess","rhsusf_mich_helmet_marpatd"] call FUNC(AddItemRandom);
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_an_m8hc", 4] call FUNC(AddItem); //White smoke

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines

	["rhs_weap_m16a4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);

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
	["ACE_splint", 1] call FUNC(AddItem);
	["ACE_personalAidKit", 3] call FUNC(AddItem);

};

case (package + "SMAW"): {

	["rhsusf_spc_squadleader"] call FUNC(AddItem); //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 5] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_weap_smaw_green", 1] call FUNC(AddItem); //White smoke
	["rhs_weap_optic_smaw", 1] call FUNC(AddItem); //Purple Smoke

	["CUP_SMAW_HEDP_M", 1] call FUNC(AddItem); //Red Smoke
	["CUP_SMAW_HEAA_M", 1] call FUNC(AddItem); //Frag grenade
	["CUP_SMAW_NE_M", 1] call FUNC(AddItem); //Frag grenade
	["rhs_mag_smaw_SR", 3] call FUNC(AddItem);

	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);

};

case (package + "SMAWA"): {

	["rhsusf_spc_rifleman"] call FUNC(AddItem); //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACE_Yardage450"] call FUNC(AddItem);

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["CUP_SMAW_HEDP_M", 1] call FUNC(AddItem); //Red Smoke
	["CUP_SMAW_HEAA_M", 1] call FUNC(AddItem); //Frag grenade
	["CUP_SMAW_NE_M", 1] call FUNC(AddItem); //Frag grenade
	["rhs_mag_smaw_SR", 3] call FUNC(AddItem);

	["rhs_weap_m16a4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);
};

case (package + "TLMG"): {

	["rhsusf_spc_teamleader"] call FUNC(AddItem); //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACE_Yardage450"] call FUNC(AddItem);

	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 8] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines
	["rhsusf_100Rnd_762x51_m62_tracer", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_M433_HEDP", 8] call FUNC(AddItem); //Frag Grenade  (m203)
	["1Rnd_SmokeRed_Grenade_shell", 6] call FUNC(AddItem); //Red Smoke  (m203)

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_weap_m16a4_carryhandle_M203"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight

};

case (package + "MG"): {

	["rhsusf_spc_mg"] call FUNC(AddItem); //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	["rhsusf_100Rnd_762x51_m80a1epr", 3] call FUNC(AddItem); //Magazines
	["rhsusf_100Rnd_762x51_m62_tracer", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_weap_m240G"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog_mdo"] call FUNC(AddItem); //Red dot sight

};

case (package + "MGA"): {

	["rhsusf_spc_rifleman"] call FUNC(AddItem); //Vest
	["rhsusf_lwh_helmet_marpatwd_headset","rhsusf_mich_helmet_marpatd_alt_headset"] call FUNC(AddItemRandom);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhsusf_100Rnd_762x51_m80a1epr", 3] call FUNC(AddItem); //Magazines
	["rhsusf_100Rnd_762x51_m62_tracer", 2] call FUNC(AddItem); //Tracer magazines
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_weap_m16a4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight
	["rhsusf_acc_grip1","rhsusf_acc_kac_grip","rhsusf_acc_grip3"] call FUNC(AddItemRandom);
	["rhsusf_acc_anpeq16a","rhsusf_acc_anpeq15side"] call FUNC(AddItemRandom);
	["ACE_SpareBarrel", 1] call FUNC(AddItem);  // Spare Barrel

};

case (package + "VC"): {

	["rhsusf_spc_crewman"] call FUNC(AddItem); //Vest
	["rhsusf_cvc_green_helmet"] call FUNC(AddItem);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["rhsusf_bino_m24_ARD"] call FUNC(AddItem);

	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 5] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke
	["rhs_mag_m67", 2] call FUNC(AddItem); //Frag grenade

	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight

};

case (package + "CREW"): {

	["rhsusf_spc_crewman"] call FUNC(AddItem); //Vest
	["rhsusf_cvc_green_helmet"] call FUNC(AddItem);

	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	["ACRE_PRC343", 1] call FUNC(AddItem); //SR

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 5] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight

};

case (package + "PILOT"): {

	["H_PilotHelmetHeli_B"] call FUNC(AddItem); //Vest
	["UK3CB_V_Pilot_Vest_MTP","UK3CB_V_Pilot_Vest_Black"] call FUNC(AddItemRandom);

	ADD_GROUP(uniformNR);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);

	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio

	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 2] call FUNC(AddItem); //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FUNC(AddItem); //Tracer magazines

	["rhs_mag_an_m8hc", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_m18_purple", 2] call FUNC(AddItem); //Purple Smoke
	["rhs_mag_m18_red", 2] call FUNC(AddItem); //Red Smoke

	["rhs_weap_m4_carryhandle"] call FUNC(AddItem); //Primary rifle
	["rhsusf_acc_acog"] call FUNC(AddItem); //Red dot sight

};
