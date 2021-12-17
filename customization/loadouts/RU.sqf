// BY REDDISH_RED

/*
[this, "RU_RF"] call FW_fnc_GearScript; - Rifleman
[this, "RU_MG"] call FW_fnc_GearScript; - MachineGunner
[this, "RU_AR"] call FW_fnc_GearScript; - Auto-rifleman
[this, "RU_GP"] call FW_fnc_GearScript; - Grenadier
[this, "RU_SL"] call FW_fnc_GearScript; - Squad Leader/Platoon Leader
[this, "RU_TL"] call FW_fnc_GearScript; - Team Leader
[this, "RU_MED"] call FW_fnc_GearScript; - Medic
[this, "RU_MKS"] call FW_fnc_GearScript; - Marksman
[this, "RU_AT"] call FW_fnc_GearScript; - Anti-Tank
[this, "RU_ATA"] call FW_fnc_GearScript; - Anti-Tank Assistant
[this, "RU_COM"] call FW_fnc_GearScript; - Vehicle Commander
[this, "RU_CRW"] call FW_fnc_GearScript; - Vehicle Crew
*/

#define package "RU_"

////////////////////
//// UNIFORMS //////
////////////////////

SET_GROUP(UNI_RF)
	// UNIFORM
	["gorkaksor","gorkaemrd","CUP_U_O_RUS_Ratnik_BeigeDigital","rhs_uniform_emr_des_patchless"] call FUNC(AddItemRandom);
	// VEST
	["CUP_Vest_RUS_6B45_Sh117_BeigeDigital"] call FUNC(AddItem);
	// BACKPACKS
	["CUP_O_RUS_Patrol_bag_BeigeDigital","rhs_tortila_khaki"] call FUNC(AddItemRandom);
	// HELMET
	["CUP_H_RUS_6B47_v2_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesClosed_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesDown_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesUp_BeigeDigital","rhs_6b47_bare_d","hg_6b7_des","hg_6b7_des_ess"] call FUNC(AddItemRandom);
	// FACEWARE (IF YOU WANT)
	["deth_blclva_olive","deth_blclva_black","deth_blclva_tan","rhs_balaclava"] call FUNC(AddItemRandom);
	// NVG (IF NIGHT)
	["rhs_1PN138"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(UNI_GP)
	// UNIFORM
	["gorkaksor","gorkaemrd","CUP_U_O_RUS_Ratnik_BeigeDigital","rhs_uniform_emr_des_patchless"] call FUNC(AddItemRandom);
	// VEST
	["CUP_Vest_RUS_6B45_Sh117_VOG_BeigeDigital"] call FUNC(AddItem);
	// BACKPACKS
	["CUP_O_RUS_Patrol_bag_BeigeDigital","rhs_tortila_khaki"] call FUNC(AddItemRandom);
	// HELMET
	["CUP_H_RUS_6B47_v2_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesClosed_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesDown_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesUp_BeigeDigital","rhs_6b47_bare_d","hg_6b7_des","hg_6b7_des_ess"] call FUNC(AddItemRandom);
	// FACEWARE (IF YOU WANT)
	["deth_blclva_olive","deth_blclva_black","deth_blclva_tan","rhs_balaclava"] call FUNC(AddItemRandom);
	// NVG (IF NIGHT)
	["rhs_1PN138"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(UNI_MG)
	// UNIFORM
	["gorkaksor","gorkaemrd","CUP_U_O_RUS_Ratnik_BeigeDigital","rhs_uniform_emr_des_patchless"] call FUNC(AddItemRandom);
	// VEST
	["CUP_Vest_RUS_6B45_Sh117_PKP_BeigeDigital"] call FUNC(AddItem);
	// BACKPACKS
	["CUP_O_RUS_Patrol_bag_BeigeDigital","rhs_tortila_khaki"] call FUNC(AddItemRandom);
	// HELMET
	["CUP_H_RUS_6B47_v2_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesClosed_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesDown_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesUp_BeigeDigital","rhs_6b47_bare_d","hg_6b7_des","hg_6b7_des_ess"] call FUNC(AddItemRandom);
	// FACEWARE (IF YOU WANT)
	["deth_blclva_olive","deth_blclva_black","deth_blclva_tan","rhs_balaclava"] call FUNC(AddItemRandom);
	// NVG (IF NIGHT)
	["rhs_1PN138"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(UNI_AT)
	// UNIFORM
	["gorkaksor","gorkaemrd","CUP_U_O_RUS_Ratnik_BeigeDigital","rhs_uniform_emr_des_patchless"] call FUNC(AddItemRandom);
	// VEST
	["CUP_Vest_RUS_6B45_Sh117_BeigeDigital"] call FUNC(AddItem);
	// BACKPACKS
	["rhs_rpg_2","rhs_rpg_empty"] call FUNC(AddItemRandom);
	// HELMET
	["CUP_H_RUS_6B47_v2_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesClosed_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesDown_BeigeDigital","CUP_H_RUS_6B47_v2_GogglesUp_BeigeDigital","rhs_6b47_bare_d","hg_6b7_des","hg_6b7_des_ess"] call FUNC(AddItemRandom);
	// FACEWARE (IF YOU WANT)
	["deth_blclva_olive","deth_blclva_black","deth_blclva_tan","rhs_balaclava"] call FUNC(AddItemRandom);
	// NVG (IF NIGHT)
	["rhs_1PN138"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(UNI_CRW)
	// UNIFORM
	["gorkaksor","gorkaemrd","CUP_U_O_RUS_Ratnik_BeigeDigital","rhs_uniform_emr_des_patchless"] call FUNC(AddItemRandom);
	// VEST
	["CUP_Vest_RUS_6B45_Sh117_BeigeDigital"] call FUNC(AddItem);
	// BACKPACKS
	["CUP_O_RUS_Patrol_bag_BeigeDigital","rhs_tortila_khaki"] call FUNC(AddItemRandom);
	// HELMET
	["rhs_tsh4","rhs_tsh4_ess"] call FUNC(AddItemRandom);
	// FACEWARE (IF YOU WANT)
	["deth_blclva_olive","deth_blclva_black","deth_blclva_tan","rhs_balaclava"] call FUNC(AddItemRandom);
	// NVG (IF NIGHT)
	["rhs_1PN138"] call FUNC(AddItem);
END_GROUP;


////////////////////
//// ITEMS //////
////////////////////

SET_GROUP(items)
	["ItemCompass"] call FUNC(AddItem);
	["ItemMap"] call FUNC(AddItem);
	["ItemWatch"] call FUNC(AddItem);
	["ACRE_PRC343", 1, "backpack"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(IFAK)
	["ACE_fieldDressing", 2, "uniform"] call FUNC(AddItem);
	["ACE_elasticBandage", 2, "uniform"] call FUNC(AddItem);
	["ACE_packingBandage", 2, "uniform"] call FUNC(AddItem);
	["ACE_tourniquet", 2, "uniform"] call FUNC(AddItem);
	["ACE_splint", 1, "uniform"] call FUNC(AddItem);
END_GROUP;

SET_GROUP(NADES)
	["rhs_mag_rgd5",2,"uniform"] call FUNC(AddItem);
	["rhs_mag_rdg2_white",2,"vest"] call FUNC(AddItem);
END_GROUP;

/////////////////
//// CASES //////
/////////////////



case (package + "RF"): { // Rifleman
	ADD_GROUP(UNI_RF);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);
	["rhs_weap_rpg26"] call FUNC(AddItem);

	[_unit, ["rhs_weap_ak74mr","rhs_weap_ak74m_zenitco01","rhs_acc_okp7_dovetail","rhs_acc_ekp8_02","rhs_acc_1p63","rhs_acc_perst3","rhs_acc_dtk3","rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhs_30Rnd_545x39_7N22_AK","rhs_acc_rakurspm","rhs_acc_1p87","rhs_acc_ekp8_18","rhs_acc_okp7_picatinny","rhs_weap_ak74mr","rhs_acc_uuk"], "vest", 8] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"backpack"] call FUNC(AddItem);
};

case (package + "MG"): { // Machinegunner
	ADD_GROUP(UNI_MG);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["CUP_lmg_Pecheneg_top_rail_B50_vfg","rhs_acc_rakurspm","rhs_acc_1p87","rhs_acc_ekp8_18","rhs_acc_okp7_picatinny","rhs_acc_perst3","rhs_100Rnd_762x54mmR_7N26","CUP_lmg_Pecheneg_B50_vfg","rhs_acc_ekp8_02","rhs_acc_okp7_dovetail","rhs_acc_pkas","rhs_acc_1p63","cup_muzzle_mfsup_flashhider_pk_black","rhs_acc_perst3"], "vest", 2] call EFUNC(WEPHELP,addWeapon);
	["rhs_100Rnd_762x54mmR_green",2,"backpack"] call FUNC(AddItem);
	["rhs_100Rnd_762x54mmR_7N26",2,"backpack"] call FUNC(AddItem);
};

case (package + "AR"): { // RPK-74M Gunner
	ADD_GROUP(UNI_MG);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["rhs_weap_rpk74m","rhs_acc_1p63","rhs_acc_ekp8_02","rhs_acc_okp7_dovetail","rhs_acc_pkas","rhs_weap_rpk74m_npz","rhs_acc_rakurspm","rhs_acc_1p87","rhs_acc_ekp8_18","rhs_acc_okp7_picatinny","rhs_60Rnd_545X39_7N22_AK","rhs_acc_perst1ik","rhs_acc_uuk"], "vest", 6] call EFUNC(WEPHELP,addWeapon);
	["rhs_60Rnd_545X39_AK_Green",2,"backpack"] call FUNC(AddItem);
};

case (package + "GP"): { // Grenadier
	ADD_GROUP(UNI_GP);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["rhs_weap_ak74m_gp25_npz","rhs_acc_rakurspm","rhs_acc_1p87","rhs_acc_ekp8_18","rhs_acc_okp7_picatinny","rhs_acc_uuk","rhs_30Rnd_545x39_7N22_AK","rhs_weap_ak74mr_gp25","rhs_acc_perst3"], "vest", 6] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"backpack"] call FUNC(AddItem);
	["rhs_VOG25P",15,"backpack"] call FUNC(AddItem);
	["rhs_GRD40_White",5,"vest"] call FUNC(AddItem);
	["rhs_GRD40_Green",5,"vest"] call FUNC(AddItem);
	["rhs_GRD40_Red",5,"vest"] call FUNC(AddItem);
};

