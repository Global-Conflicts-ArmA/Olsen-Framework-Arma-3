#include "settings.sqf"

kobld_billboards_textureArray_base = [];
_vanillaPath = "a3\structures_f_argo\Commercial\Billboards\Data\Advertisements\";
_modulePath = "modules\kobld_billboards\images\";

if (kobld_billboards_vanilla) then {
	["aan","action","argois","bluking","carrental","cheese","chernarus","chevre2","chevre","duckit","getlost","ionbase","ion","koke","leader","lyfe","mars2","mars","maskrtnik","monte","olives","pate","pills","plane","redstone","supermarket","surreal","winery","wine","ygont"] apply {
    kobld_billboards_textureArray_base pushBack format ["a3\structures_f_argo\Commercial\Billboards\Data\Advertisements\bill_%1_co.paa", _x];
	};
};

if (kobld_billboards_blank) then {
	kobld_billboards_textureArray_base pushBack "a3\structures_f\civ\infoboards\data\billboard_metal_co.paa";
};

if !(kobld_billboards_textureNames isEqualTo []) then {
	kobld_billboards_textureNames apply {kobld_billboards_textureArray_base pushBack (_modulePath + _x)};
};

kobld_billboards_textureArray = kobld_billboards_textureArray_base;
