["Set Face", "Selects faces from an array and applies them.", "TinfoilHate"] call FNC_RegisterModule;

kobld_fnc_setFace = {
	params ["_unit"];
	
	private _special_unit = kobld_setFace_special select 1;
	private _special_face = kobld_setFace_special select 0;
	
	if (_unit in _special_unit) then {
		private _face = selectRandom _special_face;

		[_unit, _face] remoteExec ["setFace", 0, _unit];
	} else {
		switch (side _unit) do {
			case west: {
				private _face = selectRandom kobld_setFace_west;

				[_unit, _face] remoteExec ["setFace", 0, _unit];
			};

			case east: {
				private _face = selectRandom kobld_setFace_east;

				[_unit, _face] remoteExec ["setFace", 0, _unit];
			};

			case independent: {
				private _face = selectRandom kobld_setFace_guer;

				[_unit, _face] remoteExec ["setFace", 0, _unit];
			};

			default {
				private _face = selectRandom kobld_setFace_civ;

				[_unit, _face] remoteExec ["setFace", 0, _unit];
			};
		};
	};
};