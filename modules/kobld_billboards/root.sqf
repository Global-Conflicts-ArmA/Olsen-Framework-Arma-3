#ifdef description_XEH_PreInit
	class KOBLD_BILLB {
		clientInit = "'' call compile preprocessFileLineNumbers 'modules\kobld_billboards\preInitClient.sqf'";
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\kobld_billboards\preInitServer.sqf'";
	};
#endif

#ifdef description_XEH_PostInit
	class KOBLD_BILLB {
		serverInit = "'' call compile preprocessFileLineNumbers 'modules\kobld_billboards\init.sqf'";
	};
#endif
