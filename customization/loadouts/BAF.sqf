//AUTHOR: Gibfender
//
//[this, "BAF_PL"] call FUNC(GearScript);
//[this, "BAF_PSG"] call FUNC(GearScript);
//[this, "BAF_RTO"] call FUNC(GearScript);
//[this, "BAF_MED"] call FUNC(GearScript);
//[this, "BAF_MO"] call FUNC(GearScript);
//[this, "BAF_CPL"] call FUNC(GearScript);
//[this, "BAF_LCPL"] call FUNC(GearScript);
//[this, "BAF_GP"] call FUNC(GearScript);
//[this, "BAF_DM"] call FUNC(GearScript);
//[this, "BAF_AR"] call FUNC(GearScript);

#define package "BAF_"

//desert uniform
SET_GROUP(outfit_D)
	["UK3CB_BAF_U_CombatUniform_DDPM","UK3CB_BAF_U_CombatUniform_DDPM_RM","UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve","UK3CB_BAF_U_CombatUniform_DDPM_ShortSleeve_RM"] call FUNC(AddItemRandom);
	["UK3CB_BAF_V_PLCE_Webbing_DDPM","UK3CB_BAF_V_PLCE_Webbing_Plate_DDPM","UK3CB_BAF_V_Osprey_DDPM1","UK3CB_BAF_V_Osprey_DDPM2","UK3CB_BAF_V_Osprey_DDPM3","UK3CB_BAF_V_Osprey_DDPM4","UK3CB_BAF_V_Osprey_DDPM5","UK3CB_BAF_V_Osprey_DDPM6","UK3CB_BAF_V_Osprey_DDPM7","UK3CB_BAF_V_Osprey_DDPM8","UK3CB_BAF_V_Osprey_DDPM9"] call FUNC(AddItemRandom);
	["UK3CB_BAF_H_Mk6_DDPM_A","UK3CB_BAF_H_Mk6_DDPM_B","UK3CB_BAF_H_Mk6_DDPM_C","UK3CB_BAF_H_Mk6_DDPM_D","UK3CB_BAF_H_Mk6_DDPM_E","UK3CB_BAF_H_Mk6_DDPM_F"] call FUNC(AddItemRandom);
END_GROUP;

//woodland uniform
SET_GROUP(outfit_W)
	["UK3CB_BAF_U_CombatUniform_DPMW","UK3CB_BAF_U_CombatUniform_DPMW_RM","UK3CB_BAF_U_CombatUniform_DPMW_ShortSleeve","UK3CB_BAF_U_CombatUniform_DPMW_ShortSleeve_RM","UK3CB_BAF_U_JumperUniform_DPMW"] call FUNC(AddItemRandom);
	["UK3CB_BAF_V_PLCE_Webbing_DPMW","UK3CB_BAF_V_PLCE_Webbing_Plate_DPMW","UK3CB_BAF_V_Osprey_DPMW1","UK3CB_BAF_V_Osprey_DPMW2","UK3CB_BAF_V_Osprey_DPMW3","UK3CB_BAF_V_Osprey_DPMW4","UK3CB_BAF_V_Osprey_DPMW5","UK3CB_BAF_V_Osprey_DPMW6","UK3CB_BAF_V_Osprey_DPMW7","UK3CB_BAF_V_Osprey_DPMW8","UK3CB_BAF_V_Osprey_DPMW9"] call FUNC(AddItemRandom);
	["UK3CB_BAF_H_Mk6_DPMW_B","UK3CB_BAF_H_Mk6_DPMW_C","UK3CB_BAF_H_Mk6_DPMW_D","UK3CB_BAF_H_Mk6_DPMW_E","UK3CB_BAF_H_Mk6_DPMW_F","UK3CB_BAF_H_Mk6_DPMW_Wdl_A"] call FUNC(AddItemRandom);
END_GROUP;

//temperate uniform
SET_GROUP(outfit_T)
	["UK3CB_BAF_U_CombatUniform_DPMT","UK3CB_BAF_U_CombatUniform_DPMT_RM","UK3CB_BAF_U_CombatUniform_DPMT_ShortSleeve","UK3CB_BAF_U_CombatUniform_DPMT_ShortSleeve_RM","UK3CB_BAF_U_JumperUniform_DPMT"] call FUNC(AddITemRandom);
	["UK3CB_BAF_V_PLCE_Webbing_DPMT","UK3CB_BAF_V_PLCE_Webbing_Plate_DPMT","UK3CB_BAF_V_Osprey_DPMT1","UK3CB_BAF_V_Osprey_DPMT2","UK3CB_BAF_V_Osprey_DPMT3","UK3CB_BAF_V_Osprey_DPMT4","UK3CB_BAF_V_Osprey_DPMT5","UK3CB_BAF_V_Osprey_DPMT6","UK3CB_BAF_V_Osprey_DPMT7","UK3CB_BAF_V_Osprey_DPMT8","UK3CB_BAF_V_Osprey_DPMT9"] call FUNC(AddItemRandom);
	["UK3CB_BAF_H_Mk6_DPMT_A","UK3CB_BAF_H_Mk6_DPMT_B","UK3CB_BAF_H_Mk6_DPMT_C","UK3CB_BAF_H_Mk6_DPMT_D","UK3CB_BAF_H_Mk6_DPMT_E","UK3CB_BAF_H_Mk6_DPMT_F"] call FUNC(AddItemRandom);
