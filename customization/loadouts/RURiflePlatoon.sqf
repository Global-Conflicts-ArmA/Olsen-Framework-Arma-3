//AUTHOR: Olsen
//
//[this, "RURiflePlatoon_SL"] call FUNC(GearScript);
//[this, "RURiflePlatoon_TL"] call FUNC(GearScript);
//[this, "RURiflePlatoon_AR"] call FUNC(GearScript);
//[this, "RURiflePlatoon_MD"] call FUNC(GearScript);
//[this, "RURiflePlatoon_RF"] call FUNC(GearScript);
//[this, "RURiflePlatoon_RFAT"] call FUNC(GearScript);

#define package "RURiflePlatoon_"

SET_GROUP(uniform)
	["rhs_uniform_vdv_emr_des"] call FUNC(AddItem);
	["rhs_assault_umbts"] call FUNC(AddItem);
	["rhs_6b28"] call FUNC(AddItemRandom);
END_GROUP;
	
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
	
	["rhs_6b23_digi_6sh92_headset_mapcase"] call FUNC(AddItem); //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["Binocular"] call FUNC(AddItem);
	
	["ACRE_PRC152", 1] call FUNC(AddItem); //Long range radio
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green", 2] call FUNC(AddItem); //Magazines
	
	["rhs_mag_rdg2_white", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_rdg2_black", 2] call FUNC(AddItem); //Black smoke
	["rhs_mag_rgd5", 2] call FUNC(AddItem); //Frag grenade

	["rhs_weap_ak74m"] call FUNC(AddItem); //Primary rifle
	["rhs_acc_pkas"] call FUNC(AddItem); //Red dot sight
	
};

case (package + "TL"): {
	
	["rhs_6b23_digi_6sh92_radio"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FUNC(AddItem); //Magazines
	["rhs_30Rnd_545x39_AK_green", 2] call FUNC(AddItem); //Magazines
	
	["rhs_mag_rdg2_white", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_rdg2_black", 2] call FUNC(AddItem); //Black smoke
	["rhs_mag_rgd5", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_VOG25", 12] call FUNC(AddItem); //Frag Grenade  (m203)
	["rhs_GRD40_White", 6] call FUNC(AddItem); //Red Smoke  (m203)
	
	["rhs_weap_ak74m_gp25"] call FUNC(AddItem); //Primary rifle
	["rhs_acc_pkas"] call FUNC(AddItem); //Red dot sight

};

case (package + "AR"): {
	
	["rhs_6b23_digi_6sh92"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_100Rnd_762x54mmR", 3] call FUNC(AddItem); //Magazines
	
	["rhs_weap_pkp"] call FUNC(AddItem); //Primary rifle
	["rhs_acc_pkas"] call FUNC(AddItem); //Red dot sight
	["ACE_SpareBarrel", 1] call FUNC(AddItem);  // Spare Barrel
	
};

case (package + "RFAT"): {
	
	["rhs_6b23_digi_6sh92"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FUNC(AddItem); //Magazines
	
	["rhs_weap_ak74m"] call FUNC(AddItem); //Primary rifle
	["rhs_acc_pkas"] call FUNC(AddItem); //Red dot sight
	
	["rhs_weap_rpg26"] call FUNC(AddItem); //Anti tank launcher
	
};

case (package + "RF"): {
	
	["rhs_6b23_digi_6sh92"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 2] call FUNC(AddItem); //White smoke
	["rhs_mag_rgd5", 2] call FUNC(AddItem); //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FUNC(AddItem); //Magazines
	
	["rhs_weap_ak74m"] call FUNC(AddItem); //Primary rifle
	["rhs_acc_pkas"] call FUNC(AddItem); //Red dot sight
	
	["rhs_100Rnd_762x54mmR", 1] call FUNC(AddItem); //Spare AR ammo
	
};

case (package + "MD"): {
	
	["rhs_6b23_digi_6sh92"] call FUNC(AddItem);  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 4] call FUNC(AddItem); //White smoke
	
	["rhs_30Rnd_545x39_7N10_AK", 6] call FUNC(AddItem); //Magazines
	
	["rhs_weap_ak74m"] call FUNC(AddItem); //Primary rifle
	["rhs_acc_pkas"] call FUNC(AddItem); //Red dot sight
	
	//Extra Medic Supplies
	["ACE_fieldDressing", 15] call FUNC(AddItem);
	["ACE_elasticBandage", 20] call FUNC(AddItem);
	["ACE_packingBandage", 20] call FUNC(AddItem);
	["ACE_quikclot", 12] call FUNC(AddItem);
	["ACE_atropine", 10] call FUNC(AddItem);
	["ACE_morphine", 8] call FUNC(AddItem);
	["ACE_epinephrine", 8] call FUNC(AddItem);
	["ACE_tourniquet", 5] call FUNC(AddItem);
	["ACE_salineIV_500", 1] call FUNC(AddItem);
	["ACE_surgicalKit", 3] call FUNC(AddItem);
	["ACE_personalAidKit", 3] call FUNC(AddItem);
	
};