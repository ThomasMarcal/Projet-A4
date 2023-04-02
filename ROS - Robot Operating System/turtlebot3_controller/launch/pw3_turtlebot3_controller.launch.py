import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import PathJoinSubstitution
from launch_ros.substitutions import FindPackageShare

from launch_ros.actions import Node

def generate_launch_description():

    config = PathJoinSubstitution([FindPackageShare('turtlebot3_controller'),'config/params.yaml'])
    return LaunchDescription([
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource([
                PathJoinSubstitution([
                    FindPackageShare('turtlebot3_gazebo'),
                    'launch/turtlebot3_world.launch.py'
                ])
            ])
        ),
        Node(
            package = 'teleop_twist_keyboard',
            executable = 'teleop_twist_keyboard',
            prefix = "/usr/bin/gnome-terminal --"
        ),
        Node(
            package = 'turtlebot3_controller',
            executable = 'scan_subscriber',
            parameters = [config],
            prefix = "/usr/bin/gnome-terminal --"
        )
    ])
