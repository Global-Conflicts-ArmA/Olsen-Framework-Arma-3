#ifdef description_XEH_PreInit
	class BILLB {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\billboards\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\billboards\preInitServer.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class BILLB {
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\billboards\init.sqf'";
	};
#endif