case (package + "SL"): { // Squad Leader/Platoon Leader
	ADD_GROUP(UNI_RF);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);
	["rhs_pdu4"] call FUNC(AddItem);
	["Laserbatteries",1,"backpack"] call FUNC(AddItem);
	["ACRE_PRC148",1,"backpack"] call FUNC(AddItem);
	["UK3CB_BAF_SmokeShellGreen",2,"backpack"] call FUNC(AddItem);
	["UK3CB_BAF_SmokeShellRed",2,"backpack"] call FUNC(AddItem);

	[_unit, ["rhs_weap_ak74m_zenitco01","rhs_acc_1p29","rhs_acc_perst3","rhs_acc_perst1ik","rhs_acc_uuk","rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhs_30Rnd_545x39_7N22_AK"], "vest", 8] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"backpack"] call FUNC(AddItem);
	[_unit, ["rhs_weap_pya","rhs_mag_9x19_7n31_17"], "backpack", 4] call EFUNC(WEPHELP,addWeapon);
};

case (package + "TL"): { // Team Leader
	ADD_GROUP(UNI_RF);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);
	["rhs_pdu4"] call FUNC(AddItem);
	["Laserbatteries",1,"backpack"] call FUNC(AddItem);
	["UK3CB_BAF_SmokeShellGreen",2,"backpack"] call FUNC(AddItem);
	["UK3CB_BAF_SmokeShellRed",2,"backpack"] call FUNC(AddItem);

	[_unit, ["rhs_weap_ak74m_zenitco01","rhs_acc_1p29","rhs_acc_perst3","rhs_acc_perst1ik","rhs_acc_uuk","rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhs_30Rnd_545x39_7N22_AK"], "vest", 8] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"backpack"] call FUNC(AddItem);
	[_unit, ["rhs_weap_pya","rhs_mag_9x19_7n31_17"], "backpack", 4] call EFUNC(WEPHELP,addWeapon);
};

