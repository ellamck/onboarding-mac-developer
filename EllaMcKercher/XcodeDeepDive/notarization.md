# Notarization Tools

## Notarization

Notarization is the process of submitting your application to Apple for approval. If approved, Apple will create a notarization ticket that indicates the application is safe from malicious/harmful content and known security vulnerabilities. Apple's macOS built-in security system Gatekeeper can now trust your application.

This process is basically validating that the application's content does not have malware or harmful content before distributing to users. This is required for any macOS application distributed outside the Mac App Store.

## Steps

1. Submit your signed and built application to Apple's notarization service, done via CL `notarytool`
2. Apple will return a result of either approval with a notarization ticket, or rejected, with an explanation of why it failed
3. If approved, you will need to staple the ticket to your application, so that the application bundle can be verified easily
4. Then, each time whenever someone tries to open your app, Gatekeeper will check for this ticket.

## Tools

**notarytool**
This is Apple's CL tool for notarizing applications. Example:
`xcrun notarytool submit YourApp.zip --apple-id your@email.com --team-id TEAMID --password app-specific-password --wait`

**stapler**
This is post-approval, where you add the ticket directly to your application for Gatekeeper.
`xcrun stapler staple YourApp.app`
