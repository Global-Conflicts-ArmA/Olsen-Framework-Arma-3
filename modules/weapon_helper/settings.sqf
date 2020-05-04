//WEAPON HELPER MODULE
//
//Example:		[_unit,_type,["rhs_weap_m4a1_carryhandle_m203S","rhsusf_acc_anpeq15side_bk","rhsusf_acc_RX01","rhs_mag_30Rnd_556x45_M855_Stanag_Pull"],"vest",6] call FNC_wephelper;
//Author:		TinfoilHate
//
//Definition:	[_unit,_type,[WEAPON/MAGAZINE/ACC ARRAY],DESTINATION,MAXQTY] call FNC_wephelper;
//				[_unit,_type,["UK3CB_RPK_75Rnd_Drum"],"backpack",6] call FNC_maghelper;
//
//Description: 	This will add a randomly selected weapon with usable magazines and accessories from the listed array. By default it will add as many magazines as possible.
// 				DESTINATION is either "uniform", "vest", "backpack", and is optional
//				MAXQTY is the most magazines it will add to the specified location
//
//Comments: 	DESTINATION and MAXQTY are optional.


//These determine the chance that an attachment from each category is selected. >1 always has one, and the lower the number, the more rare it is.
fw_weaponhelper_opticChance 	= 2;
fw_weaponhelper_muzzleChance	= 2;
fw_weaponhelper_pointerChance	= 2;
fw_weaponhelper_bipodChance		= 2;