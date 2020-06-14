#include "script_component.hpp"

#ifdef description_XEH_PreInit
	class COMPONENT {
		clientInit = "call compile preprocessFileLineNumbers 'modules\grad-fortifications\preinitClient.sqf'";
	};
#endif

#ifdef description_external_functions
	#include "functions\CfgFunctions.hpp"
#endif

#ifdef description_titles
	#include "dialog\hint\title.hpp"
#endif

#ifdef description
	class CfgGradFortifications {
		#include "cfgGradFortifications.hpp"
	};
	
	#include "dialog\ui_toolkit.hpp"
	#include "dialog\baseDefines.hpp"
	#include "dialog\baseRsc.hpp"
	#include "dialog\menu\defines.hpp"
	#include "dialog\menu\dialog.hpp"
	#include "dialog\vehicle\defines.hpp"
	#include "dialog\vehicle\dialog.hpp"
#endif

#undef COMPONENT