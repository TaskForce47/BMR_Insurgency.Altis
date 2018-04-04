_null = [] execVM "va_ace.sqf";

/* TF47CoreScripts - Start */
waitUntil {
	if(!(isNil "tf47_core_server_init")) then {
		tf47_core_server_init
	} else {
		false
	}
};
[player] remoteExec ["tf47_core_whitelist_fnc_checkSlotWhitelist", 2];
[player] remoteExec ["tf47_core_fnc_initPlayer", 2];
/* TF47CoreScripts - End */

/* TF47Modules */
waitUntil{ if(!isNil "tf47_modules_init_complete") then {
		tf47_modules_init_complete
	} else {
		false
	};};
waitUntil { !isNull (findDisplay 46) };
[] call tf47_modules_umenu_fnc_initPlayer;

(findDisplay 46) displayAddEventHandler
    ["KeyDown", "if((_this select 4) && (_this select 1) == 22 &&
        !dialog) then { _nul = [] spawn tf47_modules_core_fnc_initMenu;
    };"];