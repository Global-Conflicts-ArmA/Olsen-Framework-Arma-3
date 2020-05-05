#include "..\..\script_macros.hpp"


//Currently not being used
{
		[_x,false,false,false,false] spawn FUNC(MoveToCover);
} foreach (units (group _this));
