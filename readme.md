# Netgear Orbi ScriptSorcerer

A simple installation script for Netgear Orbi routers that allows running scripts at boot.

## Table of Contents

- [Project Overview](#project-overview)
- [Details](#details)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Uninstall](#uninstall)
- [TBD](#TBD)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

## Project Overview

Netgear Orbi ScriptSorcerer is a set of scripts that enables the automatic execution of scripts at boot on Netgear Orbi routers. It provides a convenient and customizable solution, including an optional auto-updater and a collection of sample scripts with various functionalities.

## Details

The ScriptSorcerer script installs itself into the `/mnt/ntgr/scriptsorcerer` directory, which is one of the few persistent read/write directories available on the Orbi router. It hooks into the boot process by renaming a file that runs on every boot in the writable directories, thereby launching the initialize script and the renamed file. By default, any files with the executable bit set and not prefixed with `~` in the `scriptsorcerer/init` directory or its subdirectories will be executed on boot.

### Prerequisites

- Netgear Orbi router (Tested on RBR20 FW V2.7.4.24)
- Telnet access to your Orbi router

### Installation

1. Step 1: Enable Telnet access on your Orbi router.
    - Follow the directions [here](https://github.com/bkerler/netgear_telnet/tree/main/pyinstaller_native_bins) to enable Telnet access.

2. Step 2: Connect to your Orbi router via Telnet.
    - Use any Telnet software to connect to your Orbi router.

3. Step 3: Run the following one-liner to install ScriptSorcerer:
    ```
    curl -#L https://raw.githubusercontent.com/EnigmaticRadiance/netgear-orbi-scriptsorcerer/main/setup.sh -o /tmp/setup.sh && sh /tmp/setup.sh
    ```

### Usage

Once the installer has set up ScriptSorcerer, you can add scripts to the `/mnt/ntgr/scriptsorcerer/init/` directory or any subdirectory for them to be executed on boot. BE CAREFUL WITH WHAT YOU PUT IN THIS FOLDER! Certain commands can lock you out of the router and force you to factory reset to get back in. You can find some sample scripts [here](https://github.com/EnigmaticRadiance/netgear-orbi-scriptsorcerer/tree/main/sample%20scripts).

The scripts in the `init/mgmt/` directory are related to future features to be added to ScriptSorcerer. The `~autoupdate.sh` script in that folder will compare the latest github release tag to the installed one and if the github release is newer it will overwrite files in the `scriptsorcerer` directory with the files from the latest github version. All other files will remain, as long as no file with the same name and in the same directory exists in the github. The auto-updater can be enabled by renaming it to `autoupdate.sh` with this command:
```
mv /mnt/ntgr/scriptsorcerer/init/mgmt/~autoupdate.sh /mnt/ntgr/scriptsorcerer/init/mgmt/autoupdate.sh
```

## Uninstall

To uninstall ScriptSorcerer from your Netgear Orbi router, simply run the following command:

```sh
sh /mnt/ntgr/scriptsorcerer/uninstall.sh
```

This command will purge every file in the `scriptsorcerer` directory and remove the hook into the boot process.

## TBD
- persist after `/mnt/bitdefender/` wipeout
- one-command install script from url
- add a web ui
- disable analytics?
- kill unnecessary processes?

## Contributing

If you come across any issues, have questions, or want to suggest new features, please open an issue on the GitHub issue tracker.

If you want to contribute code changes, enhancements, or new features, please make a fork and pull request with the desired changes.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE Version 3. You can find the full license text in the [LICENSE](LICENSE) file.

## Credits

I really didn't come up with anything featured on this page. The people at the [Hacking the Netgear Orbi](https://hackingthenetgearorbi.wordpress.com/) blog made this possible. A big thank you goes to all of the people who used that blog to assist in the research done there.