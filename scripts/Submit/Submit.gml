// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Submit(){
// Step 2: Submitting Player Information to Realtime Database

// Retrieve the authenticated user's unique ID
var userID = FirebaseAuthentication_GetUserID();

// Create a new database reference using the User ID as the key
var databaseRef = realtime_database_get_reference("User ID/" + userID);

// Get the player information from the user using get_string
var playerName = get_string("Enter your player name:", "");
var gamePassword = get_string("Enter your game password:", "");
var mapID = get_string("Enter your map ID:", "");
var connectedPlayerCount = get_string("Enter current connected player count:", "");
var maxAllowedPlayers = get_string("Enter max allowed players:", "");

// Set the player data fields
realtime_database_set_value(databaseRef + "/Player Name", playerName);
realtime_database_set_value(databaseRef + "/Game Password", gamePassword);
realtime_database_set_value(databaseRef + "/Map ID", mapID);
realtime_database_set_value(databaseRef + "/Current Connected Player Count", connectedPlayerCount);
realtime_database_set_value(databaseRef + "/Max Allowed Players", maxAllowedPlayers);

// Update the database with the new player information
realtime_database_update();

}