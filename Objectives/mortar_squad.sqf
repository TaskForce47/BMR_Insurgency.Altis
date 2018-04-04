//mortar_squad.sqf by Jigsor

sleep 2;
private ["_newZone","_type","_rnum","_range","_run","_roadNear","_signPos","_roads","_roadSegment","_roadDir","_mortar_type","_objmkr","_sign","_grp","_stat_grp","_handle","_unit_type","_damage","_offset_pos1","_static1","_offset_pos2","_static2","_offset_pos3","_static3","_StaticArray1","_all_mortars","_tskW","_tasktopicW","_taskdescW","_tskE","_tasktopicE","_taskdescE","_manArray"];

_newZone = _this select 0;
_type = _this select 1;
_rnum = str(round (random 999));
_range = 600;
_run = true;
_roadNear = false;
_signPos = _newZone;
_mortar_type = "O_G_Mortar_01_F";
_shell_types = ["8Rnd_82mm_Mo_shells","8Rnd_82mm_Mo_Smoke_white","8Rnd_82mm_Mo_shells"];// 1 in 3 chance for smoke shell

objective_pos_logic setPos _newZone;

_objmkr = createMarker ["ObjectiveMkr", _newZone];
"ObjectiveMkr" setMarkerShape "ELLIPSE";
"ObjectiveMkr" setMarkerSize [2, 2];
"ObjectiveMkr" setMarkerShape "ICON";
"ObjectiveMkr" setMarkerType "mil_dot";
"ObjectiveMkr" setMarkerColor "ColorRed";
"ObjectiveMkr" setMarkerText "Mortar Squad";

// Spawn Objective center object
_sign = createVehicle [_type, _newZone, [], 0, "None"];//Vanilla
sleep jig_tvt_globalsleep;

while {isOnRoad _newZone} do {
	_signPos = _newZone findEmptyPosition [2, 30, _type];
	sleep 0.2;
};

_roads = _signPos nearRoads 20;

if (count _roads > 0) then {
	_roadNear = true;
	_roadSegment = _roads select 0;
	_roadDir = direction _roadSegment;
};

if (_roadNear) then {_sign setDir _roadDir - 90;};
_sign setVectorUp [0,0,1];

// Spawn Objective enemy defences
_grp = [_newZone,14] call spawn_Op4_grp;
//_stat_grp = [_newZone,3] call spawn_Op4_StatDef;

//_stat_grp setCombatMode "RED";
_handle=[_grp, position objective_pos_logic, 75] call BIS_fnc_taskPatrol;
if (DebugEnabled > 0) then {[_grp] spawn INS_Tsk_GrpMkrs;};

mortar_grp = createGroup INS_Op4_side;

_unit_type = INS_men_list select (round (random ((count INS_men_list) - 1)));
mortar_grp createUnit [_unit_type, _newZone, [], 0, "NONE"];
sleep 1;
_unit_type = INS_men_list select (round (random ((count INS_men_list) - 1)));
mortar_grp createUnit [_unit_type, _newZone, [], 0, "NONE"];
sleep 1;
_unit_type = INS_men_list select (round (random ((count INS_men_list) - 1)));
mortar_grp createUnit [_unit_type, _newZone, [], 0, "NONE"];
sleep 1;

{
	if (EOS_DAMAGE_MULTIPLIER != 1) then
	{
		_x removeAllEventHandlers "HandleDamage";
		_x addEventHandler ["HandleDamage",{_damage = (_this select 2)*EOS_DAMAGE_MULTIPLIER;_damage}];
	};
} forEach (units mortar_grp);
{_x addeventhandler ["killed","[(_this select 0)] spawn remove_carcass_fnc"];} forEach (units mortar_grp);

_offset_pos1 = [getMarkerPos "ObjectiveMkr", 10, 125, 20, 0, 0.6, 0] call BIS_fnc_findSafePos;
if (_offset_pos1 distance _newZone > 125) then {_offset_pos1 = [getMarkerPos "ObjectiveMkr", 2, 125, 5, 0, 0.6, 0] call BIS_fnc_findSafePos;};

_offset_pos2 = [getMarkerPos "ObjectiveMkr", 10, 125, 20, 0, 0.6, 0] call BIS_fnc_findSafePos;
if (_offset_pos2 distance _newZone > 125) then {_offset_pos2 = [getMarkerPos "ObjectiveMkr", 2, 125, 5, 0, 0.6, 0] call BIS_fnc_findSafePos;};

_offset_pos3 = [getMarkerPos "ObjectiveMkr", 10, 125, 20, 0, 0.6, 0] call BIS_fnc_findSafePos;
if (_offset_pos3 distance _newZone > 125) then {_offset_pos3 = [getMarkerPos "ObjectiveMkr", 2, 125, 5, 0, 0.6, 0] call BIS_fnc_findSafePos;};

