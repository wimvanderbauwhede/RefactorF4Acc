int dofold = 0;
#define HTSIZE 256
static struct idntbl_state {
	CHAIN h1l0;
	CHAIN h3l1;
	CHAIN h3l0;
	CHAIN h4l0;
	CHAIN h5l0;
	CHAIN h6l1;
	CHAIN h6l0;
	CHAIN h10l0;
	CHAIN h11l1;
	CHAIN h11l0;
	CHAIN h14l0;
	CHAIN h15l0;
	CHAIN h16l0;
	CHAIN h22l1;
	CHAIN h22l0;
	CHAIN h25l1;
	CHAIN h25l0;
	CHAIN h27l0;
	CHAIN h28l1;
	CHAIN h28l0;
	CHAIN h30l0;
	CHAIN h40l0;
	CHAIN h43l0;
	CHAIN h45l2;
	CHAIN h45l1;
	CHAIN h45l0;
	CHAIN h47l2;
	CHAIN h47l1;
	CHAIN h47l0;
	CHAIN h50l1;
	CHAIN h50l0;
	CHAIN h54l0;
	CHAIN h55l1;
	CHAIN h55l0;
	CHAIN h56l0;
	CHAIN h57l0;
	CHAIN h60l0;
	CHAIN h61l0;
	CHAIN h66l1;
	CHAIN h66l0;
	CHAIN h69l1;
	CHAIN h69l0;
	CHAIN h71l0;
	CHAIN h72l1;
	CHAIN h72l0;
	CHAIN h75l0;
	CHAIN h76l0;
	CHAIN h77l0;
	CHAIN h79l0;
	CHAIN h80l0;
	CHAIN h82l0;
	CHAIN h88l0;
	CHAIN h89l0;
	CHAIN h91l0;
	CHAIN h93l0;
	CHAIN h95l0;
	CHAIN h99l0;
	CHAIN h101l0;
	CHAIN h102l1;
	CHAIN h102l0;
	CHAIN h103l0;
	CHAIN h104l0;
	CHAIN h106l1;
	CHAIN h106l0;
	CHAIN h108l0;
	CHAIN h113l0;
	CHAIN h114l0;
	CHAIN h116l1;
	CHAIN h116l0;
	CHAIN h119l1;
	CHAIN h119l0;
	CHAIN h120l2;
	CHAIN h120l1;
	CHAIN h120l0;
	CHAIN h123l0;
	CHAIN h124l0;
	CHAIN h126l0;
	CHAIN h127l0;
	CHAIN h128l1;
	CHAIN h128l0;
	CHAIN h131l0;
	CHAIN h132l1;
	CHAIN h132l0;
	CHAIN h133l0;
	CHAIN h134l1;
	CHAIN h134l0;
	CHAIN h135l1;
	CHAIN h135l0;
	CHAIN h137l2;
	CHAIN h137l1;
	CHAIN h137l0;
	CHAIN h143l0;
	CHAIN h146l1;
	CHAIN h146l0;
	CHAIN h147l0;
	CHAIN h150l1;
	CHAIN h150l0;
	CHAIN h151l0;
	CHAIN h154l1;
	CHAIN h154l0;
	CHAIN h156l3;
	CHAIN h156l2;
	CHAIN h156l1;
	CHAIN h156l0;
	CHAIN h157l1;
	CHAIN h157l0;
	CHAIN h159l1;
	CHAIN h159l0;
	CHAIN h160l2;
	CHAIN h160l1;
	CHAIN h160l0;
	CHAIN h164l0;
	CHAIN h165l0;
	CHAIN h168l0;
	CHAIN h169l0;
	CHAIN h171l0;
	CHAIN h173l1;
	CHAIN h173l0;
	CHAIN h175l2;
	CHAIN h175l1;
	CHAIN h175l0;
	CHAIN h176l0;
	CHAIN h177l0;
	CHAIN h178l1;
	CHAIN h178l0;
	CHAIN h180l0;
	CHAIN h183l2;
	CHAIN h183l1;
	CHAIN h183l0;
	CHAIN h184l1;
	CHAIN h184l0;
	CHAIN h185l0;
	CHAIN h186l0;
	CHAIN h187l1;
	CHAIN h187l0;
	CHAIN h188l0;
	CHAIN h189l0;
	CHAIN h193l1;
	CHAIN h193l0;
	CHAIN h194l1;
	CHAIN h194l0;
	CHAIN h196l0;
	CHAIN h198l2;
	CHAIN h198l1;
	CHAIN h198l0;
	CHAIN h201l0;
	CHAIN h204l0;
	CHAIN h207l0;
	CHAIN h209l0;
	CHAIN h211l1;
	CHAIN h211l0;
	CHAIN h212l0;
	CHAIN h214l0;
	CHAIN h215l1;
	CHAIN h215l0;
	CHAIN h216l0;
	CHAIN h217l0;
	CHAIN h219l0;
	CHAIN h220l0;
	CHAIN h221l0;
	CHAIN h222l0;
	CHAIN h225l0;
	CHAIN h227l2;
	CHAIN h227l1;
	CHAIN h227l0;
	CHAIN h228l0;
	CHAIN h229l0;
	CHAIN h230l0;
	CHAIN h232l0;
	CHAIN h238l0;
	CHAIN h241l0;
	CHAIN h248l2;
	CHAIN h248l1;
	CHAIN h248l0;
	CHAIN h249l1;
	CHAIN h249l0;
	CHAIN h250l0;
	CHAIN h251l0;
	CHAIN h252l0;
	CHAIN h253l1;
	CHAIN h253l0;

