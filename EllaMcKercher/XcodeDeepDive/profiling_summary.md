# Profiling Summary

## CPU Usage

<img width="1718" height="951" alt="Screenshot 2026-08-28 at 14 31 01" src="https://github.com/user-attachments/assets/7e5eae5e-d78b-4fa8-a549-908b9214c72f" />

<img width="987" height="612" alt="Screenshot 2026-08-28 at 14 31 33" src="https://github.com/user-attachments/assets/d49ebbd2-8ffe-470e-a8d6-e74f3bc4fcff" />

There are two clear spikes at the very start and at the end. The app likely used CPU when it launched and when I quit the app, which made sense because the application I was running was the simple swift macOS app that just previews "Hello, App!" 

It also makes sense that the thermal state panel shows "nominal" because this is a normal simple app.

The Heaviest Stack Trace, on the bottom right panel, showed where the CPU cycles were actually spent (Application run, and Xcode Practice). 

## Time Usage

<img width="1481" height="1001" alt="Screenshot 2026-08-28 at 14 40 19" src="https://github.com/user-attachments/assets/bed11444-c6be-462b-ac66-982863bfb70c" />

The process creation (Xcode Practice) can be seen at the beginning during the application launch (the purple beginning bar prior to the successful running green bar). The majority of the time was spent on the app's main thread, and this makes sense as I simply just opened the app and then closed it. The Heaviest Stack Trace window also makes sense, as the main function was one of the heaviest contributors (again, this was a simple app-open). 
