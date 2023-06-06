/// obj_SignUpPopup Create Event

email = get_string("Enter your email:", "");
password = get_string("Enter your password:", "");

var listenerId = FirebaseAuthentication_LinkWithEmailPassword("test@r.com","password");
// Store the listener ID for tracking progress

// Add any additional code or actions you want to perform after initiating sign-up

// Destroy the pop-up
instance_destroy();
