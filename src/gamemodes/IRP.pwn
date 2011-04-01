//------------------------------------------------------

/*
	GameMode Oficial Imperium SA-MP
    Copyright (C) 2011  Imperium Games

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//------------------------------------------------------
// Encargados del Script: Nevermore, Froda, Rodam, Razzo?
//------------------------------------------------------

// Includes Generales
//------------------------------------------------------
#include <a_samp>
#include <mysql>
#include <streamer>
#include <core>
#include <float>

#include <isamp/database>
#include <isamp/functions>
#include <isamp/defines>

#pragma tabsize 0

// Arrays
//------------------------------------------------------


// Variables Globales/Defines
//------------------------------------------------------


// Prototipos de Funciones
//------------------------------------------------------
forward LoginPlayer(playerid, password[]);

// Funciones
//------------------------------------------------------

// main
main()
{
	print("---------------------------------------");
	print("Imperium SA-MP Roleplay");
	print("---------------------------------------");
}

// LoginPlayer
public LoginPlayer(playerid, password[])
{
    new string[256];
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
    format(Condicion, sizeof(Condicion), "WHERE `Name`='%s' AND `Key`=MD5('%s')", PlayerName, password);
    // Existe?
    if(MySQLCountRows(CHARINFOTABLE, Condicion))
    {
		format(string, sizeof(string), "Servidor: {AFAFAF}Logueaste con éxito.");
		SendClientMessage(playerid, COLOR_WHITE, string);
		SetPVarString(playerid, "Key", password);
		SetPVarInt(playerid, "IDChar", MySQLGetPlayerID(PlayerName));
		SetPVarInt(playerid, "Logged", 1);
		format(Condicion, sizeof(Condicion), "WHERE `IDChar`=%d", MySQLGetPlayerID(PlayerName));
		SetPVarInt(playerid, "Skin", MySQLGetInt(CHARDATATABLE, "Skin", Condicion));
        SpawnPlayer(playerid);
    }
    else // No Existe?
    {
		SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}Contraseña Incorrecta.");
    }
    return 1;
}

// Callbacks
//------------------------------------------------------

	// OnGameModeInit
	//------------------------------------------------------
	public OnGameModeInit()
	{
		MySQLConnect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
		SetGameModeText("RolePlay Espanol");
		SendRconCommand("mapname Malos Aires");
		SendRconCommand("weburl www.imperiumgames.com.ar");
		ShowNameTags(0);
		ShowPlayerMarkers(0);
		EnableStuntBonusForAll(0);
		DisableInteriorEnterExits();
		return 1;
	}

	// OnPlayerConnect
	//------------------------------------------------------
	public OnPlayerConnect(playerid)
	{
		new string[256];
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	    if(IsPlayerNPC(playerid)) return 1;
	    SetPlayerColor(playerid,COLOR_GRAD2);
		format(string, sizeof(string), "Servidor: {AFAFAF}%s [%d] ha entrado a Imperium SA-MP RolePlay.", PlayerName, playerid);
		SendClientMessageToAll(COLOR_WHITE, string);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "___ {F5DEB3}¡Bienvenido a Imperium SA-MP RolePlay!{9ACD32} ___");
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "_____________________________________________");
		ClearChatBox(playerid, 5);
		if(MySQLCheckPlayer(PlayerName))
		{
			format(string, sizeof(string), "Servidor: {AFAFAF}Usa \"/conectar [contraseña]\" para conectarte al servidor.", PlayerName, playerid);
			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		else
		{
			format(string, sizeof(string), "Servidor: {AFAFAF}¡No estás registrado en Imperium SA-MP Roleplay!", PlayerName, playerid);
			SendClientMessage(playerid, COLOR_WHITE, string);
			format(string, sizeof(string), "Servidor: {AFAFAF}Usa \"/registrar [contraseña]\" para registrarte en el servidor.", PlayerName, playerid);
			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		return 1;
	}

	// OnPlayerUpdate
	//------------------------------------------------------
	public OnPlayerUpdate(playerid)
	{
		if(!IsPlayerConnected(playerid)) return 0;
		
		return 1;
	}

	// OnPlayerSpawn
	//------------------------------------------------------
	public OnPlayerSpawn(playerid)
	{
		if(IsPlayerNPC(playerid)) return 1;

		// Spawn en la Casa de Gobierno
		SetPlayerSkin(playerid, GetPVarInt(playerid, "Skin"));
		SetPlayerColor(playerid, COLOR_WHITE);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1486.4741, -1758.3142, 17.5313);
		return 1;
	}

	// OnPlayerRequestClass
	//------------------------------------------------------
	public OnPlayerRequestClass(playerid, classid)
	{
		if(IsPlayerNPC(playerid)) return 1;
		
		SpawnPlayer(playerid);
		OnPlayerSpawn(playerid);

		return 0;
	}
	
	// OnPlayerText
	//------------------------------------------------------
	public OnPlayerText(playerid, text[])
	{
		new string[256];
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
		// Checkeos
		if(!GetPVarInt(playerid, "Logged")) return 0;
		format(string, sizeof(string), "%s dice: %s", PlayerName, text);
		ProxDetector(20.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		return 0;
	}
	
// DCMD
//------------------------------------------------------

	// Registrarse
	dcmd_registrar(playerid, params[])
	{
		new idx;
		new Password[256];
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
		// Checkeos
		if(strcmp(params,"", true)) return SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}Uso: \"/registrar [contraseña]\"");
		if(GetPVarInt(playerid, "Logged")) return 1;
		if(MySQLCheckPlayer(PlayerName)) return SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}Este nombre ya está Registrado. Use /conectar para ingresar al servidor.");
		// Registramos y Logueamos
		Password = strtok(params, idx);
		MySQLRegisterPlayer(PlayerName, Password);
		SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}¡Gracias por registrarse en Imperium SA-MP Roleplay!");
		LoginPlayer(playerid, Password);
		return 1;
	}

	// Conectarse
	dcmd_conectar(playerid, params[])
	{
		new idx;
		new Password[256];
		// Checkeos
		if(strcmp(params,"", true)) return SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}Uso: \"/conectar [contraseña]\"");
		if(GetPVarInt(playerid, "Logged")) return 1;
		// Logueamos
		Password = strtok(params, idx);
		LoginPlayer(playerid, Password);
		return 1;
	}

	// OnPlayerCommandText
	//------------------------------------------------------
	public OnPlayerCommandText(playerid, cmdtext[])
	{
	    dcmd(registrar, 9, cmdtext);
	    dcmd(conectar, 8, cmdtext);
	    return 0;
	}

