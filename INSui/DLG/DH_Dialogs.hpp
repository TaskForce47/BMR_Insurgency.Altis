// by Dirty Haz

class DH_Y_Menu {
movingEnable = false;
idd = 10000;
onLoad = "uiNamespace setVariable ['DH_Y_Menu', (_this select 0)];";
onUnLoad = "";
class Controls {
class Bg: DH_RscPicture {
idc = -1;
x = 0.4 * safezoneW + safezoneX;
y = 0.29 * safezoneH + safezoneY;
w = 0.2 * safezoneW;
h = 0.5 * safezoneH;
text = "#(argb,8,8,3)color(0,0,0,0.7)";
};
class Client_Settings: DH_RscButton {
idc = -1;
x = 0.425 * safezoneW + safezoneX;
y = 0.33 * safezoneH + safezoneY;
w = 0.15 * safezoneW;
h = 0.06 * safezoneH;
text = "$STR_BMR_UI_view_settings";
action = "closeDialog 0; call TAWVD_fnc_openTAWVD";
};
class Toggle_Heading: DH_RscButton {
idc = -1;
x = 0.425 * safezoneW + safezoneX;
y = 0.42 * safezoneH + safezoneY;
w = 0.15 * safezoneW;
h = 0.06 * safezoneH;
text = "$STR_BMR_UI_toggle_heading";
action = "closeDialog 0; execVM 'scripts\heading.sqf';";
};
class Ice_Man_Hud: DH_RscButton {
idc = -1;
x = 0.425 * safezoneW + safezoneX;
y = 0.51 * safezoneH + safezoneY;
w = 0.15 * safezoneW;
h = 0.06 * safezoneH;
text = "$STR_BMR_UI_status_hud";
action = "closeDialog 0; execVM 'INSui\staus_hud_toggle.sqf';";
};
class Ear_Plugs: DH_RscButton {
idc = -1;
x = 0.425 * safezoneW + safezoneX;
y = 0.60 * safezoneH + safezoneY;
w = 0.15 * safezoneW;
h = 0.06 * safezoneH;
text = "$STR_BMR_earPlugs";
action = "closeDialog 0; call INS_EarPlugs";
};
class Close_Dialog: DH_RscButton {
idc = -1;
x = 0.425 * safezoneW + safezoneX;
y = 0.69 * safezoneH + safezoneY;
w = 0.15 * safezoneW;
h = 0.06 * safezoneH;
text = "$STR_BMR_UI_close_dialog";
action = "closeDialog 0;";
};
};
};