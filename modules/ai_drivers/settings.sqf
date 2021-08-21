//array containing vehicles that will have option to spawn AI driver in them
#define VEHS []

//use line below to enable the module for all tracked vehicles in the mission
//#define VEHS call {_vehs = []; {if (typeOf _x isKindOf 'YOUR VEHICLE CLASS NAME') then {_vehs pushBack _x};} foreach vehicles; _vehs;}
//#define VEHS call {_vehs = []; {if (typeOf _x isKindOf 'UK3CB_BAF_LandRover_WMIK_HMG_FFR_Green_A') then {_vehs pushBack _x};} foreach vehicles; _vehs;}
