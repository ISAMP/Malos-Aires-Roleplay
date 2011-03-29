/*
	Release:
  		» RyDeR's Object Streamer

	Version:
		» v0.1a

	Functions:
		» CreateStreamedObject(Model, Float: pX, Float: pY, Float: pZ, Float: rX, Float: rY, Float: rZ, Float: ViewDistance);
		» DestroyStreamedObject(Model);
		» MoveStreamedObject(Model, Float: pX, Float: pY, Float: pZ, Float: Speed);
		» StopStreamedObject(Model);
		» SetStreamedObjectPos(Model, Float: pX, Float: pY, Float: pZ);
		» SetStreamedObjectRot(Model, Float: rX, Float: rY, Float: rZ);
		» GetStreamedObjectPos(Model, Float: rX, Float: rY, Float: rZ);
		» GetStreamedObjectRot(Model, Float: rX, Float: rY, Float: rZ);
		» IsValidStreamedObject(Modela)

	Credits:
		» -
*/


forward CreateStreamedObject(Model, Float: pX, Float: pY, Float: pZ, Float: rX, Float: rY, Float: rZ, Float: ViewDistance);
public CreateStreamedObject(Model, Float: pX, Float: pY, Float: pZ, Float: rX, Float: rY, Float: rZ, Float: ViewDistance)
{
	return CallRemoteFunction("Temp_CreateStreamedObject", "ifffffff", Model, Float: pX, Float: pY, Float: pZ, Float: rX, Float: rY, Float: rZ, Float: ViewDistance);
}


forward DestroyStreamedObject(Model);
public DestroyStreamedObject(Model)
{
	return CallRemoteFunction("Temp_DestroyStreamedObject", "i", Model);
}

forward MoveStreamedObject(Model, Float: pX, Float: pY, Float: pZ, Float: Speed);
public MoveStreamedObject(Model, Float: pX, Float: pY, Float: pZ, Float: Speed)
{
	return CallRemoteFunction("Temp_MoveStreamedObject", "iffff", Model, Float: pX, Float: pY, Float: pZ, Float: Speed);
}

forward StopStreamedObject(Model);
public StopStreamedObject(Model)
{
	return CallRemoteFunction("Temp_StopStreamedObject", "i", Model);
}

forward SetStreamedObjectPos(Model, Float: pX, Float: pY, Float: pZ);
public SetStreamedObjectPos(Model, Float: pX, Float: pY, Float: pZ)
{
	return CallRemoteFunction("Temp_SetStreamedObjectPos", "ifff", Model, Float: pX, Float: pY, Float: pZ);
}

forward SetStreamedObjectRot(Model, Float: rX, Float: rY, Float: rZ);
public SetStreamedObjectRot(Model, Float: rX, Float: rY, Float: rZ)
{
	return CallRemoteFunction("Temp_SetStreamedObjectRot", "ifff", Model, Float: rX, Float: rY, Float: rZ);
}


forward GetStreamedObjectPos(Model, Float: pX, Float: pY, Float: pZ);
public GetStreamedObjectPos(Model, Float: pX, Float: pY, Float: pZ)
{
	return CallRemoteFunction("Temp_GetStreamedObjectPos", "ifff", Model, Float: pX, Float: pY, Float: pZ);
}

forward GetStreamedObjectRot(Model, Float: rX, Float: rY, Float: rZ);
public GetStreamedObjectRot(Model, Float: rX, Float: rY, Float: rZ)
{
	return CallRemoteFunction("Temp_GetStreamedObjectRot", "ifff", Model, Float: rX, Float: rY, Float: rZ);
}

stock IsValidStreamedObject(Model)
{
	return CallRemoteFunction("Temp_IsValidStreamedObject", "i", Model);
}