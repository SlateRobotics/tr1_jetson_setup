#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade -y

echo "Installing ROS Kinetic"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full -y
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential xboxdrv -y
sudo apt-get install ros-kinetic-moveit ros-kinetic-joy ros-kinetic-ros-control ros-kinetic-ros-controllers -y

echo "Installing TR1 Packages"
mkdir ~/ros_ws
mkdir ~/ros_ws/src
cd ~/ros_ws/src
echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
git clone https://github.com/slaterobotics/tr1_essentials
git clone https://github.com/slaterobotics/tr1_xbox_teleop
git clone https://github.com/slaterobotics/tr1_keyboard_teleop
cd ~/ros_ws
catkin_make
source ~/.bashrc

echo "Configuring environment"
echo 'ACTION=="add", KERNEL=="i2c-[0-1]*", MODE="0666"' | sudo tee /etc/udev/rules.d/local.rules


echo "Install complete. You may now reboot the device"
