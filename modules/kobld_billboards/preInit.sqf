["Billboard Applier", "Applies (random) textures to billboards.", "TinfoilHate"] call FNC_RegisterModule;

#include "settings.sqf"

if (isServer) then {
	kobld_billboards_textureArray_base = [];
	_vanillaPath = "a3\structures_f_argo\Commercial\Billboards\Data\Advertisements\";
	_modulePath = "modules\kobld_billboards\images\";

	if (kobld_billboards_vanilla) then {
		{kobld_billboards_textureArray_base pushBack (_vanillaPath + _x)} forEach ["bill_aan_co.paa","bill_action_co.paa","bill_argois_co.paa","bill_bluking_co.paa","bill_carrental_co.paa","bill_cheese_co.paa","bill_chernarus_co.paa","bill_chevre2_co.paa","bill_chevre_co.paa","bill_duckit_co.paa","bill_getlost_co.paa","bill_ionbase_co.paa","bill_ion_co.paa","bill_koke_co.paa","bill_leader_co.paa","bill_lyfe_co.paa","bill_mars2_co.paa","bill_mars_co.paa","bill_maskrtnik_co.paa","bill_monte_co.paa","bill_olives_co.paa","bill_pate_co.paa","bill_pills_co.paa","bill_plane_co.paa","bill_redstone_co.paa","bill_supermarket_co.paa","bill_surreal_co.paa","bill_winery_co.paa","bill_wine_co.paa","bill_ygont_co.paa"];
	};

	if (kobld_billboards_blank) then {
		kobld_billboards_textureArray_base pushBack "a3\structures_f\civ\infoboards\data\billboard_metal_co.paa";
	};

	if !(kobld_billboards_textureNames isEqualTo []) then {
		{kobld_billboards_textureArray_base pushBack (_modulePath + _x)} forEach kobld_billboards_textureNames;
	};

	kobld_billboards_textureArray = kobld_billboards_textureArray_base;
};
