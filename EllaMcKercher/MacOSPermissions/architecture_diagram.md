# Helpers, Login Items & Privileged Tools

<img width="659" height="326" alt="Screenshot 2026-09-02 at 12 19 18" src="https://github.com/user-attachments/assets/3de2b115-6233-407b-8c10-58b456fa7dfc" />

Architecture Diagram

## Important Terminology and Concepts

Helper Processes: These run independently from your main application, but are bundled inside the main application. These processes often perform tasks the main application's sandbox restricts, or they run in the background even when the main application has been closed.
Login Items: These are helpers that automatically launch when the user logs into the Mac, so that things that always should be running can start.
Privileged Tools: These are smaller helpers that have root privileges, so they have access to sensitive permissions. They are typically employed when a sandboxed application needs to perform a sensitive action that requires elevated permissions.
XPC: Apple's Inter-Process Communication channel/system, a way for independent processes to communicate with each other. Essentially, the processes can send each other structured messages (requests) to each other.
