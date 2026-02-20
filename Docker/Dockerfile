FROM ros:humble

# Install Zenity for GUI dialogs
RUN apt-get update && apt-get install -y \
    ros-humble-turtlesim \
    iproute2 \
    zenity \
    dbus-x11 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    && rm -rf /var/lib/apt/lists/*
