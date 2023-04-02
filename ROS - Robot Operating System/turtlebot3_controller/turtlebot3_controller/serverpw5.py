import rclpy
from rclpy.node import Node
from std_srvs.srv import SetBool
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist
import numpy as np 



class ServerPW5(Node):
    def __init__(self):
        super().__init__('serverpw5')
        self.publisher = self.create_publisher(Twist, 'cmd_vel', 10)
        self.subscription = self.create_subscription(LaserScan, 'scan', self.subscriber_callback, 10)
        self.start_stop_service = self.create_service(SetBool, 'stop_robot', self.start_stop_callback)
        self.get_logger().info("Scan subscriber node has been started")
        self.arrete=False

    def start_stop_callback(self, request, response):
        self.arrete=request.data
        if request.data :
            self.get_logger().info('Starting TurtleBot3...')
            # Code to start TurtleBot3
            response.success = True
            response.message = 'TurtleBot3 started'
        else:
            self.get_logger().info('Stopping TurtleBot3...')
            # Code to stop TurtleBot3
            response.success = True           
            response.message = 'TurtleBot3 stopped'       
        return response

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
        print("X = ", x, " / Y = ", y)

        twist_msg = Twist()
        
        if not(self.arrete):
            if ((angle > 2*np.pi-0.3) & (angle > 0.3)) :
                twist_msg.linear.x = 0.2
            else : 
                if (angle > np.pi) :
                    twist_msg.angular.z = -0.1
                else :
                    twist_msg.angular.z = 0.1
        self.publisher.publish(twist_msg)




def main(args=None):
    rclpy.init(args=args)
    serverpw5 = ServerPW5()
    rclpy.spin(serverpw5)
    serverpw5.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()




"""
    def laser_callback(self, msg):
        # Store laser ranges for processing later
        self.laser_ranges = msg.ranges

    def stop_robot(self):
        # Stop the TurtleBot3 robot
        cmd_vel_msg = Twist()
        self.cmd_vel_pub.publish(cmd_vel_msg)

    def check_obstacle(self):
        if self.laser_ranges:
            # Check if there is an obstacle closer than min_dist
            closest_dist = min(self.laser_ranges)
            if closest_dist < self.min_dist:
                # If robot is running, stop it
                if self.get_service_client('/emergency_stop_server/stop_robot', SetBool).call(False).success:
                    self.stop_robot()
"""