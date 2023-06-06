/// @description Insert description here
// You can write your code in this editor
// Step 4: Establishing Peer-to-Peer Connection

// Assume you have the hosting player's unique ID (hostingPlayerID)
var hostingPlayerID = "hostingPlayerID"; // Replace with the actual hosting player's ID

// Create a database reference to the hosting player's data
var hostingPlayerRef = realtime_database_get_reference("User ID/" + hostingPlayerID);

// Retrieve the IP address field from the hosting player's data
var ipAddress = realtime_database_get_value(hostingPlayerRef + "/IP Address");

// Use the retrieved IP address to establish a peer-to-peer connection
// ...