	CHAIN *hash[HTSIZE];
} state = {
{NULL,7,83,52},
{NULL,10,173,125},
{&state.h3l1,7,197,149},
{NULL,10,180,132},
{NULL,5,15,10},
{NULL,7,36,17},
{&state.h6l1,5,142,97},
{NULL,5,137,92},
{NULL,5,40,21},
{&state.h11l1,5,63,35},
{NULL,10,122,82},
{NULL,8,186,138},
{NULL,5,121,81},
{NULL,6,161,116},
{&state.h22l1,5,102,67},
{NULL,5,193,145},
{&state.h25l1,5,60,34},
{NULL,5,154,109},
{NULL,10,216,167},
{&state.h28l1,6,58,33},
{NULL,5,200,152},
{NULL,4,209,160},
{NULL,5,231,180},
{NULL,10,11,6},
{&state.h45l2,5,205,156},
{&state.h45l1,4,211,162},
{NULL,10,148,103},
{&state.h47l2,5,43,24},
{&state.h47l1,4,213,164},
{NULL,5,158,113},
{&state.h50l1,4,208,159},
{NULL,8,176,128},
{NULL,4,210,161},
{&state.h55l1,3,14,9},
{NULL,12,65,37},
{NULL,10,167,120},
{NULL,4,212,163},
{NULL,4,199,151},
{NULL,8,134,89},
{&state.h66l1,6,175,127},
{NULL,8,69,41},
{&state.h69l1,6,108,72},
{NULL,15,223,174},
{NULL,6,109,73},
{&state.h72l1,3,33,14},
{NULL,3,229,178},
{NULL,3,35,16},
{NULL,8,7,3},
{NULL,8,25,13},
{NULL,10,151,106},
{NULL,8,155,110},
{NULL,3,45,26},
{NULL,8,206,157},
{NULL,8,170,122},
{NULL,8,195,147},
{NULL,8,117,79},
{NULL,8,78,47},
{NULL,8,118,80},
{NULL,8,81,50},
{&state.h102l1,8,140,95},
{NULL,7,57,32},
{NULL,6,183,135},
{NULL,8,37,18},
{&state.h106l1,6,172,124},
{NULL,8,168,121},
{NULL,6,39,20},
{NULL,4,112,76},
{NULL,11,68,40},
{&state.h116l1,4,187,139},
{NULL,6,41,22},
{&state.h119l1,4,191,143},
{NULL,11,181,133},
{&state.h120l2,6,64,36},
{&state.h120l1,6,132,87},
{NULL,6,221,172},
{NULL,4,97,62},
{NULL,6,34,15},
{NULL,6,67,39},
{NULL,6,149,104},
{&state.h128l1,6,138,93},
{NULL,4,188,140},
{NULL,4,190,142},
{&state.h132l1,4,189,141},
{NULL,6,75,45},
{NULL,6,145,100},
{&state.h134l1,4,98,63},
{NULL,13,152,107},
{&state.h135l1,6,85,54},
{NULL,6,215,166},
{&state.h137l2,6,164,119},
{&state.h137l1,6,103,68},
{NULL,5,71,43},
{NULL,11,162,117},
{&state.h146l1,6,79,48},
{NULL,6,9,5},
{NULL,11,51,30},
{&state.h150l1,6,38,19},
{NULL,9,185,137},
{NULL,11,24,12},
{&state.h154l1,4,87,56},
{NULL,6,8,4},
{&state.h156l3,4,207,158},
{&state.h156l2,4,95,60},
{&state.h156l1,4,93,58},
{NULL,11,141,96},
{&state.h157l1,9,86,55},
{NULL,9,13,8},
{&state.h159l1,6,159,114},
{NULL,11,127,84},
{&state.h160l2,6,214,165},
{&state.h160l1,4,156,111},
{NULL,4,226,177},
{NULL,9,88,57},
{NULL,5,160,115},
{NULL,4,130,85},
{NULL,9,55,31},
{NULL,9,219,170},
{&state.h173l1,5,196,148},
{NULL,7,106,70},
{&state.h175l2,4,131,86},
{&state.h175l1,4,84,53},
{NULL,4,44,25},
{NULL,9,143,98},
{NULL,9,113,77},
{&state.h178l1,4,198,150},
{NULL,4,218,169},
{NULL,9,150,105},
{&state.h183l2,9,139,94},
{&state.h183l1,9,202,153},
{NULL,7,178,130},
{&state.h184l1,7,171,123},
{NULL,4,50,29},
{NULL,4,163,118},
{NULL,7,107,71},
{&state.h187l1,4,104,69},
{NULL,4,203,154},
{NULL,9,146,101},
{NULL,9,82,51},
{&state.h193l1,7,2,1},
{NULL,4,126,83},
{&state.h194l1,4,230,179},
{NULL,9,133,88},
{NULL,9,77,46},
{&state.h198l2,7,177,129},
{&state.h198l1,4,217,168},
{NULL,9,194,146},
{NULL,9,222,173},
{NULL,2,72,44},
{NULL,7,99,64},
{NULL,9,80,49},
{&state.h211l1,2,136,91},
{NULL,7,16,11},
{NULL,2,48,27},
{NULL,7,157,112},
{&state.h215l1,2,42,23},
{NULL,9,204,155},
{NULL,5,179,131},
{NULL,7,225,176},
{NULL,12,135,90},
{NULL,5,110,74},
{NULL,5,174,126},
{NULL,7,100,65},
{NULL,5,114,78},
{&state.h227l2,5,96,61},
{&state.h227l1,2,49,28},
{NULL,7,12,7},
{NULL,7,94,59},
{NULL,12,182,134},
{NULL,12,144,99},
{NULL,7,224,175},
{NULL,5,111,75},
{NULL,7,147,102},
{&state.h248l2,7,220,171},
{&state.h248l1,5,192,144},
{NULL,7,153,108},
{&state.h249l1,5,70,42},
{NULL,5,6,2},
{NULL,7,66,38},
{NULL,7,233,181},
{NULL,7,184,136},
{&state.h253l1,5,101,66},

{
	NULL,
	&state.h1l0,
	NULL,
	&state.h3l0,
	&state.h4l0,
	&state.h5l0,
	&state.h6l0,
	NULL,
	NULL,
	NULL,
	&state.h10l0,
	&state.h11l0,
	NULL,
	NULL,
	&state.h14l0,
	&state.h15l0,
	&state.h16l0,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h22l0,
	NULL,
	NULL,
	&state.h25l0,
	NULL,
	&state.h27l0,
	&state.h28l0,
	NULL,
	&state.h30l0,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h40l0,
	NULL,
	NULL,
	&state.h43l0,
	NULL,
	&state.h45l0,
	NULL,
	&state.h47l0,
	NULL,
	NULL,
	&state.h50l0,
	NULL,
	NULL,
	NULL,
	&state.h54l0,
	&state.h55l0,
	&state.h56l0,
	&state.h57l0,
	NULL,
	NULL,
	&state.h60l0,
	&state.h61l0,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h66l0,
	NULL,
	NULL,
	&state.h69l0,
	NULL,
	&state.h71l0,
	&state.h72l0,
	NULL,
	NULL,
	&state.h75l0,
	&state.h76l0,
	&state.h77l0,
	NULL,
	&state.h79l0,
	&state.h80l0,
	NULL,
	&state.h82l0,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h88l0,
	&state.h89l0,
	NULL,
	&state.h91l0,
	NULL,
	&state.h93l0,
	NULL,
	&state.h95l0,
	NULL,
	NULL,
	NULL,
	&state.h99l0,
	NULL,
	&state.h101l0,
	&state.h102l0,
	&state.h103l0,
	&state.h104l0,
	NULL,
	&state.h106l0,
	NULL,
	&state.h108l0,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h113l0,
	&state.h114l0,
	NULL,
	&state.h116l0,
	NULL,
	NULL,
	&state.h119l0,
	&state.h120l0,
	NULL,
	NULL,
	&state.h123l0,
	&state.h124l0,
	NULL,
	&state.h126l0,
	&state.h127l0,
	&state.h128l0,
	NULL,
	NULL,
	&state.h131l0,
	&state.h132l0,
	&state.h133l0,
	&state.h134l0,
	&state.h135l0,
	NULL,
	&state.h137l0,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h143l0,
	NULL,
	NULL,
	&state.h146l0,
	&state.h147l0,
	NULL,
	NULL,
	&state.h150l0,
	&state.h151l0,
	NULL,
	NULL,
	&state.h154l0,
	NULL,
	&state.h156l0,
	&state.h157l0,
	NULL,
	&state.h159l0,
	&state.h160l0,
	NULL,
	NULL,
	NULL,
	&state.h164l0,
	&state.h165l0,
	NULL,
	NULL,
	&state.h168l0,
	&state.h169l0,
	NULL,
	&state.h171l0,
	NULL,
	&state.h173l0,
	NULL,
	&state.h175l0,
	&state.h176l0,
	&state.h177l0,
	&state.h178l0,
	NULL,
	&state.h180l0,
	NULL,
	NULL,
	&state.h183l0,
	&state.h184l0,
	&state.h185l0,
	&state.h186l0,
	&state.h187l0,
	&state.h188l0,
	&state.h189l0,
	NULL,
	NULL,
	NULL,
	&state.h193l0,
	&state.h194l0,
	NULL,
	&state.h196l0,
	NULL,
	&state.h198l0,
	NULL,
	NULL,
	&state.h201l0,
	NULL,
	NULL,
	&state.h204l0,
	NULL,
	NULL,
	&state.h207l0,
	NULL,
	&state.h209l0,
	NULL,
	&state.h211l0,
	&state.h212l0,
	NULL,
	&state.h214l0,
	&state.h215l0,
	&state.h216l0,
	&state.h217l0,
	NULL,
	&state.h219l0,
	&state.h220l0,
	&state.h221l0,
	&state.h222l0,
	NULL,
	NULL,
	&state.h225l0,
	NULL,
	&state.h227l0,
	&state.h228l0,
	&state.h229l0,
	&state.h230l0,
	NULL,
	&state.h232l0,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h238l0,
	NULL,
	NULL,
	&state.h241l0,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	&state.h248l0,
	&state.h249l0,
	&state.h250l0,
	&state.h251l0,
	&state.h252l0,
	&state.h253l0,
	NULL,
	NULL}};

