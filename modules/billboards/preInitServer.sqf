#include "settings.sqf"

billboards_textureArray_base = [];
/* private _vanillaPath = "a3\structures_f_argo\Commercial\Billboards\Data\Advertisements\"; */
private _modulePath = "modules\billboards\images\";

if (billboards_vanilla) then {
	["aan","action","argois","bluking","carrental","cheese","chernarus","chevre2","chevre","duckit","getlost","ionbase","ion","koke","leader","lyfe","mars2","mars","maskrtnik","monte","olives","pate","pills","plane","redstone","supermarket","surreal","winery","wine","ygont"] apply {
    billboards_textureArray_base pushBack format ["a3\structures_f_argo\Commercial\Billboards\Data\Advertisements\bill_%1_co.paa", _x];
	};
};

if (billboards_blank) then {
	billboards_textureArray_base pushBack "a3\structures_f\civ\infoboards\data\billboard_metal_co.paa";
};

if !(billboards_textureNames isEqualTo []) then {
	billboards_textureNames apply {billboards_textureArray_base pushBack (_modulePath + _x)};
};

billboards_textureArray = billboards_textureArray_base;
