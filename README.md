# Ubuntu Desktop Dockerfile

Docker container for Ubuntu 16.04 including ubuntu-desktop and vncserver.

# How to run

`docker run -p 5901:5901 landrzejewski/trainings`

and then connect to:

`vnc://<host>:5901` via VNC client.

The VNC password is `password`.

User: developer
Password: developer

Environment variables

g - vnc geometry (default 1280x800)

Installed software:
- Postgres 9.6
- Node.js
- Git
- Maven
- Oracle Java JDK 8.x
- IntelliJ Ultimate trial version
- Visual Studio Code

