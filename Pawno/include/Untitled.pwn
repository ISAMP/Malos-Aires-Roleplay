#include <a_samp>
#include <a_sampmysql>

// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
    new resultline[1024];
    new field[128];
    new query[256];
	SetGameModeText("Blank Script");

	samp_mysql_connect("127.0.0.1", "root", "");
	samp_mysql_select_db("test");
	samp_mysql_real_escape_string("SELECT * FROM members", query);
	samp_mysql_query(query);
	samp_mysql_store_result();
	while(samp_mysql_fetch_row(resultline)==1)
	{
		printf("%s\n", resultline);
		samp_mysql_strtok(field, "|", resultline); //first call of strtok MUST contain resultline
		printf("%s\n", field);
		while(samp_mysql_strtok(field, "|", "")==1) //From 2nd call to the end you MUST call strtok without resultline
		{
	    	printf("%s\n", field);
		}
		if(samp_mysql_ping()==0)
		{
		    printf("Connection is good !\n");
		}
		else
		{
		    if(samp_mysql_ping()==1)
		    {
		        printf("MySQL server is not contactable !\n");
		    }
		    else
		    {
		        if(samp_mysql_ping()==2)
		        {
		            printf("MySQL server unknown error !\n");
		        }
		        else
		        {
		            printf("It's impossible to get this message !\n");
		        }
		    }
		}
	}
	samp_mysql_close();
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerInfoChange(playerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

