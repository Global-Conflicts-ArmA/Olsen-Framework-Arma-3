// This is a fairly simple script that will apply textures to named billboards of class "Land_Billboard_F".
// a3\structures_f\civ\infoboards\data\billboard_metal_co.paa

kobld_billboards = []; //Billboard object names. Can be specified, or left blank for all mission objects of class "Land_Billboard_F"
kobld_billboards_blank = false;	//Chance to be the default blank texture
kobld_billboards_vanilla = true; //Chance to use BIS billboard textures
kobld_billboards_textureNames = ["cherno.jpg","coffee.jpg","waifu.jpg"]; //List of texture filenames in modules\kobld_billboards\images