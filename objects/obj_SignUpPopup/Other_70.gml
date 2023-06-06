/// @description Insert description here
// You can write your code in this editor
if (async_load[? "id"] == listenerId)
{
    if (async_load[? "status"] == 200)
    {
        show_debug_message("Signed up successfully!");
    }
    else
    {
        show_debug_message(async_load[? "errorMessage"]);
    }
}