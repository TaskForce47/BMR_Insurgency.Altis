INS_intro = {
	// Bluefor Intro by Jigsor
	disableSerialization;
	showCinemaBorder false;
	enableRadio false;
	setViewDistance 1100;
	if (daytime > 19.00 || daytime < 5.00) then {camUseNVG true};
	_text = [  [format["%1", name player],"color='#F73105'"], ["", "<br/>"], ["Welcome to", "color='#F73105'"], ["", "<br/>"],  [format["BMR Insurgency %1", toUpper (worldName)], "color='#0059B0' font='PuristaBold'"] ];
	_randomtrack = floor(random 4);
	switch (_randomtrack) do {
		case 0 : {0 = [] spawn { playMusic ["LeadTrack05_F", 1]; sleep 33; playMusic ""; };};
		case 1 : {0 = [] spawn { playMusic ["AmbientTrack01a_F", 32]; sleep 33; playMusic ""; };};
		case 2 : {0 = [] spawn { playMusic ["LeadTrack01_F_Bootcamp", 36]; sleep 32.9; playMusic ""; };};
		case 3 : {0 = [] spawn { playMusic ["Track06_CarnHeli", 1]; sleep 33; playMusic ""; };};
	};
	_cam = "camera" camCreate [(position camstart select 0) - 5, (position camstart select 1) + 5, (position camstart select 2) + 80];
	_cam camPreload 5;
	_cam camSetTarget player;
	waitUntil {preloadCamera [(position camstart select 0) - 5, (position camstart select 1) + 5, (position camstart select 2) + 80];};
	_cam cameraEffect ["internal", "BACK"];
	["BIS_ScreenSetup",true] call BIS_fnc_blackIn;
	_camPos = [(getPos INS_flag select 0) - 1, (getPos INS_flag select 1) + 1, (getTerrainHeightASL (position INS_flag)) + 20];
	_cam camSetPos [(_camPos select 0) - 120, (_camPos select 1) + 100, _camPos select 2];
	_cam camCommit 25;
	sleep 10;
	("BMR_Layer" call BIS_fnc_rscLayer) cutRsc ["bmr_intro", "PLAIN"];
	[_text, safezoneX - 0.01, safeZoneY + (1 - 0.125) * safeZoneH, true, "<t align='right' size='1.0' font='PuristaLight'>%1</t>"] spawn BIS_fnc_typeText2;
	sleep 7;
	waitUntil {camcommitted _cam};
	//[] spawn {[jig_anode,2] call fnc_lightningStrike;};
	_cam camSetPos [position player select 0, position player select 1, 2.2];
	_cam camCommit 3;
	player sideChat localize "STR_BMR_initialize_done";
	//player sideChat localize "STR_BMR_intro_tip1";
	//player sideChat localize "STR_BMR_intro_tip2";
	waitUntil {camcommitted _cam};
	player cameraEffect ["terminate","back"];
	setViewDistance -1;
	camDestroy _cam;
	enableRadio true;
	if (INS_environment isEqualTo 0) then {enableEnvironment false;};
	if (INS_mod_missing) then {[] spawn INS_missing_mods;};
};
INS_intro_op4 = {
	// Opfor Intro by Jigsor
	disableSerialization;
	showCinemaBorder false;
	enableRadio false;
	setViewDistance 1800;
	if (daytime > 19.00 || daytime < 5.00) then {camUseNVG true};
	_text = [  [format["%1", name player],"color='#F73105'"], ["", "<br/>"], ["Welcome to", "color='#F73105'"], ["", "<br/>"],  [format["BMR Insurgency %1", toUpper (worldName)], "color='#0059B0' font='PuristaBold'"] ];
	_randomtrack = floor(random 4);
	switch (_randomtrack) do {
		case 0 : {0 = [] spawn { playMusic ["LeadTrack05_F", 1]; sleep 33; playMusic ""; };};
		case 1 : {0 = [] spawn { playMusic ["AmbientTrack01a_F", 32]; sleep 33; playMusic ""; };};
		case 2 : {0 = [] spawn { playMusic ["LeadTrack01_F_Bootcamp", 36]; sleep 32.9; playMusic ""; };};
		case 3 : {0 = [] spawn { playMusic ["Track06_CarnHeli", 1]; sleep 33; playMusic ""; };};
	};
	_centPos = getPosATL center;
	_offsetPos = [_centPos select 0, _centPos select 1, (_centPos select 2) + 300];
	_cam = "camera" camCreate [(position center select 0) + 240, (position center select 1) + 100, 450];
	_cam camPreload 5;
	_cam camSetTarget _offsetPos;
	waitUntil {preloadCamera [(position center select 0) + 240, (position center select 1) + 100, 450];};
	_cam cameraEffect ["internal", "BACK"];
	["BIS_ScreenSetup",true] call BIS_fnc_blackIn;
	_cam camSetPos [(position center select 0) - 240, (position center select 1) + 100, 450];
	_cam camCommit 15;
	sleep 5;
	("BMR_Layer" call BIS_fnc_rscLayer) cutRsc ["bmr_intro", "PLAIN"];
	[_text, safezoneX - 0.01, safeZoneY + (1 - 0.125) * safeZoneH, true, "<t align='right' size='1.0' font='PuristaLight'>%1</t>"] spawn BIS_fnc_typeText2;
	UIsleep 2;
	waitUntil {camcommitted _cam};
	player cameraEffect ["terminate","back"];
	UIsleep 0.5;
	player sideChat localize "STR_BMR_initialize_done";
	//player sideChat localize "STR_BMR_intro_tip1";
	//player sideChat localize "STR_BMR_intro_tip2";
	setViewDistance -1;
	camDestroy _cam;
	enableRadio true;
	if (INS_environment isEqualTo 0) then {enableEnvironment false;};
	if (INS_mod_missing) then {[] spawn INS_missing_mods;}
};
fnc_lightningStrike = {
	// lightning strike on intro
	private ["_delay","_bolt","_light","_class","_sel","_types","_lightning"];
	_target = _this select 0;
	_delay = _this select 1;

	sleep _delay;
	_pos = getPos _target;
	_bolt = createvehicle ["LightningBolt",_pos,[],0,"can collide"];
	_bolt setpos _pos;
	_bolt setdamage 1;

	_light = "#lightpoint" createvehiclelocal _pos;
	_light setpos [_pos select 0,_pos select 1,(_pos select 2) + 10];
	_light setLightDayLight true;
	_light setLightBrightness 300;
	_light setLightAmbient [0.05, 0.05, 0.1];
	_light setlightcolor [1, 1, 2];

	sleep 0.1;
	_light setLightBrightness 0;
	sleep (random 0.1);

	_types = ["lightning1_F","lightning2_F"];
	_sel = floor (random count _types);
	_class = _types select _sel;
	_lightning = _class createvehiclelocal [100,100,100];
	_lightning setdir (random 360);
	_lightning setpos _pos;

	for "_i" from 0 to 1 do {
		_light setLightBrightness (100 + random 100);
	};

	deleteVehicle _lightning;
	deleteVehicle _light;
	//_target setDamage 1;
};
JIG_placeSandbag_fnc = {
	// Player action place sandbag barrier. by Jigsor
	private ["_player","_dist","_zfactor","_zvector","_isWater","_height"];
	_player = _this select 1;

	if(vehicle _player != player) exitWith {hintSilent localize "STR_BMR_Sandbag_restrict"};
	_isWater = surfaceIsWater position _player;
	if (_isWater) exitWith {hintSilent localize "STR_BMR_Sandbag_restrict"};

	_lift = 0.2;
	_dist = 2;
	_zfactor = 1;
	_zvector = ((_player weaponDirection (primaryWeapon _player)) select 2) * 3;

	if (not (isNull MedicSandBag)) then {deleteVehicle MedicSandBag;};
	MedicSandBag = createVehicle ["Land_BagFence_Round_F",[(getposATL _player select 0) + (sin(getdir _player) * _dist), (getposATL _player select 1) + (cos(getdir _player) * _dist)], [], 0, "CAN_COLLIDE"];

	MedicSandBag setposATL [(getposATL _player select 0) + (sin(getdir _player) * _dist), (getposATL _player select 1) + (cos(getdir _player) * _dist), (getposATL _player select 2) + _zvector + _zfactor];
	MedicSandBag setDir getDir (_this select 1) - 180;

	if ((getPosATL MedicSandBag select 2) > (getPosATL _player select 2)) then {
		MedicSandBag setPos [(getPosATL MedicSandBag select 0), (getPosATL MedicSandBag select 1), (getPosATL _player select 2)];
		MedicSandBag setVectorUp [0,0,1];
	}else{
		while {((position MedicSandBag select 2) + 0.2) < (getPosATL _player select 2)} do {
			MedicSandBag setPos [(getPosATL MedicSandBag select 0), (getPosATL MedicSandBag select 1), ((getPosATL MedicSandBag select 2) + _lift)];
			MedicSandBag setVectorUp [0,0,1];
			_lift = _lift + 0.1;
		};
	};

	(_this select 1) removeAction (_this select 2);
	_id = MedicSandBag addAction [(localize "STR_BMT_remove_sandbag"), {call JIG_removeSandbag_fnc}];
};
JIG_removeSandbag_fnc = {
	// Player action remove sandbag barrier. by Jigsor
	deleteVehicle (_this select 0);
	_id = (_this select 1) addAction [(localize "STR_BMR_place_sandbag"), {call JIG_placeSandbag_fnc}, 0, -9, false];
};
JIG_UGVdrop_fnc = {
	// Player action UGV para drop. by Jigsor
	private "_player";
	_player = _this select 1;
	/*// Require UAV backpack
	if (!(backpack _player isKindof "B_UAV_01_backpack_F")) exitWith {hint "You cannot call UGV without UAV backpack"; (_this select 1) removeAction (_this select 2); _id = _player addAction ["UGV Air Drop", {call JIG_UGVdrop_fnc}, 0, -9, false];};
	if (backpack _player isKindof "B_UAV_01_backpack_F") then {hint "";};
	*/
	if !({_x find "_UavTerminal" != -1} count assignedItems _player > 0) then {
		if ({_x in ["ItemGPS"]} count assignedItems _player > 0) then {_player unlinkItem "ItemGPS";};
		if ({_x in ["O_UavTerminal"]} count assignedItems _player > 0) then {_player unlinkItem "O_UavTerminal";};
		if ({_x in ["I_UavTerminal"]} count assignedItems _player > 0) then {_player unlinkItem "I_UavTerminal";};
		_player linkItem "B_UAVTerminal";
	}else{
		_player unlinkItem "B_UAVTerminal";
		_player linkItem "B_UAVTerminal";
	};
	ghst_ugvsupport = [(getMarkerPos "ugv_spawn"),"B_UGV_01_rcws_F",3,30] execVM "scripts\ghst_ugvsupport.sqf";
	true
};
X_fnc_returnConfigEntry = {
	/*	File: returnConfigEntry.sqf
		Author: Joris-Jan van 't Land
		Description:
		Explores parent classes in the run-time config for the value of a config entry.
		Parameter(s):
		_this select 0: starting config class (Config)
		_this select 1: queried entry name (String)
		Returns:
		Number / String - value of the found entry
	*/
	if ((count _this) < 2) exitWith {nil};
	private ["_config", "_entryName"];
	_config = _this select 0;
	_entryName = _this select 1;
	if ((typeName _config) != (typeName configFile)) exitWith {nil};
	if ((typeName _entryName) != (typeName "")) exitWith {nil};
	private ["_entry", "_value"];
	_entry = _config >> _entryName;
	if (((configName (_config >> _entryName)) isEqualTo "") && (!((configName _config) in ["CfgVehicles", "CfgWeapons", ""]))) then {
		[inheritsFrom _config, _entryName] call X_fnc_returnConfigEntry;
	}else{
		if (isNumber _entry) then {
			_value = getNumber _entry;
		}else{
			if (isText _entry) then {_value = getText _entry};
		};
	};
	if (isNil "_value") exitWith {nil};
	_value
};
X_fnc_returnVehicleTurrets = {
	/*	File: fn_returnVehicleTurrets.sqf
		Author: Joris-Jan van 't Land
		Description:
		Function return the path to all turrets and sub-turrets in a vehicle.
		Parameter(s):
		_this select 0: vehicle config entry (Config)
		Returns:
		Array of Scalars and Arrays - path to all turrets
	*/
	if ((count _this) < 1) exitWith {[]};
	private ["_entry"];
	_entry = _this select 0;
	if ((typeName _entry) != (typeName configFile)) exitWith {[]};
	private ["_turrets", "_turretIndex"];
	_turrets = [];
	_turretIndex = 0;
	for "_i" from 0 to ((count _entry) - 1) do {
		private ["_subEntry"];
		_subEntry = _entry select _i;
		if (isClass _subEntry) then {
			private ["_hasGunner"];
			_hasGunner = [_subEntry, "hasGunner"] call X_fnc_returnConfigEntry;
			if (!(isNil "_hasGunner")) then {
				if (_hasGunner isEqualTo 1) then {
					_turrets set [count _turrets, _turretIndex];
					if (isClass (_subEntry >> "Turrets")) then {
						_turrets set [count _turrets, [_subEntry >> "Turrets"] call X_fnc_returnVehicleTurrets];
					}else{
						_turrets set [count _turrets, []];
					};
				};
			};
			_turretIndex = _turretIndex + 1;
		};
	};
	_turrets
};
INS_maintenance_veh = {
	// code by Xeno
	private ["_config","_count","_i","_magazines","_object","_type","_type_name"];

	_object = (nearestObjects [position player, ["LandVehicle","Air"], 10]) select 0;
	if (!alive _object) exitWith {hint localize "STR_BMR_Vehicle_destroyed";};
	_type = typeof _object;
	hint format ["%1 under maintenance",typeof _object];
	_reload_time = 2;

	_object action ["engineOff", _object];
	if (!alive _object) exitWith {};
	_object setFuel 0;
	_object setVehicleAmmo 1;

	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

	if (count _magazines > 0) then {
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_object removeMagazines _x;
				_removed set [count _removed, _x];
			};
		} forEach _magazines;
		{
			sleep _reload_time;
			if (!alive _object) exitWith {};
			_object addMagazine _x;
		} forEach _magazines;
	};

	_turrets = [configFile >> "CfgVehicles" >> _type >> "Turrets"] call X_fnc_returnVehicleTurrets;

	_reloadTurrets = {
		private ["_turrets", "_path"];
		_turrets = _this select 0;
		_path = _this select 1;

		private ["_i"];
		_i = 0;
		while {_i < (count _turrets)} do {
			private ["_turretIndex", "_thisTurret"];
			_turretIndex = _turrets select _i;
			_thisTurret = _path + [_turretIndex];

			_magazines = _object magazinesTurret _thisTurret;
			if (!alive _object) exitWith {};
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_object removeMagazinesTurret [_x, _thisTurret];
					_removed set [count _removed, _x];
				};
			} forEach _magazines;
			if (!alive _object) exitWith {};
			{
				sleep _reload_time;
				if (!alive _object) exitWith {};
				_object addMagazineTurret [_x, _thisTurret];
				sleep _reload_time;
				if (!alive _object) exitWith {};
			} forEach _magazines;

			if (!alive _object) exitWith {};

			[_turrets select (_i + 1), _thisTurret] call _reloadTurrets;
			_i = _i + 2;
			if (!alive _object) exitWith {};
		};
	};

	if (count _turrets > 0) then {
		[_turrets, []] call _reloadTurrets;
	};

	if (!alive _object) exitWith {};

	_object setVehicleAmmo 1;

	sleep _reload_time;
	if (!alive _object) exitWith {};
	_object setDamage 0;
	sleep _reload_time;
	if (!alive _object) exitWith {};
	while {fuel _object < 0.99} do {
		_object setFuel 1;
		sleep 0.01;
	};
	sleep _reload_time;
	if (!alive _object) exitWith {};

	reload _object;
	if (typeOf _object in INS_add_Chaff) then {_object addweapon "CMFlareLauncher"; _object addmagazine "120Rnd_CMFlare_Chaff_Magazine";};
	hintSilent localize "STR_BMR_Maint_done";
};
BTC_repair_wreck = {
	_object = (nearestObjects [position player, ["LandVehicle","Air"], 10]) select 0;
	if (damage _object != 1) exitWith {hintSilent localize "STR_BMR_useMaint_action"};
	BTC_to_server = [0,_object];publicVariableServer "BTC_to_server";
};
INS_Flip_Veh = {
	// Flip vehicle by Jigsor.
	_target = _this select 0;
	_caller = _this select 1;
	if (vehicle _caller != player) exitWith {hintSilent localize "STR_BMR_flip_restrict";};
	_veh = (nearestObjects [_target, ["LandVehicle"], 15]) select 0;
	if (!isNil "_veh") then {
		if ((damage _veh < 1) && {(count crew _veh isEqualTo 0)}) then {
			_veh setOwner (owner _caller);
			_veh setpos [getpos _veh select 0, getpos _veh select 1, 0];
		};
	};
	true
};
JIG_load_VA_profile = {
	// Force load of saved Virtual Aresenal preset regardless if mod used to make loadout is currently not activated minus missing content by Jigsor.
	if (!isNil {profileNamespace getVariable "bis_fnc_saveInventory_data"}) then {
		private ["_name_index","_VA_Loadouts_Count"];
		_VA_Loadouts_Count = count (profileNamespace getVariable "bis_fnc_saveInventory_data");
		_name_index = 0;
		for "_i" from 0 to (_VA_Loadouts_Count/2) -1 do	{
			[_i,_name_index] spawn {
				private ["_name_index","_loadout_name"];
				_name_index = _this select 1;
				_loadout_name = profileNamespace getVariable "bis_fnc_saveInventory_data" select _name_index;
				_id = INS_Wep_box addAction	[("<t size='1.5' shadow='2' color=""#00ffe9"">") + ("Load " + format ["%1",_loadout_name]),[[player,[profileNamespace, format ["%1", _loadout_name]]],BIS_fnc_loadInventory],8,true,true,"","true"];
				sleep 15;
				INS_Wep_box removeAction _id;
			};
			_name_index = _name_index + 2;
		};
	};
};
JIG_p_actions_resp = {
	// Add player actions. by Jigsor
	waitUntil {sleep 1; alive player};
	private "_playertype";
	_playertype = typeOf (vehicle player);
	// Engineer
	if (_playertype in INS_W_PlayerEng) then {player addAction[("<t color=""#12F905"">") + (localize "STR_BMR_cunstruct_farp") + "</t>","scripts\repair_special.sqf",0,1, false, true,"test2"];};
	// JTAC
	if (_playertype in INS_W_PlayerJTAC) then {null = [player, 500, true, 3] execVM "JWC_CASFS\addAction.sqf";};
	// Medic
	if (_playertype in INS_W_PlayerMedic) then	{MedicSandBag = ObjNull; _id = player addAction[(localize "STR_BMR_place_sandbag"),{call JIG_placeSandbag_fnc}, 0, -9, false];};
	// UAV Operator
	if (_playertype in INS_W_PlayerUAVop) then {
		myhuntiraction = player addAction["use HuntIR","scripts\myhuntir.sqf", [], 1, false, true, "", "true"]; lck_markercnt=0;
		_id = player addAction[(localize "STR_BMR_ugv_air_drop"),{call JIG_UGVdrop_fnc}, 0, -9, false];
	};
	// Sniper/Marksman/Spotter
	if (_playertype in INS_W_PlayerSniper) then	{
		player RemoveAllEventHandlers "Fired";
		_id = player addAction [(localize "STR_BMR_bullet_cam_on"),{call INS_bullet_cam}, 0, -9, false];
	};
	// All players mission settings
	if (Fatigue_ability < 1) then {[player] spawn INS_full_stamina;};
	true
};
PVPscene_POV = {
	// Limit 3rd person view to vehicles only
	[(_this select 0)] spawn {
		while {alive (_this select 0)} do {
			if (cameraView == "External") then {
				if (player isEqualTo vehicle player) then {player switchCamera "Internal";};
			};
			sleep 0.1;
		};
	};
};
JIG_transfer_fnc = {
	// teleport by Jigsor
	_dest = (_this select 3) select 0;
	_dir = random 359;

	titleText ["", "BLACK OUT"];
	switch (typeName _dest) do {
		case "ARRAY" : {player setPos [(position _dest select 0)-10*sin(_dir),(position _dest select 1)-10*cos(_dir)];};
		case "OBJECT" : {player setPos [(getPosATL _dest select 0)-10*sin(_dir),(getPosATL _dest select 1)-10*cos(_dir)];};
		case "STRING" : {player setPos [(getMarkerPos _dest select 0)-10*sin(_dir),(getMarkerPos _dest select 1)-10*cos(_dir)];};
	};
	titleText ["", "BLACK IN",2];
	true
};
killedInfo_fnc = {
/*
	// Generates killed by whom, weapon used and distance from killer message. by Jigsor
	_poorSoul = _this select 0;
	_killer = _this select 1;

	[_poorSoul,_killer] spawn {
		_poorSoul = _this select 0;
		_killer = _this select 1;
		if (!isNull _killer) then {
			_killerName = name _killer;
			_killerWeapon = currentWeapon _killer;
			_distance = _poorSoul distance _killer;
			_killerWeaponName = getText (configFile >> "CfgWeapons" >> _killerWeapon >> "displayName");
			if (_killerWeaponName == "Throw") then {_killerWeaponName = "Grenade"};
			if (_killerWeaponName == "Put") then {_killerWeaponName = "Explosive"};
			if (_killerName == "Error: No unit") then {_killerName = "Unidentified"};
			uiSleep 7;
			_text = format ["Killed by %1, from %2 meters, with %3",_killerName, str(_distance), str(_killerWeaponName)];
			copyToClipboard str(_text);
			if (!isServer) then {
				("BMR_KilledInfo_Layer" call BIS_fnc_rscLayer) cutText [_text,"PLAIN"];
			}else{
				cutText [_text,"PLAIN"];
			};
		};
	};
*/
};

