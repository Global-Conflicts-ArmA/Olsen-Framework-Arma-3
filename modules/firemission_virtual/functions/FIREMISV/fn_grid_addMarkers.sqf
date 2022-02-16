#include "script_component.hpp"

params ["_id", "_ready", "_array"];

_array params ["_obs", "_name", "_selectedAmmo", "_selectedGrid", "_selectedMils", "_selectedDist", "_selectedRnds", "_selectedGuns"];

private _side = [_name] call FUNC(array_getBatterySide);

if !(_selectedGrid isEqualType []) then {
	_selectedGrid = [_selectedGrid,_selectedMils,_selectedDist] call FUNC(grid_mapGridToPos);
};

switch (_side) do {
	case west: {
		if (side player == _side) then {
			private _newName = _id + "_" + str(_array # 13);
			if !(_newName in allMapMarkers) then {
				createMarkerLocal [_newName, _selectedGrid];

				_newName setMarkerTypeLocal "mil_destroy";
				_newName setMarkerTextLocal _id;
				_newName setMarkerSizeLocal [0.75, 0.75];
			};
		};
	};
	case east: {
		if (side player == _side) then {
			private _newName = _id + "_" + str(_array # 13);
			if !(_newName in allMapMarkers) then {
				createMarkerLocal [_newName, _selectedGrid];

				_newName setMarkerTypeLocal "mil_destroy";
				_newName setMarkerTextLocal _id;
				_newName setMarkerSizeLocal [0.75,0.75];
			};
		};
	};
	case independent: {
		if (side player == _side) then {
			private _newName = _id + "_" + str(_array # 13);
			if !(_newName in allMapMarkers) then {
				createMarkerLocal [_newName, _selectedGrid];

				_newName setMarkerTypeLocal "mil_destroy";
				_newName setMarkerTextLocal _id;
				_newName setMarkerSizeLocal [0.75, 0.75];
			};
		};
	};
	case civilian: {
		if (side player == _side) then {
			private _newName = _id + "_" + str(_array # 13);
			if !(_newName in allMapMarkers) then {
				createMarkerLocal [_newName, _selectedGrid];

				_newName setMarkerTypeLocal "mil_destroy";
				_newName setMarkerTextLocal _id;
				_newName setMarkerSizeLocal [0.75, 0.75];
			};
		};
	};
};