END_GROUP;

//MTP uniform
SET_GROUP(uniform_m)
	["UK3CB_BAF_U_CombatUniform_MTP","UK3CB_BAF_U_CombatUniform_MTP_RM","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM","UK3CB_BAF_U_CombatUniform_MTP_TShirt","UK3CB_BAF_U_CombatUniform_MTP_TShirt_RM","UK3CB_BAF_U_JumperUniform_MTP","UK3CB_BAF_U_RolledUniform_MTP"] call FUNC(AddItemRandom);
	["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Camo_C","UK3CB_BAF_H_Mk7_Camo_CESS_A","UK3CB_BAF_H_Mk7_Camo_CESS_B","UK3CB_BAF_H_Mk7_Camo_CESS_C","UK3CB_BAF_H_Mk7_Camo_CESS_D","UK3CB_BAF_H_Mk7_Camo_D","UK3CB_BAF_H_Mk7_Camo_E","UK3CB_BAF_H_Mk7_Camo_ESS_A","UK3CB_BAF_H_Mk7_Camo_ESS_B","UK3CB_BAF_H_Mk7_Camo_ESS_C","UK3CB_BAF_H_Mk7_Camo_ESS_D","UK3CB_BAF_H_Mk7_Camo_F","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_CESS_A","UK3CB_BAF_H_Mk7_Net_CESS_B","UK3CB_BAF_H_Mk7_Net_CESS_C","UK3CB_BAF_H_Mk7_Net_CESS_D","UK3CB_BAF_H_Mk7_Net_D","UK3CB_BAF_H_Mk7_Net_ESS_A","UK3CB_BAF_H_Mk7_Net_ESS_B","UK3CB_BAF_H_Mk7_Net_ESS_C","UK3CB_BAF_H_Mk7_Net_ESS_D","UK3CB_BAF_H_Mk7_Scrim_A","UK3CB_BAF_H_Mk7_Scrim_B","UK3CB_BAF_H_Mk7_Scrim_C","UK3CB_BAF_H_Mk7_Scrim_D","UK3CB_BAF_H_Mk7_Scrim_E","UK3CB_BAF_H_Mk7_Scrim_ESS_A","UK3CB_BAF_H_Mk7_Scrim_ESS_B","UK3CB_BAF_H_Mk7_Scrim_ESS_C","UK3CB_BAF_H_Mk7_Scrim_F"] call FUNC(AddItemRandom);
END_GROUP;

//arctic uniform
SET_GROUP(uniform_a)
	["UK3CB_BAF_U_Smock_Arctic"] call FUNC(AddItemRandom);
	["UK3CB_BAF_V_Osprey_Winter","UK3CB_BAF_V_PLCE_Webbing_Winter","UK3CB_BAF_V_PLCE_Webbing_Plate_Winter"] call FUNC(AddItem);
	["UK3CB_BAF_H_Mk7_Win_A","UK3CB_BAF_H_Mk7_Win_ESS_A"] call FUNC(AddItemRandom);
END_GROUP;

//medical gear
SET_GROUP(IFAK)
	["ACE_fieldDressing", 6, "uniform"] call FUNC(AddItem);
	["ACE_elasticBandage", 6, "uniform"] call FUNC(AddItem);
	["ACE_packingBandage", 6, "uniform"] call FUNC(AddItem);
	["ACE_quikclot", 6, "uniform"] call FUNC(AddItem);
	["ACE_morphine", 1, "uniform"] call FUNC(AddItem);
	["ACE_epinephrine", 1, "uniform"] call FUNC(AddItem);
	["ACE_tourniquet", 1, "uniform"] call FUNC(AddItem);
END_GROUP;

