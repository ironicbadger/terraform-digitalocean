#!/bin/bash

dnf update -y
dnf install python ansible -y
systemctl reboot