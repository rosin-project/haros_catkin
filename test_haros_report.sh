#!/bin/bash

cd /root/downstream_ws
catkin build test_pkg --verbose --no-deps --make-args haros_report
