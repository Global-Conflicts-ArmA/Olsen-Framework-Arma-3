//This module shares target information between AI groups based on their radios.
//Written by TinfoilHate, ported by StatusRed
//Updated: 25th October, 2021
//
//The script shares target information regarding playableUnits using knowsAbout if GVAR(aiLink_needRadio) is false, or if both units have long or short range radios.


GVAR(aiLink_startDelay) 	= 30;		//Delay in seconds when starting the mission until the first loop runs.
GVAR(aiLink_shareDelay)	= 15;		//Delay in seconds  between loops after the first.
GVAR(aiLink_transDelay)	= 10;		//Delay in seconds, maximum randomized, for target information to be transmitted. No effect if set higher than GVAR(aiLink_shareDelay).

GVAR(aiLink_longRange) 	= 800;		//Range if both groups have long-range radios, also used if GVAR(aiLink_needRadio) is false.
GVAR(aiLink_shortRange) 	= 400;		//Range if both groups have short-range radios.

GVAR(aiLink_needRadio)	= false;	//Controls if both AI groups need radios. If false, it will work regardless of radios. Will also perform somewhat better.
GVAR(aiLink_maxKnows)		= 3.5;		//The maximum amount that knowsAbout will be set to via this script.

GVAR(aiLink_debug) 		= false;	//Debug Information; Very spammy.
