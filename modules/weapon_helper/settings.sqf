/*
This module can assist with converting this mess...

[_unit,_type,["rhs_weap_akm","rhs_weap_akms","rhs_acc_dtkakm","rhs_30Rnd_762x39mm_bakelite","rhs_30Rnd_762x39mm","rhs_weap_m70b1","rhs_weap_m70b1","rhs_30Rnd_762x39mm_bakelite","rhs_30Rnd_762x39mm","rhs_weap_ak74","rhs_weap_ak74_2","rhs_acc_dtk1983","rhs_30Rnd_545x39_7N6M_AK","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_weap_pp2000","rhs_mag_9x19mm_7n21_44","rhs_weap_m3a1","rhsgref_30rnd_1143x23_M1911B_SMG","rhs_weap_kar98k","rhsgref_5Rnd_792x57_kar98k","rhs_weap_m1garand_sa43","rhsgref_8Rnd_762x63_M2B_M1rifle","rhs_weap_m38","rhsgref_5Rnd_762x54_m38","rhs_weap_MP44","rhsgref_30Rnd_792x33_SmE_StG","rhs_weap_savz58p","rhs_30Rnd_762x39mm_Savz58","rhs_weap_savz61","rhsgref_20rnd_765x17_vz61","rhs_acc_dtk1l","rhs_acc_2dpZenit","rhs_weap_akmn","rhs_acc_dtkakm","rhs_acc_1p29","hlc_20Rnd_762x51_B_M14","hlc_rifle_M14","hlc_20Rnd_762x51_B_fal","hlc_rifle_LAR","hlc_rifle_FAL5000","hlc_rifle_FAL5061","hlc_rifle_L1A1SLR","hlc_rifle_rpk762","hlc_75Rnd_762x39_m_rpk","hlc_45Rnd_762x39_m_rpk","hlc_rifle_rpk","rhs_weap_pm63","rhs_weap_Izh18","rhsgref_1Rnd_Slug","rhsgref_1Rnd_00Buck","rhs_weap_m92","JO_71rnd_762x25","jo_rf_ppsh","hlc_rifle_M1903A1","hlc_5rnd_3006_1903","hlc_rifle_SLRchopmod","hlc_rifle_g3a3","hlc_20rnd_762x51_b_G3","hlc_rifle_hk33a2","hlc_30rnd_556x45_b_HK33","hlc_rifle_hk53","hlc_rifle_g3a3v","rhs_weap_aks74","rhs_weap_aks74u"]] call FNC_wephelper;

...into a randomized, kitted-out insurgent force. Basically, you can throw a disorganized array of weapons, magazines, and weapon 
accessories, and it will select a random weapon, accessories that work with that weapon, and fill any remaining inventory space with magazines for the weapon.

This is meant to be inserted into the gearscript as-is, after all other items have been added to the loadout.

A very basic example is:

[_unit, _type, 5, ["rhs_weap_akm"]] call FNC_WepHelper;

This will add an AKM and fill the unit's inventory space with up to 5 magazines for the AKM, randomly selected from all the AKM magazines available.

A more reasonable example is:

[_unit, _type, 9, ["rhs_weap_akm", "rhs_weap_akms", "rhs_acc_dtkakm", "rhs_30Rnd_762x39mm_bakelite", "rhs_30Rnd_762x39mm"]] call FNC_WepHelper;

This will add an AKM or AKMS, the DTK muzzle attachment, and fill the unit's remaining inventory space with a random selection of up to 
9 bakelite and normal magazines.

The initial example would be for an insurgent force, and is intended to provide a wide variety of randomized weapons with little effort and mag counting.
*/

//These determine the chance that an attachment from each category is selected. > 1 always has one, and the lower the number, the more rare it is.
fw_weaponhelper_opticChance 	= 0.5;
fw_weaponhelper_muzzleChance	= 0.5;
fw_weaponhelper_pointerChance	= 0.5;
fw_weaponhelper_bipodChance		= 0.5;