case (package + "MED"): { // Medic
	ADD_GROUP(UNI_RF);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["rhs_weap_ak74mr","rhs_weap_ak74m_zenitco01","rhs_acc_okp7_dovetail","rhs_acc_ekp8_02","rhs_acc_1p63","rhs_acc_perst3","rhs_acc_dtk3","rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhs_30Rnd_545x39_7N22_AK","rhs_acc_rakurspm","rhs_acc_1p87","rhs_acc_ekp8_18","rhs_acc_okp7_picatinny","rhs_weap_ak74mr","rhs_acc_uuk"], "vest", 6] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"backpack"] call FUNC(AddItem);
	["ACE_surgicalKit",1,"backpack"] call FUNC(AddItem);
	["ACE_fieldDressing",15,"vest"] call FUNC(AddItem);
	["ACE_quikclot",15,"vest"] call FUNC(AddItem);
	["ACE_packingBandage",15,"backpack"] call FUNC(AddItem);
	["ACE_elasticBandage",15,"backpack"] call FUNC(AddItem);
	["ACE_tourniquet",10,"backpack"] call FUNC(AddItem);
	["ACE_splint", 10, "backpack"] call FUNC(AddItem);
	["ACE_morphine",15,"backpack"] call FUNC(AddItem);
	["ACE_epinephrine",15,"vest"] call FUNC(AddItem);
	["ACE_salineIV_250",8,"backpack"] call FUNC(AddItem);
	["ACE_salineIV_500",6,"backpack"] call FUNC(AddItem);
	["ACE_salineIV",4,"backpack"] call FUNC(AddItem);
};

