import os
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import LaserScan
from yaml import load, Loader
from ament_index_python.packages import get_package_share_directory

class subscriber(Node):

    def __init__(self):
        super().__init__('scan_subscriber')

        # Déclarer les paramètres avec les valeurs récupérées
        self.declare_parameter('my_parameter', 'scan')
        self.declare_parameter('my_queue', 10)

#        self.declare_parameters(
#           namespace='',
#           parameters=[
#               ('my_parameter', rclpy.Parameter.Type.STRING),
#               ('my_queue', rclpy.Parameter.Type.INTEGER)
#           ])

        self.subscription_ = self.create_subscription(LaserScan,self.get_parameter("my_parameter").value,self.subscriber_callback,self.get_parameter("my_queue").value)
        self.get_logger().info("Scan subscriber node has been started")

    def subscriber_callback(self,msg):
        #my_parameter = self.get_parameter("my_parameter").value
        #my_queue = self.get_parameter("my_queue").value
        ranges = msg.ranges
        min_distance = min(ranges)
        print("Minimum distance measurement : ", min_distance)

def main(args=None):
    rclpy.init(args=args)
    scan_subscriber = subscriber()
    rclpy.spin(scan_subscriber)
    rclpy.shutdown()

if __name__ == "__main__":
    main()
