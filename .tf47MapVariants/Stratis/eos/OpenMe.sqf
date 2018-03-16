/* EOS 1.98 by BangaBob 
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20

EXAMPLE CALL - EOS
 null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call EOS_Spawn;
 null=[["M1","M2","M3"],[HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY], [STATIC VEHICLES,PROBABILITY],[HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call EOS_Spawn;

EXAMPLE CALL - BASTION
 null = [["BAS_zone_1"],[3,1],[2,1],[2],[0,0],[0,0,EAST,false,false],[10,2,120,TRUE,TRUE]] call Bastion_Spawn;
 null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS],[LIGHT VEHICLES,SIZE OF CARGO],[ARMOURED VEHICLES],[HELICOPTERS,SIZE OF HELICOPTER CARGO],[FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG],[INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]] call Bastion_Spawn;
*/

private ["_side","_fac1","_fac2"];
_side = _this select 0;
_fac1 = _this select 1;//major
_fac2 = _this select 2;//minor

EOS_Spawn = compile preprocessfilelinenumbers "eos\core\eos_launch.sqf";
Bastion_Spawn=compile preprocessfilelinenumbers "eos\core\b_launch.sqf";
null=[] execVM "eos\core\spawn_fnc.sqf";
if (isServer) then {["updateEOSmkrs","onplayerConnected", {[] execVM "eos\functions\EOS_Markers.sqf";}] call BIS_fnc_addStackedEventHandler;};

VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorOrange";	// Colour for bastion marker
EOS_KILLCOUNTER=false;		// Counts killed units

null = [["m1"],[2,2,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m2"],[2,1,InfPb],[2,2,InfPb],[0,0],[0,0],[0],[1,5],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m3"],[1,2,InfPb],[1,2,InfPb],[1,3],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m4"],[2,1,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m5"],[1,2,InfPb],[2,1,InfPb],[0,0],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m6"],[1,2,InfPb],[2,1,InfPb],[0,0],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m7"],[1,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m8"],[1,1,InfPb],[1,3,InfPb],[0,0],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m9"],[1,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m10"],[2,1,InfPb],[1,2,InfPb],[1,3],[1,MecArmPb],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m11"],[0,0],[2,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m12"],[2,1,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m13"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m14"],[2,1,InfPb],[1,2,InfPb],[1,3],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m15"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m16"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m17"],[1,1,InfPb],[1,3,InfPb],[0,0],[1,MecArmPb],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m18"],[2,2,InfPb],[1,3,InfPb],[0,0],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m19"],[1,2,InfPb],[0,0],[0,0],[0],[0],[1,5],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m20"],[1,1,InfPb],[1,2,InfPb],[1,3],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m21"],[0,0],[2,2,InfPb],[0,0],[2,MecArmPb],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m22"],[2,1,InfPb],[1,3,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m23"],[0,0],[2,2,InfPb],[1,3],[1,MecArmPb],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m24"],[2,1,InfPb],[1,2,InfPb],[1,3],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m25"],[1,2,InfPb],[2,2,InfPb],[0,0],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m26"],[2,1,InfPb],[2,1,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m27"],[2,2,InfPb],[2,1,InfPb],[0,0],[2,MecArmPb],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m28"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m29"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m30"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m31"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m32"],[1,2,InfPb],[1,2,InfPb],[1,3],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m33"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m34"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m35"],[1,1,InfPb],[1,1,InfPb],[0,0],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m36"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m37"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m38"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m39"],[0,0],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m40"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m41"],[2,1,InfPb],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m42"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m43"],[1,2,InfPb],[1,2,InfPb],[0,0],[2,MecArmPb],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m44"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m45"],[2,1,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m46"],[0,0],[1,3,InfPb],[1,3],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m47"],[1,2,InfPb],[1,2,InfPb],[0,0],[2,MecArmPb],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m48"],[2,2,InfPb],[0,0],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m49"],[1,2,InfPb],[1,1,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m50"],[2,2,InfPb],[0,0],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m51"],[2,2,InfPb],[0,0],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m52"],[1,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m53"],[0,0],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m54"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m55"],[1,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m56"],[1,1,InfPb],[2,2,InfPb],[1,3],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m57"],[1,2,InfPb],[0,0],[0,0],[0],[0],[1,5],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m58"],[0,0],[2,1,InfPb],[0,0],[2,MecArmPb],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m59"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m60"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m61"],[0,0],[2,2,InfPb],[1,3],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m62"],[1,1,InfPb],[1,2,InfPb],[1,3],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m63"],[2,1,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m64"],[1,1,InfPb],[1,2,InfPb],[1,3],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m65"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m66"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m67"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m68"],[0,0],[1,3,InfPb],[1,3],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m69"],[0,0],[2,2,InfPb],[1,3],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m70"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m71"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m72"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m73"],[1,2,InfPb],[1,3,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m74"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m75"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m76"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m77"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac2,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m78"],[0,0],[0,0],[1,3],[0],[1],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m79"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac2,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m80"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m81"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac2,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m82"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m83"],[0,0],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m84"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m85"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m86"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m87"],[0,0],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m88"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m89"],[1,2,InfPb],[1,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m90"],[0,0],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m91"],[2,2,InfPb],[0,0],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m92"],[0,0],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m93"],[2,2,InfPb],[0,0],[0,0],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m94"],[0,0],[1,2,InfPb],[1,3],[0],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m95"],[0,0],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m96"],[0,0],[1,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m97"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m98"],[2,2,InfPb],[2,2,InfPb],[0,0],[0],[0],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m99"],[0,0],[2,2,InfPb],[0,0],[2,MecArmPb],[0],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m100"],[0,0],[1,2,InfPb],[0,0],[0,0],[0],[1,3],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m101"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m102"],[0,0],[2,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m103"],[0,0],[2,2,InfPb],[0,0],[0],[1],[0,0],[_fac1,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m104"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m105"],[0,0],[2,2,InfPb],[0,0],[0],[1],[0,0],[_fac2,0,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m106"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m107"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac2,1,AI_SpawnDis,_side,true]] call EOS_Spawn;
null = [["m108"],[0,0],[0,0],[1,3],[0],[0],[0,0],[_fac1,1,AI_SpawnDis,_side,true]] call EOS_Spawn;