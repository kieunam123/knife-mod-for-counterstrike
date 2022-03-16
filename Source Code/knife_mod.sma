#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <sockets>
#include <fun>
#include <fakemeta>
#include <fakemeta_util>
#include <cstrike>
#include <csx>
#include <hamsandwich>
#include <xs>

#define PLUGIN "Knife Mod 2"
#define VERSION "2.0"
#define AUTHOR "_CyBeR_"
#define Get_BitVar(%1,%2) (%1 & (1 << (%2 & 31)))
#define Set_BitVar(%1,%2) %1 |= (1 << (%2 & 31))
#define UnSet_BitVar(%1,%2) %1 &= ~(1 << (%2 & 31))

new g_Connected


public plugin_init() { 
	
	register_plugin(PLUGIN, VERSION, AUTHOR) 
	
	register_clcmd("say /knife", "open_shop2")

	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	register_forward(FM_GetGameDescription, "fw_gamedesc")
	set_task(480.0, "kmodmsg", 0, _, _, "b")
}





public client_putinserver(id)
{
	Set_BitVar(g_Connected, id)
}

public client_disconnect(id)
{
	UnSet_BitVar(g_Connected, id)

}

public fw_PlayerSpawn_Post(id)
{
	if(!Get_BitVar(g_Connected, id)) return
	open_shop2(id)
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")
	client_print(0,print_chat,"Knife Mod 2.0 is made by _CyBeR_")
}

public plugin_cfg()
{
    server_cmd( "sv_restart 1" )
}

public plugin_precache() 
{ 
    new iEnt = create_entity("info_map_parameters") 
    DispatchKeyValue(iEnt, "buying", "3") 
    DispatchSpawn(iEnt) 
}


//-------------------------------------Them vu khi vao day-------------------------------------

#define MAX_ITEM2 10

new const item_name[MAX_ITEM2][] =
{
	"Jannus 9",
	"Electric Crowbar",
	"Balrog 9",
	"Dual Katana",
	"Dragon Sword",
	"Hammer",
	"Papin",
	"Thanatos 9",
	"Gay ton ngo khong",
	"Dragon Axe"
}
new const item_cost2[MAX_ITEM2] =
{
	3500,
	3000,
	6000,
	4000,
	3500,
	7000,
	8000,
	10000,
	3000,
	9000
	
}
	

public open_shop2(id)
{
	
	new menu, temp_string[128], temp_string2[2], g_temp_string_handle[128]
	formatex(g_temp_string_handle, sizeof(g_temp_string_handle), "\rKnife Menu")
	menu = menu_create(g_temp_string_handle, "menu_mhandle")
	
	for(new i = 0; i < MAX_ITEM2 - 3; i++)
	{
		format(temp_string, sizeof(temp_string), "%s	\y%i$", item_name[i], item_cost2[i])
		num_to_str(i, temp_string2, sizeof(temp_string2))
		
		menu_additem(menu, temp_string, temp_string2)
	}
	
	// Normal because error
	format(temp_string, sizeof(temp_string), "%s \y%i$", item_name[7], item_cost2[7])
	num_to_str(7, temp_string2, sizeof(temp_string2))
	menu_additem(menu, "Thanatos 9	\y10000$", "7")		
	
	format(temp_string, sizeof(temp_string), "%s \y%i$", item_name[8], item_cost2[8])
	num_to_str(8, temp_string2, sizeof(temp_string2))
	menu_additem(menu, "Gay ton ngo khong	\y3000$", "8")	
	
	format(temp_string, sizeof(temp_string), "%s \y%i$", item_name[9], item_cost2[9])
	num_to_str(9, temp_string2, sizeof(temp_string2))
	menu_additem(menu, "Dragon Axe	\y9000$", "9")	
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	menu_display(id, menu, 0)	
}

public menu_mhandle(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}	
	
	
	new data[6], szName[64], access, callback, key
	
	menu_item_getinfo(menu, item, access, data,charsmax(data), szName,charsmax(szName), callback)
	key = str_to_num(data)

switch(key)
	{
			case 0: {
				if(cs_get_user_money(id) >= item_cost2[key]) {
				client_cmd( id , "remove" )
				client_cmd( id , "jannus9" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
			}
			case 1: {
				if(cs_get_user_money(id) >= item_cost2[key]) {	
				client_cmd( id , "remove" )
				client_cmd( id , "crowbar" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
			}
	
			
			case 2: {
				if(cs_get_user_money(id) >= item_cost2[key]) {
				client_cmd( id , "remove" )
				client_cmd( id , "balrog9" )	
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
				
			}
			case 3: {
				if(cs_get_user_money(id) >= item_cost2[key]) {
				client_cmd( id , "remove" )
				client_cmd( id , "dualkatana" )		
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
			}
			case 4: {
				if(cs_get_user_money(id) >= item_cost2[key]) {					
				client_cmd( id , "remove" )
				client_cmd( id , "dragonsword" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
			}
	
			case 5: {
				if(cs_get_user_money(id) >= item_cost2[key]) {
				client_cmd( id , "remove" )
				client_cmd( id , "hammer" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
			}
	
			case 6: {
				if(cs_get_user_money(id) >= item_cost2[key]) {			
				client_cmd( id , "remove" )
				client_cmd( id , "papin" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
				
			}
			case 7: {
				if(cs_get_user_money(id) >= item_cost2[key]) {	
				client_cmd( id , "remove" )
				client_cmd( id , "thanatos9" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
				
			}
			case 8: {
				if(cs_get_user_money(id) >= item_cost2[key]) {	
				client_cmd( id , "remove" )
				client_cmd( id , "stick" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
			}
			case 9: {
				if(cs_get_user_money(id) >= item_cost2[key]) {	
				client_cmd( id , "remove" )
				client_cmd( id , "axe" )
				cs_set_user_money(id, cs_get_user_money(id) - item_cost2[key])
				} else {
				client_print(id, print_chat, "[Knife Mod] Ko du tien thi cut")
				}
			}
		}
		
return PLUGIN_HANDLED

		}

		
//------------------------------------------------------------------------------------------------
		

public fw_gamedesc()
{
	forward_return(FMV_STRING, "Knife Mod")
	return FMRES_SUPERCEDE
}

public kmodmsg() {

client_print(0,print_chat,"[Huong dan] Go /knife de lua chon vu khi")
}


















/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1066\\ f0\\ fs16 \n\\ par }
*/
