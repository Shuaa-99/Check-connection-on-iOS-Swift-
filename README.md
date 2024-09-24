# CheckVpnConnection

**CheckVpnConnection** is a simple app built using SwiftUI that checks the VPN connection status on the user's device. The app uses the `CFNetwork` library to check for active VPN protocols and shows an alert if a connection is active.

## Features

- **VPN Status Check**: The app checks for VPN connection status when it starts or when the user presses the "Check VPN Status" button.
- **Alert for Active VPN**: If an active VPN connection is detected, an alert will appear with an error message and an option to close the app.


## Structure

- **VpnChecker**: A struct that checks if a VPN connection is active.
- **VpnViewModel**: A data model that checks the VPN status and updates the user interface.
- **ContentView**: The main interface of the app, displaying the VPN status and allowing users to check it manually.

