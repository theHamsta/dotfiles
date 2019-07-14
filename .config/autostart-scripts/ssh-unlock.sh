#! /bin/sh
#
# ssh-unlock.sh
# Copyright (C) 2019 Stephan Seitz <stephan.seitz@fau.de>
#
# Distributed under terms of the GPLv3 license.
#



#!/bin/bash
SSH_ASKPASS=/usr/bin/ksshaskpass ssh-add $HOME/.ssh/id_rsa </dev/null
