import rclpy
from rclpy.node import Node
from sensor_msgs.msg import LaserScan
from std_srvs.srv import SetBool
from functools import partial
import sys 

class ObstacleDetector(Node):

    def __init__(self):
        super().__init__('obstacle_detector')
        self.declare_parameter("topic_name","scan")
        self.subscription = self.create_subscription(LaserScan, self.get_parameter("topic_name").value, self.call_robot_stop, 10)


    def call_robot_stop(self, msg):
        my_param1 = self.get_parameter("topic_name").value

        if min(msg.ranges) < 1.5:
            self.call_robot_server(True)
            self.get_logger().info('Fin')


    def call_robot_server(self, data):
        client = self.create_client(SetBool, 'stop_robot')
        
        while not client.wait_for_service(timeout_sec=1.0):
            self.get_logger().info('Service not available, waiting again...')
        
        stop_robot_request = SetBool.Request()
        stop_robot_request.data = data
        future = client.call_async(stop_robot_request)
        future.add_done_callback(partial(self.callback_call_robot, data=data))
        
    def callback_call_robot(self,future,data) :
        try:
            response = future.result()
            self.get_logger().info('Robot stopped' + str(data))
        except Exception as e:
            self.get_logger().error("Service call failed %r" % (e,))
            

def main(args=None):
    rclpy.init(args=args)
    obstacle_detector = ObstacleDetector()
    rclpy.spin(obstacle_detector)
    obstacle_detector.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
