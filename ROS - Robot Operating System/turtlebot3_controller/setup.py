import os
from glob import glob
from setuptools import setup

package_name = 'turtlebot3_controller'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name), glob('launch/pw4_turtlebot3_controller.launch.py')),
        #(os.path.join('share', package_name, 'launch'), glob('launch/*.launch.py')),
        #(os.path.join('share', package_name, 'config'), glob('config/*.yaml'))
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='thomas',
    maintainer_email='thomas@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            "scan_subscriber = turtlebot3_controller.scan_subscriber:main",
            "scan_subscriber_pw4 = turtlebot3_controller.scan_subscriber_pw4:main",
            'serverpw5 = turtlebot3_controller.serverpw5:main',
            'question3 = turtlebot3_controller.question3:main',
            'client = turtlebot3_controller.client:main',
        ],
    },
)
