#!/bin/bash

source /usr/share/opensight-server/env

echo "OpenSight $(tput setaf 2)$OPENSIGHT_VERSION$(tput sgr0) Shell"
echo ""
echo "Default username: $(tput setaf 1)opsi$(tput sgr0)"
echo "Default password: $(tput setaf 1)opensight$(tput sgr0)"
echo ""
echo ""

exec login -f opsi
