import os
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import LaserScan
from yaml import load, Loader
from ament_index_python.packages import get_package_share_directory
import math
import numpy as np
from geometry_msgs.msg import Twist
from std_srvs.srv import SetBool


class subscriberPW4(Node):

    def __init__(self):
        super().__init__('scan_subscriber_pw4')

        # Déclarer les paramètres avec les valeurs récupérées
        self.declare_parameter('my_parameter', 'scan')
        self.declare_parameter('my_queue', 10)

        # self.declare_parameters(
        # namespace='',
        # parameters=[
        # ('my_parameter', rclpy.Parameter.Type.STRING),
        # ('my_queue', rclpy.Parameter.Type.INTEGER)
        # ])

        self.publisher = self.create_publisher(Twist, 'cmd_vel', 50)
        self.subscription_ = self.create_subscription(LaserScan,"scan",self.subscriber_callback,10)
        self.get_logger().info("Scan subscriber node has been started")

    def subscriber_callback(self,msg):
        #my_parameter = self.get_parameter("my_parameter").value
        #my_queue = self.get_parameter("my_queue").value
        #ranges = msg.ranges
        #min_distance = min(ranges)

        i = 0
        angle = msg.angle_min
        range_pillar = msg.range_max
        while (angle < msg.angle_max) :
            if (msg.ranges[i] < range_pillar):
                range_pillar = msg.ranges[i]
                angle_pillar = angle
            angle += msg.angle_increment
            i+=1

        x = np.cos(angle_pillar)*range_pillar
        y = np.sin(angle_pillar)*range_pillar
        print("X = ", x, " // Y = ", y)

        twist_msg = Twist()
        while (twist_msg.angular.z < 0.02 and twist_msg.angular.z > -0.02) :
            twist_msg.angular.z = y
        twist_msg.linear.x = 0.5*x # set linear velocity
        self.publisher.publish(twist_msg)



def main(args=None):
    rclpy.init(args=args)
    scan_subscriber_pw4 = subscriberPW4()
    rclpy.spin(scan_subscriber_pw4)
    rclpy.shutdown()

if __name__ == "__main__":
    main()
