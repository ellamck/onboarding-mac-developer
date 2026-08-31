# TCC System Overview

TCC stands for Transparency, Consent, and Control. IT is macOS's privacy and permission framework, and it handles the decisions for whether an application is allowed to access sensitive resources (for example, location, or microphone).

If an application tries to access a protected resource, like using the camera or a file, macOS will intercept it at the system level before access is granted.

If the application has never asked for the permission before, the TCC framework will show the permission pop-up, explaining what the application is requesting, and why it needs access to the resource. The response (accept or deny) is recorded in TCC.db, a protected database. So after approval, the user does not have to accept or deny each time. However, they can revert the setting anytime in System Settings > Privacy & Security.

TCC protects the following:

- Files
- Folders
- Location services
- Accessibility controls
- Automation
- Contacts
- Calendars
- Reminders
- Camera
- Microphone
- Full Disk Access
