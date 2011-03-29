#define TIME_DIF 2000 //Decreasing will make it more accurate, leave it like that, it's fine.

forward P_OnPlayerConnect(playerid);
forward P_OnPlayerUpdate(playerid);
forward P_OnPlayerRequestClass(playerid);
forward P_OnPlayerDisconnect(playerid);
forward P_OnPlayerSpawn(playerid);
forward C_Paused(playerid);
forward OnPlayerPause(playerid);

new g_Paused[MAX_PLAYERS];
new g_Timer[MAX_PLAYERS];
new bool:g_Requesting[MAX_PLAYERS];
new PlayerText3D:playertextid;

public P_OnPlayerConnect(playerid)
{
	g_Timer[playerid] = SetTimerEx("C_Paused", 754, 1, "i", playerid);
	return 1;
}

public P_OnPlayerUpdate(playerid)
{
	g_Paused[playerid] = GetTickCount();
	return 1;
}

public P_OnPlayerRequestClass(playerid)
{
	g_Requesting[playerid] = true;
	return 1;
}

public P_OnPlayerDisconnect(playerid)
{
	KillTimer(g_Timer[playerid]);
    g_Requesting[playerid] = false;
	return 1;
}

public P_OnPlayerSpawn(playerid)
{
	g_Requesting[playerid] = false;
	return 1;
}

public C_Paused(playerid)
{
    if(GetTickCount()-g_Paused[playerid] > TIME_DIF && g_Requesting[playerid] != true && InvalidStates(playerid) == 1)
	{
		OnPlayerPause(playerid);
	}
        else
	{
        Delete3DTextLabel(Text3D:playertextid);
        }
	return 1;
}


stock InvalidStates(playerid)
{
	new playerState = GetPlayerState(playerid);
    if(playerState == 0 || playerState == 7 || playerState == 9 || playerState == 5 || playerState == 6 || playerState == 4)
    {
        return 0;
	}
	else
	{
	    return 1;
	}
}