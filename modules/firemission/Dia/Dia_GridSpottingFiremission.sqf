#include "..\..\..\core\script_macros.hpp"
#include "..\functions\FIREMIS\defs.hpp"

FNC_DIA_GridSpottingFiremissionOpenDialog =
{
	createDialog "DIA_GridSpottingFiremission";
	[GSFM_DIA_IDC_GUNSELECT,GSFM_DIA_IDC_SHELLSELECT] call EFUNC(FIREMIS,Dia_ArtLoadAvailableArtilleries);
};

FNC_DIA_GridSpottingFiremissionSetArtillery =
{
	[GSFM_DIA_IDC_SHELLSELECT,_this] call EFUNC(FIREMIS,Dia_ArtSetArtillery);
};

FNC_DIA_GridSpottingFiremissionCloseDialog =
{
	closeDialog GSFM_DIA_IDD_DISPLAY;

};

FNC_DIA_GridSpottingFiremissionFire =
{
	private _guns = player getVariable [VAR_SART_OBSGUNS,[]];
	private _usableGuns = [];
	_guns apply {
		if(_x call EFUNC(FIREMIS,Dia_IsArtyAvailable)) then
		{
			_usableGuns pushBack _x;
		};
	};
	private _selectedUnit = objNull;
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel GSFM_DIA_IDC_GUNSELECT));};
	private _selectedAmmo = lbCurSel GSFM_DIA_IDC_SHELLSELECT;
	private _grid = 	ctrlText GSFM_DIA_IDC_GRID;
	private _pos = [_grid,true] call CBA_fnc_mapGridToPos;
	if(_selectedUnit isEqualTo objNull) then  {hint "No Arty selected/aviable";}
	else
	{
		private _round =  ((_selectedUnit call EFUNC(FIREMIS,Dia_GetArtyAmmo)) select _selectedAmmo) select 0;
		hint (([_selectedUnit,_pos,_selectedAmmo] call EFUNC(FIREMIS,GetGridSpottingFiremissionText))
								+ "Requested by: " + (name player)
								+ "\nETA: " + str (round ((_selectedUnit call EFUNC(FIREMIS,Dia_GetArtyAimTime)) + ([_selectedUnit,_pos,_round] call EFUNC(FIREMIS,Dia_GetArtyEta)))) + " s");
					["CallGridSpottingFiremission", [player,_selectedUnit,_grid,_selectedAmmo]] call CBA_fnc_serverEvent;
		[] call FNC_DIA_GridSpottingFiremissionCloseDialog;

	};



};

FNC_DIA_Server_GridSpottingFiremissionFire =
{
	private _requester  = _this select 0;
	private	_selectedUnit = _this select 1;
	private _grid = _this select 2;
	private _selectedAmmo = _this select 3;

	[_selectedUnit,_requester] call EFUNC(FIREMIS,Dia_SetArtyCaller);
	[_selectedUnit,[_grid,true] call CBA_fnc_mapGridToPos,_selectedAmmo] call EFUNC(FIREMIS,GridSpottingFiremission);

};
if(isServer) then {["CallGridSpottingFiremission", {_this call FNC_DIA_Server_GridSpottingFiremissionFire;}] call CBA_fnc_addEventHandler;};
