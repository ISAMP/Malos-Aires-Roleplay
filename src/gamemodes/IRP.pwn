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
	print("By Nevermore, Froda, Rodam, Razzo.");
	print("---------------------------------------");
}

// LoginPlayer
public LoginPlayer(playerid, password[])
{
    new string[256];
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
    format(Condicion, sizeof(Condicion), "WHERE `Name`='%s' AND `Key`=MD5('%s')", PlayerName, password);
    if(MySQLCountRows(CHARINFOTABLE, Condicion)) // Existe?
    {
		format(Condicion, sizeof(Condicion), "WHERE `IDChar`=%d", MySQLGetPlayerID(PlayerName));
		format(string, sizeof(string), "Servidor: {AFAFAF}Logueaste con éxito.");
		SendClientMessage(playerid, COLOR_WHITE, string);
		SetPVarString(playerid, "Key", password);
		SetPVarInt(playerid, "IDChar", MySQLGetPlayerID(PlayerName));
		SetPVarInt(playerid, "Logged", 1);
		SetPVarInt(playerid, "Skin", MySQLGetInt(CHARDATATABLE, "Skin", Condicion));
    	SetSpawnInfo(playerid, 0, 0, 1486.4741, -1758.3142, 17.5313, 0, 0, 0, 0, 0, 0, 0);
        SpawnPlayer(playerid);
    }
    else // No Existe?
    {
		SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}El personaje no existe o la contraseña es incorrecta.");
  		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Conectarse", "{FF0000}Escribi tu contrasena para\n conectarte al servidor.", "Conectar", "Cancelar");
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
		ShowNameTags(1);
		ShowPlayerMarkers(0);
		EnableStuntBonusForAll(0);
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
		if(MySQLCheckPlayer(PlayerName))
		{
		    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Conectarse", "{FF0000}Escribi tu contrasena para\n conectarte al servidor.", "Conectar", "Cancelar");
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}¡No estás registrado en Imperium SA-MP Roleplay!");
		    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registro", "{FF0000}Escribi una contrasena para\n registrarte en el servidor.", "Registrar", "Cancelar");
		}
		SpawnPlayer(playerid);
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

		SetPlayerSkin(playerid, GetPVarInt(playerid, "Skin"));
		SetPlayerColor(playerid, COLOR_WHITE);
		
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
   		SetCameraBehindPlayer(playerid);
		SetPlayerPos(playerid, 1486.4741, -1758.3142, 17.5313);
		return 1;
	}

	// OnPlayerRequestClass
	//------------------------------------------------------
	public OnPlayerRequestClass(playerid, classid)
	{
		if(IsPlayerNPC(playerid)) return 1;
		
		SpawnPlayer(playerid);
		return 0;
	}

	// OnPlayerDeath
	//------------------------------------------------------
	public OnPlayerDeath(playerid, killerid, reason)
	{
	    SpawnPlayer(playerid);
	    return 1;
	}
	
	// OnPlayerText
	//------------------------------------------------------
	public OnPlayerText(playerid, text[])
	{
		new string[256];
		new PlayerName[MAX_PLAYER_NAME];
		if(!IsPlayerConnected(playerid)) return 0;
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
		
		// Checkeos
		if(!GetPVarInt(playerid, "Logged")) return 0;
		format(string, sizeof(string), "%s dice: %s", PlayerName, text);
		ProxDetector(20.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		return 0;
	}
	
	// OnDialogResponse
	//------------------------------------------------------
	public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
	{
	    if(response)
	    {
		    switch(dialogid)
		    {
		        case 1: // DIALOG_LOGIN
		            dcmd_conectar(playerid, inputtext);
				case 2: // DIALOG_REGISTER
				    dcmd_registrar(playerid, inputtext);
		    }
	    }
	    return 1;
	}
	
// Comandos
//------------------------------------------------------

	// Registrarse
	dcmd_registrar(playerid, params[])
	{
		new idx;
		new Password[256];
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
		
		// Checkeos
		if(GetPVarInt(playerid, "Logged")) return 1;
		if(MySQLCheckPlayer(PlayerName))
		{
			SendClientMessage(playerid, COLOR_WHITE, "Servidor: {AFAFAF}Este nombre ya está Registrado. Use /conectar para ingresar al servidor.");
		    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registro", "{FF0000}Escribi una contrasena para\n registrarte en el servidor.", "Registrar", "Cancelar");
			return 1;
		}
		
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