_static1 = createVehicle [_mortar_type, _offset_pos1, [], 0, "None"]; sleep jig_tvt_globalsleep;
_static2 = createVehicle [_mortar_type, _offset_pos2, [], 0, "None"]; sleep jig_tvt_globalsleep;
_static3 = createVehicle [_mortar_type, _offset_pos3, [], 0, "None"]; sleep jig_tvt_globalsleep;

_static1 setDir 0;
_static2 setDir 120;
_static3 setDir 240;

_all_mortars = [_static1,_static2,_static3];

{_x setVariable["persistent",true]} foreach _all_mortars;
 
(units mortar_grp select 0) assignAsGunner _static1; sleep jig_tvt_globalsleep;
(units mortar_grp select 1) assignAsGunner _static2; sleep jig_tvt_globalsleep;
(units mortar_grp select 2) assignAsGunner _static3; sleep jig_tvt_globalsleep;
(units mortar_grp select 0) moveInGunner _static1; sleep jig_tvt_globalsleep;
(units mortar_grp select 1) moveInGunner _static2; sleep jig_tvt_globalsleep;
(units mortar_grp select 2) moveInGunner _static3; sleep jig_tvt_globalsleep;

(units mortar_grp select 0) setVariable ["zbe_cacheDisabled",true];

//sleep 2;
//_StaticArray1 = [_static1];
//nul = [_newZone, _StaticArray1, 110, 2, [0,33], true, false] execVM "scripts\SHK_buildingpos.sqf";

mortar_grp setCombatMode "RED";
if (BTC_p_skill isEqualTo 1) then {
	//[_stat_grp] call BTC_AI_init;
	[_grp] call BTC_AI_init;
	[mortar_grp] call BTC_AI_init;
};

// create west task
_tskW = "tskW_destroy_mortars" + _rnum;
_tasktopicW = localize "STR_BMR_Tsk_topicW_dms";
_taskdescW = localize "STR_BMR_Tsk_topicW_dms";
[_tskW,_tasktopicW,_taskdescW,WEST,[],"created",_newZone] call SHK_Taskmaster_add;
sleep 5;

// create east task
_tskE = "tskE_defend_mortars" + _rnum;
_tasktopicE = localize "STR_BMR_Tsk_topicE_dms";
_taskdescE = localize "STR_BMR_Tsk_topicE_dms";
[_tskE,_tasktopicE,_taskdescE,EAST,[],"created",_newZone] call SHK_Taskmaster_add;

if (INS_environment isEqualTo 1) then {if (daytime > 3.00 && daytime < 5.00) then {[] spawn {[[], "INS_fog_effect"] call BIS_fnc_mp;};};};

while {_run} do {
	if ({alive _x} count units mortar_grp > 0) then	{
		{_x setVehicleAmmo 1;} count _all_mortars;

		_manArray = (getposatl objective_pos_logic) nearentities [["CAManBase"],_range];

		{
			if (!(side _x == INS_Blu_side)) then {
				_manArray = _manArray - [_x];
			};
		} count _manArray;

		if (count _manArray > 0) then {
			{
				private ["_mtarget","_type"];
				_type = _shell_types select (floor(random(count _shell_types)));
				_mtarget = _manArray select (floor random count _manArray);
				_pos = [(getPosatl _mtarget select 0) + (random 50) - 25, (getPosatl _mtarget select 1) + (random 50) - 25, (getPosatl _mtarget select 2)];
				_x lookAt _pos;
				_x reveal _mtarget;
				_x commandArtilleryFire [_pos, _type, floor (random 5)];
			} forEach (units mortar_grp);
		};
		sleep 20;
	}else{
		_run = false;
	};
};

// Only one outcome supported.
waitUntil {sleep 1; !_run};

[_tskW, "succeeded"] call SHK_Taskmaster_upd;
[_tskE, "failed"] call SHK_Taskmaster_upd;
	/*****ADD*TICKETS*TO*ACTUAL*TICKET*AMOUNT*BY*TASKFORCE47*******/
	[objNull,5, 10, true, 'Side Mission'] remoteExecCall ["tf47_core_ticketsystem_fnc_changeTickets", 2];
	/**************************************************************/
// clean up
"ObjectiveMkr" setMarkerAlpha 0;
sleep 90;

{deleteVehicle _x; sleep 0.1} forEach (units _grp);
//{deleteVehicle _x; sleep 0.1} forEach (units _stat_grp);
{deleteVehicle _x; sleep 0.1} forEach (units mortar_grp);
deleteGroup _grp;
//deleteGroup _stat_grp;
deleteGroup mortar_grp;

if (!isNull _sign) then {deleteVehicle _sign; sleep 0.1;};
{if (!isNull _x) then {deleteVehicle _x; sleep 0.1}} foreach _all_mortars;
{if (typeof _x in INS_Op4_stat_weps) then {deleteVehicle _x; sleep 0.1}} forEach (NearestObjects [objective_pos_logic, [], 40]);

deleteMarker "ObjectiveMkr";

if (true) exitWith {sleep 20; nul = [] execVM "Objectives\random_objectives.sqf";};