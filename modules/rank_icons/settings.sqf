// Author: StatusRed

// This module allows you set custom rank icons on any unit, side or group.
// Please check the examples below, uncomment and modify them as per your requirements.
// All icon file paths are relative to the mission's folder and need to be in .paa format.
// From testing, if you colour an icon it will just be rendered in black and white regardless.
// --------------------------------------------------------------------------------------------
// NOTE: Icons will be applied in the order you set them in this file, for example
// if you want individual units to have different rank icons but then set a side wide icon
// afterwards, it will overwrite the individual units' icons which were set before.

// Sides example
[opfor, "modules\rank_icons\res\chopper.paa"] call FUNC(addSetting);
/* [blufor, "modules\rank_icons\res\chopper.paa"] call FUNC(addSetting); */

// Multiple groups example
/* private _groups = [testers, others];
_groups apply {
  [_x, "modules\rank_icons\res\chopper.paa"] call FUNC(addSetting);
}; */

// Multiple units example
/* private _units = [leadUnit, test_unit];
_units apply {
  [_x, "modules\rank_icons\res\chopper.paa"] call FUNC(addSetting);
}; */
