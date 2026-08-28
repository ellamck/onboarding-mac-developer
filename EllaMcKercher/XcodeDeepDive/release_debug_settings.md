# Summary of Release vs. Debug Settings

## Debug Settings

In Build Settings, debug settings are for when you are developing and testing your project/app. They typically already run when "Run" is clicked by default.

When this setting is in place, assertions run normally, debugging symbols are included (breakpoints and lldb for example), and the DEBUG compiler will be set. You can view the console, the variables, edit the debug workflow, etc.

## Release Settings

This build setting is for when you are releasing the app, like submitting it to the App Store or to production. It tries to compile as fast as possible, it is harder to debug because debug symbols are minimized, and assertions are disabled (if you are shipping your app, you do not want crashes)! Unlike the Debug Settings, the DEBUG flag will also not be set.

## What is a Scheme

A Scheme decides which build configuration is applied when you take a specific action, like Run, or Test. Build Settings are the actual build definitions and rules, whilst Schema are the Build Settings to use for each action.
