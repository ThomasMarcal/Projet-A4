import rclpy
from rclpy.node import Node
from sensor_msgs.msg import LaserScan
from std_srvs.srv import SetBool
from functools import partial

class ObstacleStopperNode(Node):
    def __init__(self):
        super().__init__('obstacle_stopper')
        self.laser_callback()
        self.create_subscription(LaserScan, 'laser_scan', self.laser_callback, 1000)
        self.get_logger().info('Obstacles detection')
    
    def laser_callback(self, msg,data):
        client = self.create_client(SetBool, 'stop_robot')
        # Check if robot is too close to an obstacle
        range_pillar = msg.range_max
        if range_pillar < 1:
            # Call stop_robot service to stop robot
            request = SetBool.Request()
            request.data = True
            future = client.call_async(request)
            future.add_done_callback(partial(self.stop_robot_callback,msg,data))

    def stop_robot_callback(self, future):
        try:
            response = future.result()
            self.get_logger().info('Robot stopped' + str(response))
        except Exception as e:
            self.get_logger().error("Service call failed %r" % (e,))

def main(args=None):
    rclpy.init(args=args)
    node = ObstacleStopperNode()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == '__main__':
    main()


"""
import rclpy
from rclpy.node import Node
from functools import partial
from std_srvs.srv import SetBool
import sys

class MinimalClientNode(Node):
    def __init__(self):
        super().__init__("minimal_client")
        self.call_add_two_ints_server()
    
    def call_add_two_ints_server(self):
        client = self.create_client(SetBool, 'stop_robot')
        while not client.wait_for_service(1.0):
            self.get_logger().warn("Waiting for server add two ints...")
        request = SetBool.Request()
        future = client.call_async(request) # asynchronous call + future object
        future.add_done_callback(partial(self.callback_call_add_two_ints)) # add a callback to be run when
    # the future is done + partial function

    def callback_call_add_two_ints(self, future):
        try:
            response = future.result() # may throw an exception
            self.get_logger().info("aaaaaaaaaaa")
        except Exception as e:
            self.get_logger().error("Service call failed %r" % (e,))

def main(args=None):
    rclpy.init(args=args)
    node = MinimalClientNode()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == "__main__":
    main()
"""