#!/bin/bash
set -e

sudo /bin/bash -c "cat $HOME/.assets/lists/etc-environment > /etc/environment"
