#!/bin/bash

# Source ROS 2 setup
source /opt/ros/humble/setup.bash

# Trap exit signal to run exit script
trap '/exit.sh' EXIT

echo "Container start"

# Start turtlesim in background for 3 seconds
ros2 run turtlesim turtlesim_node &
TURTLE_PID=$!

sleep 3

# Force kill turtlesim to ensure it disappears
pkill -f turtlesim_node

# We'll use a simple sleep loop in background and wait on it.
sleep infinity &
wait $!
