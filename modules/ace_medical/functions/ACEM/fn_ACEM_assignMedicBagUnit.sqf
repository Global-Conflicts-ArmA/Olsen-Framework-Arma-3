//Add a backpack and medical items to a unit. Ex: [this,"usm_pack_m5_medic"] call FW_fnc_ACEM_assignMedicBagUnit;
private ["_unit", "_type"];

_unit 	= _this select 0;	//Vehicle to add a medic bag to
_type 	= _this select 1;	//Class of backpack to add

if (local _unit) then {
  _unit addBackpack _type;

  clearAllItemsFromBackpack _unit;

  _x addItemToBackpack ["ACE_salineIV", 5];
  _x addItemToBackpack ["ACE_salineIV_500", 6];

  _x addItemToBackpack ["ACE_adenosine", 10];
  _x addItemToBackpack ["ACE_morphine", 10];
  _x addItemToBackpack ["ACE_epinephrine", 10];

  _x addItemToBackpack ["ACE_quikclot", 16];
  _x addItemToBackpack ["ACE_packingBandage", 16];
  _x addItemToBackpack ["ACE_fieldDressing", 16];
  _x addItemToBackpack ["ACE_elasticBandage", 20];

  _x addItemToBackpack ["ACE_tourniquet", 5];
  _x addItemToBackpack ["ACE_splint", 5];

  _x addItemToBackpack ["ACE_surgicalKit", 1];
};
