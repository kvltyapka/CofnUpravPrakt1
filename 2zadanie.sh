#!/bin/bash

sort -k2 -n /etc/protocols | tail -n 5 | awk '{print $2, $1}'
