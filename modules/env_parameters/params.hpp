// Params: https://community.bistudio.com/wiki/Arma_3_Mission_Parameters

class TimeOfDay {
	title = "Time";
	texts[] = {"Mission default", "0600", "1200", "1800", "0000", "Early dawn", "Dawn", "Early dusk", "Dusk", "Random"};
	values[] = {-1, 6, 12, 18, 0, -2, -3, -4, -5, -10};
	default = -1;
};

class Weather {
	title = "Weather";
	texts[] = {"Mission default", "Clear", "Cloudy", "Overcast", "Rain", "Storm", "Random"};
	values[] = {-1, 1, 3, 5, 7, 9, -10};
	default = -1;
};

class ace_weather_windSimulation {
    title = "ACE Wind Simulation (must be disabled for parameterised wind)";
    ACE_setting = 1;
    values[] = {-1, 1, 0};
    texts[] = {"Mission/Server Default", "Enabled", "Disabled"};
    default = -1;
};

class Wind {
	title = "Wind";
	texts[] = {"Mission default", "No Wind", "Light Breeze (2 m/s)", "Gentle Breeze (4 m/s)",
	"Fresh Breeze (9 m/s)", "Strong Breeze (12 m/s)", "High Wind (15 m/s)", "Gale (20 m/s)",
	"Storm (26 m/s)", "Violent Storm (30 m/s)"};
	values[] = {-1, 0, 2, 4, 9, 12, 15, 20, 26, 30};
	default = -1;
};

class WindDir {
    title = "Wind Direction (blowing from; only affects parameterised wind)";
    texts[] = {"North (0°)", "North-Northeast (22.5°)", "Northeast (45°)", "East-Northeast (67.5°)", "East (90°)",
		"East-Southeast (112.5°)", "Southeast (135°)", "South-Southeast (157.5°)", "South (180°)",
		"South-Southwest (202.5°)", "Southwest (225°)", "West-Southwest (247.5°)", "West (270°)",
		"West-Northwest (292.5°)", "Northwest (315°)", "North-Northwest (337.5°)"};
    values[] = {0, 22.5, 45, 67.5, 90, 112.5, 135, 157.5, 180, 202.5, 225, 247.5, 270, 292.5, 315, 337.5};
    default = 90;
};

class Fog {
	title = "Fog";
	texts[] = {"Mission default", "No Fog", "Slightly Foggy", "Foggy", "Very Foggy", "Random"};
	values[] = {-1, 0, 1, 2, 3, -10};
	default = -1;
};

class TimeLimit {
	title = "Change time limit";
	texts[] = {"-30 Min", "-15 Min", "No change", "+15 Min", "+30 Min", "No time limit"};
	values[] = {-30, -15, 0, 15, 30, -1};
	default = 0;
};
