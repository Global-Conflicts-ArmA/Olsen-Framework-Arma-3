//This is a example template for making loadouts
//Commands: 
//call FNC_AddItemRandom; - Adds a random item in the array.
//call FNC_AddItem; - Adds the specifc item from the array.

//Notes:
//1. Everything is case sensitive

//2. If you are attemping to use the kobld_paraflare module, the flare classname you need are FlareWhite_F, FlareGreen_F, FlareRed_F

//3. If you wish to give units random weapons and matching random ammo + attachmemts, check out the weapon_helper module.

//4. Anything with // before it can be removed without issue, it's mearly a guide.


//Below is the package name, change "PackageNameHere", while keeping the underscore, to an abbreviation of your package, usually this will be a faction, such as USMC, BAF, RU, etc..
#define package "PackageNameHere_" 

SET_GROUP(uniform)
//Helmets/Hats
["YourClassnameHere"] call FNC_AddItem;
//Uniform/clothes
["YourClassnameHere","YourClassnameHere","YourClassnameHere"] call FNC_AddItemRandom;
//Vests
["YourClassnameHere"] call FNC_AddItem;
//Backpack
["YourClassnameHere"] call FNC_AddItem;

END_GROUP;

SET_GROUP(items)
//Remove any items below you don't wish units to start with.
	["ACRE_PRC343", 1] call FNC_AddItem; //Squad radio
	["UK3CB_BAF_HMNVS"] call FNC_AddItem; //NVGs
	["ItemMap"] call FNC_AddItem; //Map
	["ItemCompass"] call FNC_AddItem; //Compass
	["ItemWatch"] call FNC_AddItem; //Watch
	["ACE_MapTools"] call FNC_AddItem; //Maptools
	["ACE_earplugs"] call FNC_AddItem; //Earplugs
END_GROUP;

//Below is an example of a weapon group - Note you can set the quantity of an item and the container it will go into, container choices are uniform, vest, and backpack.

//SET_GROUP(RIFLE)
//["UK3CB_BAF_L85A3"] call FNC_AddItem; - Rifle
//["cup_optic_elcan_reflex_coyote"] call FNC_AddItem; - Sight/Optic
//["uk3cb_baf_sffh"] call FNC_AddItem; - Muzzle attachment
//["uk3cb_baf_llm_ir_black"] call FNC_AddItem; - Side/Light attachment
//["UK3CB_BAF_L131A1"] call FNC_AddItem; - Pistol
//["uk3cb_baf_flashlight_l131a1"] call FNC_AddItem; - Pistol flashlight
//["UK3CB_BAF_9_17Rnd",1,"vest"] call FNC_AddItem; - Pistol ammo
//["UK3CB_BAF_556_30Rnd",6,"vest"] call FNC_AddItem; - Rifle ammo
//["UK3CB_BAF_556_30Rnd_T",4,"vest"] call FNC_AddItem; - Rifle ammo tracer
//END_GROUP;

//Weapon groups
SET_GROUP(UGL)
//Weapon, ammo, and attachmemt classnames for a UGL/GL rifle
END_GROUP;	

SET_GROUP(RIFLE)
//Weapon, ammo and attachmemt classnames for an regular rifle here
END_GROUP;

SET_GROUP(MARKS)
//Weapon, ammo and attachmemt classnames for a sniper/marksman/sharpshooter weapon here
END_GROUP;

SET_GROUP(MG)	
//Weapon, ammo, and attachmemt classnames for an MG weapon here
END_GROUP;

SET_GROUP(LMG)
//Weapon, ammo, and attachmemt classnames for an LMG weapon here
END_GROUP;

SET_GROUP(NADES1)
//Grenades/Throwables for regular units
END_GROUP;

SET_GROUP(NADES2)
//Grenades/Throwables for command units
END_GROUP;

SET_GROUP(IFAK) 
//Medical supplies for everyone
END_GROUP;

SET_GROUP(medic)
//Medical supplies for the medic
END_GROUP;

SET_GROUP(radio)
//Group for the RTOs specifc backpack and radios
END_GROUP;

SET_GROUP(ruck)
//Group for giving people specifc backpacks instead of the array in the uniform group
END_GROUP;


//Below is an example of a class/role loadout - Note you can set the quantity of an item and the container it will go into, container choices are uniform, vest, and backpack.

//case (package + "PL"): {

	//ADD_GROUP(uniform);
	//ADD_GROUP(IFAK);
	//ADD_GROUP(items);
	//ADD_GROUP(UGL);
	//ADD_GROUP(NADES2);

	//["ACRE_PRC148"] call FNC_AddItem;
	//["ACE_Vector"] call FNC_AddItem;
	//["ACE_microDAGR"] call FNC_AddItem;
	//["ACE_EntrenchingTool",1,"backpack"] call FNC_AddItem;
//};

//////////////////////////////////////
///// PLATOON ROLE ///////////////////
//////////////////////////////////////

case (package + "PL"): {
};

case (package + "SGT"): {
};

case (package + "RTO"): {
};

case (package + "MED"): {
};

//////////////////////////////////////
///// SQUAD ROLE//////////////////////
//////////////////////////////////////

case (package + "SL"): {
};

case (package + "2IC"): {
};

case (package + "RIFLE"): {
};

case (package + "MARKS"): {
};

case (package + "GREN"): {
};

case (package + "AT"): {
};

case (package + "LMG"): {
};

case (package + "MG"): {
};

case (package + "MGASS"): {
};

case (package + "MORT"): {
};

//When you want to add the class/loadout to a unit in-game, go into the editor, place down a unit, double click and place the following into the init field/box
////[this, "PackageNameHere_PL"] call FNC_GearScript;

//You can add and remove groups as you please for more or less role.
