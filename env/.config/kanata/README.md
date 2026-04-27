## 1. Download and Install Kanata
The best way to install Kanata is via Homebrew:

`brew install Kanata`

You’ll also need to install the ![Karabiner VirtualHIDDevice driver](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/tree/main), as Kanata relies on it to interact with macOS. Download the installer and follow the instructions there.

### Mac System Permissions
General -> Login Items & Extensions -> Extensions -> .Karabiner-VirtualHIDDevice-Manager
General -> Login Items & Extensions -> App Background Active -> Fumihiko Takayama
General -> Login Items & Extensions -> App Background Active -> kanata


- Note: use `cmd + shift + g` to get the path: `/opt/homebrew/Cellar/kanata/1.11.0/bin/kanata`
Privacy & Security -> Accessibility -> kanata
Privacy & Security -> Input Monitoring -> kanata


## 2. Create a .kbd File for Your Kanata Layout
The kbd format is much more readable than the json format used by Karabiner

See Kanata configuration file documentation and very commented examples to create your own.

You can store the .kbd file anywhere. I keep mine in `~/.config/Kanata/` to manage it with a private GitHub repository.


## 3. Using launchctl to Run Kanata on Startup and in the Background of macOS

`com.example.karabiner-vhiddaemon.plist`

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.karabiner-vhiddaemon</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
```

`com.example.karabiner-vhidmanager.plist`

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.karabiner-vhidmanager</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager</string>
        <string>activate</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
```


`com.example.kanata.plist`

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.kanata</string>

    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/kanata</string>
        <string>-c</string>
        <string>/Users/jacob/.config/kanata/kanata.kbd</string>
        <string>--port</string>
        <string>10000</string>
        <string>--debug</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/Library/Logs/Kanata/kanata.out.log</string>

    <key>StandardErrorPath</key>
    <string>/Library/Logs/Kanata/kanata.err.log</string>
</dict>
</plist>
```

## 4. Starting the LaunchDaemons
Once you’ve created the files, use the following commands to load the LaunchDaemons:

```
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

This method ensures Kanata runs automatically in the background without needing to launch it manually after every reboot.

That's it… it should be running just fine after a few seconds.

## 5. Stopping the LaunchDaemons
In case you need to stop Kanata from running via launchctl, use at the terminal:

`sudo launchctl bootout system /Library/LaunchDaemons/com.example.kanata.plist`
Of course, to interrupt at any time, press left control + space + escape at their original positions.