//odds and sods
SET_GROUP(items)
	["ACRE_PRC343", 1] call FUNC(AddItem);
	["UK3CB_BAF_HMNVS"] call FUNC(AddItem);
	["ItemMap"] call FUNC(AddItem);
	["ItemCompass"] call FUNC(AddItem);
	["ItemWatch"] call FUNC(AddItem);
	["ACE_MapTools"] call FUNC(AddItem);
	["ACE_earplugs"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(ammofrag)
	["SmokeShell", 1, "uniform"] call FUNC(AddItem);
	["HandGrenade", 2, "uniform"] call FUNC(AddItem);
	["UK3CB_BAF_556_30Rnd", 5, "vest"] call FUNC(AddItem);
	["UK3CB_BAF_556_30Rnd_T", 2, "vest"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(L85)
	["UK3CB_BAF_L85A2_RIS_AFG"] call FUNC(AddItem);
	["UK3CB_BAF_TA31F_Hornbill"] call FUNC(AddItem);
	["UK3CB_BAF_SFFH"] call FUNC(AddItem);
	["UK3CB_BAF_LLM_IR_Tan"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(crossload)
	["UK3CB_BAF_556_30Rnd", 2, "backpack"] call FUNC(AddItem);
	["UK3CB_BAF_762_20Rnd", 2, "backpack"] call FUNC(AddItem);
	["UK3CB_BAF_556_100Rnd", 1, "backpack"] call FUNC(AddItem);
	["UK3CB_BAF_1Rnd_60mm_Mo_Shells", 1 , "backpack"] call FUNC(AddItem);
END_GROUP;

//note: MTP is standard as that has greatest variety of vests and backpacks.

//platoon leader
case (package + "PL"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_SL_A","UK3CB_BAF_V_Osprey_SL_B","UK3CB_BAF_V_Osprey_SL_C","UK3CB_BAF_V_Osprey_SL_D"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_SL_H_A","UK3CB_BAF_B_Bergen_MTP_SL_L_A"] call FUNC(AddItemRandom);
	["UK3CB_BAF_Soflam_Laserdesignator"] call FUNC(AddItem);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(ammofrag);
	ADD_GROUP(L85);

};

//platoon sergeant
case (package + "PSG"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_SL_A","UK3CB_BAF_V_Osprey_SL_B","UK3CB_BAF_V_Osprey_SL_C","UK3CB_BAF_V_Osprey_SL_D"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"] call FUNC(AddItemRandom);
	ADD_GROUP(ammofrag);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	["UK3CB_BAF_1Rnd_HE_Grenade_Shell", 5, "vest"] call FUNC(AddItem);
	["UK3CB_BAF_L85A2_UGL"] call FUNC(AddItem);
	["UK3CB_BAF_TA31F_Hornbill"] call FUNC(AddItem);
	["UK3CB_BAF_SFFH"] call FUNC(AddItem);
	["UK3CB_BAF_LLM_IR_Tan"] call FUNC(AddItem);
	ADD_GROUP(crossload);

};

//platoon radioman
case (package + "RTO"): {

  ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_Rifleman_A","UK3CB_BAF_V_Osprey_Rifleman_B","UK3CB_BAF_V_Osprey_Rifleman_C","UK3CB_BAF_V_Osprey_Rifleman_D","UK3CB_BAF_V_Osprey_Rifleman_E","UK3CB_BAF_V_Osprey_Rifleman_F"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_Radio_H_A","UK3CB_BAF_B_Bergen_MTP_Radio_H_B","UK3CB_BAF_B_Bergen_MTP_Radio_L_A","UK3CB_BAF_B_Bergen_MTP_Radio_L_B"] call FUNC(AddItemRandom);
	["UK3CB_BAF_Soflam_Laserdesignator"] call FUNC(AddItem);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(ammofrag);
	ADD_GROUP(L85);

};

//platoon medic
case (package + "MED"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_Medic_A","UK3CB_BAF_V_Osprey_Medic_B","UK3CB_BAF_V_Osprey_Medic_C","UK3CB_BAF_V_Osprey_Medic_D"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_Medic_H_A","UK3CB_BAF_B_Bergen_MTP_Medic_H_B","UK3CB_BAF_B_Bergen_MTP_Medic_L_A","UK3CB_BAF_B_Bergen_MTP_Medic_L_B"] call FUNC(AddItemRandom);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(ammofrag);
	ADD_GROUP(L85);
	["ACE_fieldDressing", 15, "backpack"] call FUNC(AddItem);
	["ACE_elasticBandage", 20, "backpack"] call FUNC(AddItem);
	["ACE_packingBandage", 20, "backpack"] call FUNC(AddItem);
	["ACE_quikclot", 12, "backpack"] call FUNC(AddItem);
	["ACE_atropine", 10, "backpack"] call FUNC(AddItem);
	["ACE_morphine", 8, "backpack"] call FUNC(AddItem);
	["ACE_epinephrine", 8, "backpack"] call FUNC(AddItem);
	["ACE_tourniquet", 5, "backpack"] call FUNC(AddItem);
	["ACE_salineIV_500", 1, "backpack"] call FUNC(AddItem);
	["ACE_surgicalKit", 3, "backpack"] call FUNC(AddItem);
	["ACE_personalAidKit", 3, "backpack"] call FUNC(AddItem);

};

