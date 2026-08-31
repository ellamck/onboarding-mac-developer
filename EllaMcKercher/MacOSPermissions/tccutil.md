# TCC Util CL Tool

This is a command-line (CL) tool for managing TCC permissions.

## Base command

`tccutil reset <service> [bundle-identifier]`

| Service                     | Permission it resets       |
| --------------------------- | -------------------------- |
| Camera                      | Camera                     |
| Microphone                  | Microphone                 |
| SystemPolicyAllFiles        | Full Disk Access           |
| Photos                      | Photos Library             |
| Accessibility               | Accessibility Permissions  |
| SystemPolicyDesktopFolder   | Desktop Folder access      |
| AppleEvents                 | AppleEvents and Automation |
| SystemPolicyDocumentsFolder | Documents Folder access    |
| SystemPolicyDownloadsFolder | Downloads Folder access    |
| Contacts                    | Contacts                   |
| Calendar                    | Calendar                   |
| Reminders                   | Reminders                  |
| Location                    | Location Services          |

From my Swift application earlier, an example command:

`tccutil reset Photos onboarding.TCCPerms`

Note, if you do not add the bundle identifier, you reset for ALL applications. This needs to be used with caution!