case (package + "MKS"): { // Marksman
	ADD_GROUP(UNI_RF);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["rhs_weap_svdp_npz","rhs_acc_dh520x56","rhs_acc_tgpv2","rhs_10Rnd_762x54mmR_7N14"], "vest", 12] call EFUNC(WEPHELP,addWeapon);
	["ACE_10Rnd_762x54_Tracer_mag",2,"backpack"] call FUNC(AddItem);
	[_unit, ["rhs_weap_pya","rhs_mag_9x19_7n31_17"], "backpack", 4] call EFUNC(WEPHELP,addWeapon);
};

case (package + "AT"): { // Anti-Tank
	ADD_GROUP(UNI_AT);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["rhs_weap_ak74mr","rhs_weap_ak74m_zenitco01","rhs_acc_okp7_dovetail","rhs_acc_ekp8_02","rhs_acc_1p63","rhs_acc_perst3","rhs_acc_dtk3","rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhs_30Rnd_545x39_7N22_AK","rhs_acc_rakurspm","rhs_acc_1p87","rhs_acc_ekp8_18","rhs_acc_okp7_picatinny","rhs_weap_ak74mr","rhs_acc_uuk"], "vest", 6] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"vest"] call FUNC(AddItem);
	["rhs_weap_rpg7"] call FUNC(AddItem);
	_unit addSecondaryWeaponItem "rhs_acc_pgo7v3";
	["rhs_rpg7_PG7VM_mag",2,"backpack"] call FUNC(AddItem);
	["rhs_rpg7_OG7V_mag",2,"backpack"] call FUNC(AddItem);
};

case (package + "ATA"): { // Anti-Tank Assistant
	ADD_GROUP(UNI_AT);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["rhs_weap_ak74mr","rhs_weap_ak74m_zenitco01","rhs_acc_okp7_dovetail","rhs_acc_ekp8_02","rhs_acc_1p63","rhs_acc_perst3","rhs_acc_dtk3","rhs_acc_grip_ffg2","rhs_acc_grip_rk2","rhs_acc_grip_rk6","rhs_30Rnd_545x39_7N22_AK","rhs_acc_rakurspm","rhs_acc_1p87","rhs_acc_ekp8_18","rhs_acc_okp7_picatinny","rhs_weap_ak74mr","rhs_acc_uuk"], "vest", 6] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"vest"] call FUNC(AddItem);
	["rhs_rpg7_PG7VM_mag",2,"backpack"] call FUNC(AddItem);
	["rhs_rpg7_OG7V_mag",2,"backpack"] call FUNC(AddItem);
};

case (package + "COM"): { // Rifleman
	ADD_GROUP(UNI_CRW);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);
	["ACRE_PRC148",1,"backpack"] call FUNC(AddItem);
	["rhs_pdu4"] call FUNC(AddItem);
	["Laserbatteries",1,"backpack"] call FUNC(AddItem);

	[_unit, ["rhs_weap_aks74un","rhs_acc_1p63","rhs_acc_ekp8_02","rhs_acc_okp7_dovetail","rhs_acc_pkas","rhs_acc_uuk","rhs_30Rnd_545x39_7N22_AK"], "vest", 4] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"backpack"] call FUNC(AddItem);
};

case (package + "CRW"): { // Rifleman
	ADD_GROUP(UNI_CRW);
	ADD_GROUP(items);
	ADD_GROUP(IFAK);
	ADD_GROUP(NADES);

	[_unit, ["rhs_weap_aks74un","rhs_acc_1p63","rhs_acc_ekp8_02","rhs_acc_okp7_dovetail","rhs_acc_pkas","rhs_acc_uuk","rhs_30Rnd_545x39_7N22_AK"], "vest", 4] call EFUNC(WEPHELP,addWeapon);
	["rhs_30Rnd_545x39_AK_plum_green",2,"backpack"] call FUNC(AddItem);
};
