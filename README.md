# ROS 2 Humble Turtlesim Docker Demo

This project demonstrates running ROS 2 Humble Turtlesim nodes within a Docker container, featuring ephemeral "popup" instances on startup and shutdown.

## Overview

The project uses Docker Compose to orchestrate a containerized ROS 2 environment. It showcases:
- **ROS 2 Humble** base image.
- **Turtlesim** installation and execution.
- **Custom signal handling** to perform actions on container stop.
- **GUI forwarding** to the host system.

## Project Structure

- `docker-compose.yml`: Defines the service configuration, environment variables for display, and volume mounts.
- `Dockerfile`: Builds the image based on `ros:humble`, installing `ros-humble-turtlesim` and other utilities.
- `scripts/entry.sh`: The main entrypoint script. It:
    - Sets up a trap to catch termination signals (`SIGTERM`, `SIGINT`, `SIGQUIT`).
    - Sources the ROS 2 setup.
    - Runs a `turtlesim_node` instance for 3 seconds (simulating a startup popup).
    - Enters an infinite idle loop to keep the container running.
- `scripts/exit.sh`: The cleanup script called by the signal handler. It:
    - Sources the ROS 2 setup.
    - Runs a `turtlesim_node` instance for 3 seconds (simulating a shutdown popup).

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- An X server running on your host machine to display the GUI.

## Usage

### 1. Allow X Server Connections

Before running the container, you may need to allow local connections to your X server.

**On Linux:**
```bash
xhost +local:root
```

### 2. Build and Run

Use Docker Compose to build the image and start the service:

```bash
docker compose up --build
```

You should see a Turtlesim window appear for 3 seconds and then close. The container will remain running.

### 3. Stop the Container

To stop the container and trigger the exit script:

```bash
docker compose down
```
*OR press `Ctrl+C` if running in the foreground.*

Upon stopping, you will see another Turtlesim window appear for 3 seconds (the exit popup) before the container fully terminates.

## Configuration

The `docker-compose.yml` is configured to forward the host's X11 display to the container.

```yaml
environment:
  - DISPLAY=${DISPLAY}
  - QT_X11_NO_MITSHM=1

volumes:
  - /tmp/.X11-unix:/tmp/.X11-unix:rw
```

**Important:** On Linux, you must allow the container to access your X server. The most common way is:

```bash
xhost +local:root
```

This command allows the root user on the local machine (which the container process often maps to) to connect to the X server.
