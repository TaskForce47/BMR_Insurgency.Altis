/* TF47CoreScripts - Start */
waitUntil { time > 0 };
[] call tf47_core_fnc_init;
tf47_core_server_init = true;
publicVariable "tf47_core_server_init";
/* TF47CoreScripts - End */

/* TF47Modules */
[] call tf47_modules_servicepoint_fnc_initConfig;
[] call tf47_modules_umenu_fnc_initConfig;
[] call tf47_modules_vs_fnc_initConfig;

tf47_modules_init_complete = true;
publicVariable "tf47_modules_init_complete";
diag_log [diag_frameno, diag_ticktime, time, "MPF initServer.sqf processed"];