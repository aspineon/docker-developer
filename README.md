# Ubuntu Desktop Dockerfile

Docker container for Ubuntu 16.04 including ubuntu-desktop and vncserver.

# How to run

`docker run -p 5901:5901 landrzejewski/trainings`

and then connect to:

`vnc://<host>:5901` via VNC client.

The VNC password is `password`.

Environment variables

g - vnc geometry (default 1280x800)
d - depth (default 24)

