/// @description Insert description here
// You can write your code in this editor
// Step 3: Retrieving Online Players from Realtime Database

// Create a database reference to the root of the Realtime Database
var databaseRef = realtime_database_get_reference("/");

// Set up a query to retrieve the relevant player data
var query = realtime_database_query_start_at(databaseRef);

// Listen for changes in the database reference
realtime_database_query_observe_event(query, "value", function(data) {
    // Get the updated player data
    var playerData = data.val();
    
    // Filter the retrieved player data based on the password matching criteria
    var filteredPlayerData = ds_map_create();
    var joiningPlayerPassword = "joinPassword"; // Replace with the joining player's password
    
    // Loop through each player data entry
    ds_map_for_each(playerData, function(key, player) {
        var playerPassword = player[? "Game Password"];
        
        // Check if the player has no password or has the same password as the joining player
        if (playerPassword == "" || playerPassword == joiningPlayerPassword) {
            ds_map_replace(filteredPlayerData, key, player);
        }
    });
    
    // Use the filtered player data as needed in your game
    // ...
});