JIG_intel_found = {
	// Remove intel addaction, grab intel animation, delete intel object, creates intel maker, update JIP intel marker state, global sidechat player name found intel, add 2 points to caller by Jigsor
	_host = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_pos_info = _this select 3;
	_callerName = name _caller;
	_text = format [localize "STR_BMR_found_intel",_callerName];

	_host removeAction _id;

	_caller playaction "putdown";
	for "_i" from 0 to 1 do {
		_state = animationState _caller;
		waitUntil {_state != animationState _caller};
	};

	deleteVehicle _host;
	sleep 0.1;
	[[_text],"JIG_MPsideChatWest_fnc"] call BIS_fnc_mp;

	_distance = [50,1500] call BIS_fnc_randomInt; // Minimum intel marker range 10m. Maximum intel marker range 400m.
	_direction = [0,359] call BIS_fnc_randomInt; // Random direction between 0 and 359 degrees.
	_randomPos = [_pos_info, _distance, _direction] call BIS_fnc_relPos; // The position at the random distance and random direction from current_cache_pos.

	_rnum = str(round (random 999));
	_dis_str = str(_distance);
	_VarName = ("intel_mkr" + _rnum);
	_mkr_txt = (_dis_str + " meters");
	_pScore = 2;

	_intel_mkr = createMarker [_VarName, _randomPos];
	_intel_mkr setMarkerShape "ELLIPSE";
	_intel_mkr setMarkerSize [1, 1];
	_intel_mkr setMarkerShape "ICON";
	_intel_mkr setMarkerType "hd_unknown";
	_intel_mkr setMarkerText _mkr_txt;
	sleep 0.1;

	all_intel_mkrs pushBack _intel_mkr;
	[all_intel_mkrs] call JIPmkr_updateServer_fnc;
	publicVariable "all_intel_mkrs";
	sleep 0.1;
	/*
	if (side _caller == INS_Blu_side) then {
		_caller addrating 200;
		_caller addScore _pScore;
		paddscore = [_caller, _pscore];
		publicVariableServer "paddscore";
		[West,"HQ"] sideChat "+2 points";
	};
	*/
	true
};
Op4_spawn_pos = {
	// Initial Op4 spawn position by Jigsor
	private ["_op4_player","_posnotfound","_random_w_player","_basePos","_missionPlayers","_movelogic","_blufor_speed","_playerPos","_cooX","_cooY","_wheX","_wheY","_Op4RandomPos","_counter","_spawnPos","_centerPos","_dis","_dir"];
	//disableSerialization;
	_op4_player = _this select 0;
	_posnotfound = false;
	_random_w_player = nil;
	_basePos = getMarkerPos "Respawn_West";
	_missionPlayers = playableUnits;
	if (INS_p_rev > 5) then {_movelogic = false;}else{_movelogic = true;};

	titleCut["", "BLACK out",2];

	_missionPlayers = _missionPlayers - [_op4_player];// exclude player calling the script
	if (count _missionPlayers > 0) then	{
		{
			_blufor_speed = speed _x;
			_pos = (getPos _x);
			if ((_blufor_speed > 8) || (_pos select 2 > 4) || {(side _x == east)}) then {_missionPlayers = _missionPlayers - [_x];};
		} foreach _missionPlayers;// exclude east players, players in moving vehicles, above ground players such as players in aircraft or in high structures
	}else{
		_posnotfound = true;
	};

	if (count _missionPlayers > 0) then	{
		_random_w_player = _missionPlayers select (floor (random (count _missionPlayers)));
		_missionPlayers = _missionPlayers - ["_random_w_player"];
		while {!isNil "_random_w_player" && {_random_w_player distance _basePos < 500}} do {
			_random_w_player = _missionPlayers select (floor (random (count _missionPlayers)));
			_missionPlayers = _missionPlayers - ["_random_w_player"];
		};
	};// exclude players to close to blufor base

	if (!isNil "_random_w_player") then	{
		// Move Op4 Base within 250 to 500 meters of blufor player
		_playerPos = getPos _random_w_player;
		_cooX = _playerPos select 0;
		_cooY = _playerPos select 1;
		_wheX = [250,500] call BIS_fnc_randomInt;
		_wheY = [250,500] call BIS_fnc_randomInt;
		_Op4RandomPos = [_cooX+_wheX,_cooY+_wheY,0];
		_counter = 0;
		_spawnPos = _Op4RandomPos isFlatEmpty [8,384,0.5,2,0,false,ObjNull];

		while {(count _spawnPos) < 1} do {
			_spawnPos = _Op4RandomPos isFlatEmpty [5,384,0.9,2,0,false,ObjNull];
			_counter = _counter + 1;
			if (_counter > 5) exitWith {_posnotfound = true;};
			sleep 0.2;
		};
		if (count _spawnPos > 0) exitWith {
			if (_movelogic) then {BTC_r_base_spawn setPos _spawnPos;};
			"Respawn_East" setMarkerPos _spawnPos;
			_op4_player setPos _spawnPos;
			titleCut["", "BLACK IN",1];
		};
	}else{
		_posnotfound = true;
	};

	if (_posnotfound) then {
		if ((INS_MHQ_enabled) && {(!isNil "Opfor_MHQ")}) then {
			// Move to Op4 MHQ
			if (_movelogic) then {BTC_r_base_spawn setPos getMarkerPos "Opfor_MHQ";};
			"Respawn_East" setMarkerPos getMarkerPos "Opfor_MHQ";
			_dir = random 359;
			_op4_player setPos [(getMarkerPos "Opfor_MHQ" select 0)-10*sin(_dir),(getMarkerPos "Opfor_MHQ" select 1)-10*cos(_dir)];
			titleCut["", "BLACK IN",1];
		}else{
			// Move Op4 Base to center
			_centerPos = getPosATL center;
			_cooX = _centerPos select 0;
			_cooY = _centerPos select 1;
			_dis = 400;
			_wheX = random (_dis*2)-_dis;
			_wheY = random (_dis*2)-_dis;
			_Op4RandomPos = [_cooX+_wheX,_cooY+_wheY,0];
			_spawnPos = _Op4RandomPos isFlatEmpty [10,384,0.5,2,0,false,ObjNull];

			while {(count _spawnPos) < 1} do {
				_spawnPos = _Op4RandomPos isFlatEmpty [5,384,0.9,2,0,false,ObjNull];
				sleep 0.2;
			};
			if (_movelogic) then {BTC_r_base_spawn setPos _spawnPos;};
			"Respawn_East" setMarkerPos _spawnPos;
			_op4_player setPos _spawnPos;
			titleCut["", "BLACK IN",1];
		};
	};
	true
};
INS_bullet_cam = {
	// add bullet cam
	//http://killzonekid.com/arma-scripting-tutorials-a-simple-bullet-cam/
	player addEventHandler ["Fired", {
		_null = _this spawn {
			_missile = _this select 6;
			_cam = "camera" camCreate (position player);
			_cam cameraEffect ["External", "Back"];
			waitUntil {
				if (isNull _missile) exitWith {true};
				_cam camSetTarget _missile;
				_cam camSetRelPos [0,-3,0];
				_cam camCommit 0;
			};
			sleep 0.4;
			_cam cameraEffect ["Terminate", "Back"];
			camDestroy _cam;
		};
	}];
	(_this select 1) removeAction (_this select 2);
	_id = (_this select 1) addAction[(localize "STR_BMR_bullet_cam_off"),{call JIG_removeBulletCam_fnc}, 0, -9, false];
};
JIG_removeBulletCam_fnc = {
	// remove bullet cam
	(_this select 1) removeAction (_this select 2);
	(_this select 1) RemoveAllEventHandlers "Fired";
	_id = (_this select 1) addAction[(localize "STR_BMR_bullet_cam_on"),{call INS_bullet_cam}, 0, -9, false];
};
VehDrop_smoke_fnc = {
	// Pops Smoke,Flare and Chemlight at vehicle reward air drop position by Jigsor.
	private ["_dropPos","_dropPos_grnd","_smokeColor","_chemLight1","_smoke","_c","_flrObj","_veh"];
	_dropPos = _this select 0;
	_dropPos_grnd = _this select 1;
	_veh = _this select 2;
	_smokeColor = "SmokeShellBlue";

	_chemLight1 = createVehicle ["Chemlight_green", _dropPos_grnd, [], 0, "NONE"];
	sleep 1;

	_flrObj = "F_20mm_Red" createvehicle ((_veh) ModelToWorld [0,100,200]);
	_flrObj setVelocity [1,1,-10];
	sleep 0.1;

	_c = 0;
	while {_c < 2} do {
		_smoke = createVehicle [_smokeColor, [(_dropPos select 0) + 2, (_dropPos select 1) + 2, 55], [], 0, "NONE"];
		_i = _c + 1;
		sleep 20;
	};

	deleteVehicle _chemLight1;
	true
};
JIG_circling_cam = {
	// Circling camera by Jigsor
	_pos = _this select 0;
	_dir = random 359;
	_maxRotation = (_dir + 45);// 360
	_camHeight = 15;
	_camDis = -30;
	_interval = 1;
	_delay = 0.01;
	_logic_pos = [_pos select 0, _pos select 1, (_pos select 2) + 3];
	_camPos = [_pos select 0, _pos select 1, (_pos select 2) + _camHeight];

	_logic = createVehicle ["Land_ClutterCutter_small_F", _logic_pos, [], 0, "CAN_COLLIDE"];
	_logic setDir _dir;

	_cam = "camera" camCreate _camPos;
	_cam camSetPos _camPos;
	_cam camSetTarget _logic;
	_cam camCommit 0;
	waitUntil {camcommitted _cam};

	_cam attachTo [_logic, [0,_camDis,_camHeight] ];
	_cam cameraEffect ["internal", "BACK"];

	while {_dir < _maxRotation} do {
		_dir = _dir + _interval;
		_logic setDir _dir;
		sleep _delay;
	};

	camDestroy _cam;
	deleteVehicle _logic;
	player cameraEffect ["terminate", "BACK"];
	true
};
JIG_map_click = {
	// Vehicle reward mapclick position by Jigsor
	if (player getVariable "createEnabled") then {
		private ["_marker","_roads","_roadsSorted","_nearestRoad","_roadDir"];
		if !(getMarkerColor "VehDrop" isEqualTo "") then {deleteMarkerLocal "VehDrop";};
		hint "";
		_roadDir = 0;
		_nearestRoad = objNull;
		GetClick = true;
		openMap true;
		waitUntil {visibleMap};
		[] spawn {[localize "STR_BMR_reward_mapclick",0,.1,3,.005,.1] call bis_fnc_dynamictext;};

		["Reward_mapclick","onMapSingleClick", {

			if (isOnRoad _pos) then {
				_roads = _pos nearRoads 15;
				if (count _roads > 0) then {
					_roadsSorted = [_roads,[],{_pos distance _x},"ASCEND"] call BIS_fnc_sortBy;
					_nearestRoad = _roadsSorted select 0;
				};
			};

			_marker=createMarkerLocal ["VehDrop", _pos ];
			"VehDrop" setMarkerShapeLocal "ICON";
			"VehDrop" setMarkerSizeLocal [1, 1];
			"VehDrop" setMarkerTypeLocal "mil_dot";
			"VehDrop" setMarkerColorLocal "Color3_FD_F";
			"VehDrop" setMarkerTextLocal "Vehicle Reward Location";
			if (!isNull _nearestRoad) then {"VehDrop" setMarkerDirLocal (direction _nearestRoad);};

			GetClick = false;
		}] call BIS_fnc_addStackedEventHandler;

		waituntil {!GetClick or !(visiblemap)};
		["Reward_mapclick", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;

		if (!visibleMap) exitwith {[] call JIG_map_click};
		mapAnimAdd [0.5, 0.1, markerPos 'VehDrop'];
		mapAnimCommit;
		sleep 1.2;
		openMap false;

		[["cars", "tanks", "helicopters", "planes", "boats"], [], "VehDrop", [0,0,0.3], 3] execVM "ASORVS\open.sqf";
	}else{
		(_this select 0) removeAction (_this select 2);
		if !(getMarkerColor "VehDrop" isEqualTo "") then {deleteMarkerLocal "VehDrop";};
	};
	true
};
/*
INS_AI_revive = {
	// Initialize =BTC= Quick Revive for all group members including AI by Jigsor.
	if ((INS_p_rev isEqualTo 4) || (INS_p_rev isEqualTo 5)) then {
		private ["_pA","_aiA"];
		_pA = [];
		_aiA = [];
		_grp = group player;

		if (count bon_recruit_queue > 0) then { waitUntil {sleep 1; count bon_recruit_queue < 1}; };
		{if (isPlayer _x) then {_pA pushBack _x;}else{_aiA pushBack _x;};} forEach (units _grp);
		if (count _pA > 0) then {["btc_qr_fnc_unit_init", _grp] call BIS_fnc_MP;};
		{_x call btc_qr_fnc_unit_init;} forEach _aiA;
	};
};
*/
INS_Vehicle_Reward = {
	// Issues Vehicle Reward action to player by Jigsor. Admins can create vehicle at any time. Run the following command locally from debug console.
	// player spawn INS_Vehicle_Reward;
	player setVariable ["createEnabled", true];
	_id = player addAction[("<t size='1.5' shadow='2' color='#12F905'>") + (localize "STR_BMR_veh_reward") + "</t>",{call JIG_map_click}, [], 10, false, true];
};
INS_Recruit_skill = {
	// Sets skill of a recruited unit if ASR AI mod is not running on server or client
	if ((ASRrecSkill isEqualTo 1) || {(isClass(configFile >> "cfgPatches" >> "asr_ai_main"))}) exitWith {true};
	private "_unit";
	_unit = _this select 0;
	_unit setSkill ["aimingAccuracy", BTC_AI_skill];
	_unit setSkill ["aimingShake", 0.6];
	_unit setSkill ["aimingSpeed", 0.5];
	_unit setSkill ["endurance", 0.6];
	_unit setSkill ["spotDistance", 0.6];
	_unit setSkill ["spotTime", 0.5];
	_unit setSkill ["courage", 0.5];
	_unit setSkill ["reloadSpeed", 1];
	_unit setSkill ["general", 0.6];
	if (_unit isEqualTo (leader group _unit)) then {_unit setSkill ["commanding", 1];}else{	_unit setSkill ["commanding", 0.6];};
	true
};
INS_RespawnLoadout = {
	/*
	// Save respawn kit used with "Save Respawn Loadout" action by Jigsor
	INS_SaveLoadout = [(_this select 1), [missionNamespace, "BMRInsInv"]] call BIS_fnc_saveInventory;
	_kitSaved = "A3\Sounds_F\sfx\Beep_Target.wss";
	playsound3d [_kitSaved, (_this select 0), false, getPosasl (_this select 1), 10,0.5,10];
	true
	*/
};
INS_RestoreLoadout = {
/*
	// Restore saved kit when respawned by Jigsor.
	if (isNil "INS_SaveLoadout") then {
		[player, loadout] call setLoadout;
	}else{
		[player, [missionNamespace, "BMRInsInv"]] call BIS_fnc_loadInventory;
	};
	true
	*/
};
INS_UI_pref = {
	// Restore status hud and digital heading on respawn if they were activated before death by Jigsor.
	waitUntil {sleep 2; alive player};
	if (player getVariable "stathud_resp") then {execVM "INSui\staus_hud_toggle.sqf";};
	if (player getVariable "dhs_resp") then {execVM "scripts\heading.sqf";};
	true
};
INS_AI_Halo = {
	// AI halo based on/uses functions from ATM_airdrop.
	private ["_target","_loadout","_target","_halo_pos","_jumpAlt","_openChuteAlt","_freefall","_headgear","_back_pack","_back_pack_items","_back_pack_weap","_back_pack_maga"];
	_target = _this select 0;
	_halo_pos = _this select 1;
	_openChuteAlt = 75;//This does not work in Arma 3 as of v1.5. AI will open chute at 150m.
	_jumpAlt = 450;
	_freefall = true;
	_loadout = [];
	_headgear = headgear _target;
	_back_pack = backpack _target;
	_back_pack_items = getItemCargo (unitBackpack _target);
	_back_pack_weap = getWeaponCargo (unitBackpack _target);
	_back_pack_maga = getMagazineCargo (unitBackpack _target);
	_loadout = [_headgear, _back_pack, _back_pack_items, _back_pack_weap, _back_pack_maga];

	0=[_target] call Frontpack;

	removeBackpack _target;
	sleep 0.5;
	_target addBackpack "B_Parachute";
	_target setPos [_halo_pos select 0, _halo_pos select 1, (_halo_pos select 2) + _jumpAlt];
	_target switchMove "halofreefall_non";
	sleep 0.1;

	while {(getPos _target select 2) > 2} do {
		if (_freefall) then {
			if((getPos _target select 2) < _openChuteAlt) then {
				_target action ["OpenParachute", _target];
				_freefall = false;
			};
		};
		if(!alive _target) then {
			sleep (random 5) + 3;
			_target setPos [getPos _target select 0, getPos _target select 1, 0];
		};
		sleep 1;
	};

	deleteVehicle (_target getVariable "frontpack");
	_target setVariable ["frontpack",nil];

	0=[_target,_loadout] spawn ATM_Setloadout;
};
mhq_actions2_fnc = {
	// Add action for VA and quick VA profile to respawned MHQs by Jigsor.
	private ["_var","_op4"];
	_var = _this select 0;
	_op4 = _this select 1;
	switch (true) do {
		case (_var isEqualTo "MHQ_1") : {if (!_op4) then {MHQ_1 addAction[("<t size='1.5' shadow='2' color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>", "call JIG_load_VA_profile_MHQ1", [(_this select 1)]]; MHQ_1 addAction[("<t color='#ff1111'>") + (localize "STR_BMR_open_VA") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];};};
		case (_var isEqualTo "MHQ_2") : {if (!_op4) then {MHQ_2 addAction[("<t size='1.5' shadow='2' color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>", "call JIG_load_VA_profile_MHQ2", [(_this select 1)]]; MHQ_2 addAction[("<t color='#ff1111'>") + (localize "STR_BMR_open_VA") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];};};
		case (_var isEqualTo "MHQ_3") : {if (!_op4) then {MHQ_3 addAction[("<t size='1.5' shadow='2' color='#F56618'>") + (localize "STR_BMR_load_VAprofile") + "</t>", "call JIG_load_VA_profile_MHQ3", [(_this select 1)]]; MHQ_3 addAction[("<t color='#ff1111'>") + (localize "STR_BMR_open_VA") + "</t>",{["Open",true] call BIS_fnc_arsenal;}];};};
		case (_var isEqualTo "Opfor_MHQ") : {if (_op4) then {Opfor_MHQ addAction [("<t size='1.5' shadow='2' color='#12F905'>") + ("Deploy MHQ") + "</t>","scripts\deployOpforMHQ.sqf",nil,1, false, true, "", "side _this != INS_Blu_side"];};};
		default {};
	};
	true
};
INS_MHQ_mkr = {
	// Tracking MHQ marker by Jigsor.
	private ["_mhq","_op4","_side","_mkr","_mhqPos","_mkrName"];
	_mhq = _this select 0;
	_op4 = _this select 1;
	_mhqPos = _this select 2;
	if (_mhq isEqualTo objNull) exitWith {hint format ["Mobile Headquarters %1 does not exist", _mhq]};
	if (vehicleVarName _mhq != "") then {_mkrName = vehicleVarName _mhq;}else{_mkrName = format ["%1", _mhq];};

	if ((_op4 isEqualTo TRUE) && {(_mkrName isEqualTo "Opfor_MHQ")}) then {
		deleteMarkerLocal _mkrName;
		_mkr = createMarkerLocal [_mkrName, _mhqPos];
		_mkr setMarkerTypeLocal "mil_dot";
		_mkr setMarkerTextLocal _mkrName;
		_mkr setMarkerColorLocal "ColorRed";
		_mkr setMarkerSizeLocal [0.5, 0.5];

		while {alive _mhq} do {
			_mkr setMarkerPosLocal (getPosASL _mhq);
			UIsleep 1;
		};
		if (!alive _mhq) exitWith {deleteMarkerLocal _mkrName; hintSilent format ["%1 has been destroyed!", _mkrName]};
	}else{
		deleteMarkerLocal _mkrName;
		_mkr = createMarkerLocal [_mkrName, _mhqPos];
		_mkr setMarkerTypeLocal "mil_dot";
		_mkr setMarkerTextLocal _mkrName;
		_mkr setMarkerColorLocal "ColorGreen";
		_mkr setMarkerSizeLocal [0.5, 0.5];

		while {alive _mhq} do {
			_mkr setMarkerPosLocal (getPosASL _mhq);
			UIsleep 1;
		};
		if (!alive _mhq) exitWith {deleteMarkerLocal _mkrName; hintSilent format ["%1 has been destroyed!", _mkrName]};
	};
};
GAS_smokeNear = {
	//Are we near a smoke shell. Are we not wearing a gas mask. code by Larrow modified by Jigsor
	if ((headgear player in INS_gasMaskH) || {(goggles player in INS_gasMaskG)}) then {
		false
	}else{
		_smokeShell = player nearObjects ["GrenadeHand", 30];
		{
			if !(typeOf _x in INS_Gas_Grenades) then {_smokeShell = _smokeShell - [_x];};
		} count _smokeShell;

		if !(isNull (_smokeShell select 0)) then {
			vectorMagnitudeSqr velocity (_smokeShell select 0) <= 0.5 && { (_smokeShell select 0) distance player < 15 }
		}else{
			false
		};
	};
};
GAS_inSmoke = {
	// We are in smoke. code by Larrow
	player setVariable ["inSmoke",true];

	private ["_maxtype","_sound"];
	_maxtype = (count Choke_Sounds);

	"dynamicBlur" ppEffectEnable true;
    "dynamicBlur" ppEffectAdjust [12];
	"dynamicBlur" ppEffectCommit 5;
	enableCamShake true;
	addCamShake [10, 45, 10];
	5 fadeSound 0.1;

	//While were in smoke
	while { alive player && not captive player && [] call GAS_smokeNear } do {
		_sound = Choke_Sounds select (floor random _maxtype);
		playsound3d [_sound, player, false, getPosasl player, 10,1,30];
		player setDamage (damage player + 0.14);
		//if(round(random(1)) isEqualTo 0) then {hint "You Should Wear a Gas Mask";};
    	sleep 2.8123;
	};

	[] call GAS_smokeClear;
};
GAS_smokeClear = {
	// Clear effects. code by Larrow
	player setVariable ["inSmoke",false];

	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 10;
	resetCamShake;
	20 fadeSound 1;
};