#!/bin/bash

# Source ROS 2 setup for exit script
source /opt/ros/humble/setup.bash

# Start turtlesim again for the exit phase
ros2 run turtlesim turtlesim_node &
TURTLE_PID=$!

# Give it a moment to start up
sleep 2

echo "Container is Stopped..."
ros2 topic pub --rate 10 /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}" &
CIRCLE_PID=$!

# Wait for full circle
sleep 4.5

# Kill the publisher
kill $CIRCLE_PID 2>/dev/null

# Clean up turtlesim
kill $TURTLE_PID 2>/dev/null
pkill -f turtlesim_node

# Only echo stop AFTER it disappear
echo "Container stopped"

exit 0