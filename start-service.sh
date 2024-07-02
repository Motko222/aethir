#!/bin/bash

source ~/.bash_profile

sudo systemctl restart aethir-checker
tail -f ~/aethir/log/server.log
