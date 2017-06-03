# Ubuntu Desktop + Developer tools

Docker container for Ubuntu 16.04 including ubuntu-desktop, vncserver and dveloper tools.

# How to run

`docker pull landrzejewski/developer`
`docker run --privileged -v ~/share/:/home/developer/share/ -p 5901:5901 landrzejewski/developer`

and then connect to:

`vnc://<host>:5901` via VNC client.

The VNC password is `dconDevE`.

# Info

- User: developer
- Password: dconDevE

Environment variables

- g - vnc geometry (default 1280x800)

Exposed ports: 8080-8100

--privileged - fix for Chrome 

# Installed software:

- Postgres
- Node.js
- Git
- Maven
- Oracle Java JDK
- IntelliJ Ultimate trial version
- Visual Studio Code
- Chrome
- Tomcat