//platoon mortarman
case (package + "MO"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_Rifleman_A","UK3CB_BAF_V_Osprey_Rifleman_B","UK3CB_BAF_V_Osprey_Rifleman_C","UK3CB_BAF_V_Osprey_Rifleman_D","UK3CB_BAF_V_Osprey_Rifleman_E","UK3CB_BAF_V_Osprey_Rifleman_F"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"] call FUNC(AddItemRandom);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(ammofrag);
	ADD_GROUP(L85);
	["UK3CB_BAF_1Rnd_60mm_Mo_Shells", 3, "backpack"] call FUNC(AddItem);
	["UK3CB_BAF_M6"] call FUNC(AddItem);

};

//section lead
case (package + "CPL"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_SL_A","UK3CB_BAF_V_Osprey_SL_B","UK3CB_BAF_V_Osprey_SL_C","UK3CB_BAF_V_Osprey_SL_D"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_SL_H_A","UK3CB_BAF_B_Bergen_MTP_SL_L_A"] call FUNC(AddItemRandom);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(ammofrag);
	["UK3CB_BAF_1Rnd_HE_Grenade_Shell", 5, "vest"] call FUNC(AddItem);
	["UK3CB_BAF_L85A2_UGL"] call FUNC(AddItem);
	["UK3CB_BAF_TA31F_Hornbill"] call FUNC(AddItem);
	["UK3CB_BAF_SFFH"] call FUNC(AddItem);
	["UK3CB_BAF_LLM_IR_Tan"] call FUNC(AddItem);
	ADD_GROUP(crossload);

};

//section 2IC
case (package + "LCPL"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_SL_A","UK3CB_BAF_V_Osprey_SL_B","UK3CB_BAF_V_Osprey_SL_C","UK3CB_BAF_V_Osprey_SL_D"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_PointMan_H_A","UK3CB_BAF_B_Bergen_MTP_PointMan_L_A"] call FUNC(AddItemRandom);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(ammofrag);
	ADD_GROUP(L85);
	["UK3CB_BAF_AT4_CS_AT_Launcher","UK3CB_BAF_AT4_CS_AP_Launcher"] call FUNC(AddItemRandom);

};

//section GL
case (package + "GP"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_Grenadier_A","UK3CB_BAF_V_Osprey_Grenadier_B"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"] call FUNC(AddItemRandom);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(ammofrag);
	["UK3CB_BAF_1Rnd_HE_Grenade_Shell", 5, "vest"] call FUNC(AddItem);
	["UK3CB_BAF_L85A2_UGL"] call FUNC(AddItem);
	["UK3CB_BAF_TA31F_Hornbill"] call FUNC(AddItem);
	["UK3CB_BAF_SFFH"] call FUNC(AddItem);
	["UK3CB_BAF_LLM_IR_Tan"] call FUNC(AddItem);

 };

//section sharpshooter
case (package + "DM"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_Marksman_A"] call FUNC(AddItem);
	["UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"] call FUNC(AddItemRandom);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(crossload);
	["SmokeShell", 1, "uniform"] call FUNC(AddItem);
	["HandGrenade", 2, "uniform"] call FUNC(AddItem);
	["UK3CB_BAF_762_20Rnd", 5, "vest"] call FUNC(AddItem);
	["UK3CB_BAF_762_20Rnd_T", 2, "vest"] call FUNC(AddItem);
	["UK3CB_BAF_L129A1_FGrip"] call FUNC(AddItem);
	["UK3CB_BAF_TA648"] call FUNC(AddItem);
	["UK3CB_BAF_LLM_IR_Black"] call FUNC(AddItem);

 };

//Section autorifleman
case (package + "AR"): {

	ADD_GROUP(uniform_m);
	["UK3CB_BAF_V_Osprey_MG_A","UK3CB_BAF_V_Osprey_MG_B"] call FUNC(AddItemRandom);
	["UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_C","UK3CB_BAF_B_Bergen_MTP_Rifleman_L_D"] call FUNC(AddItemRandom);
	ADD_GROUP(ifak);
	ADD_GROUP(items);
	ADD_GROUP(crossload);
	["SmokeShell", 1, "uniform"] call FUNC(AddItem);
	["HandGrenade", 2, "uniform"] call FUNC(AddItem);
	["UK3CB_BAF_556_100Rnd", 2] call FUNC(AddItem);
	["UK3CB_BAF_556_100Rnd_T", 1] call FUNC(AddItem);
	["UK3CB_BAF_L110A3"] call FUNC(AddItem);
	["UK3CB_BAF_TA31F"] call FUNC(AddItem);

};