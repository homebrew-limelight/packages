#!/bin/bash

source /usr/share/opensight-server/env
LINES_BACKLOG=100

echo "OpenSight-Server $OPENSIGHT_VERSION Logs"
echo ""
echo "Here you will see live logs from OpenSight"
echo "As well as the past $LINES_BACKLOG lines"
echo ""
echo "If you are submitting logs, please use a paste service"
echo "like https://hastebin.com and copy as many logs as possible"
echo ""
echo ""

journalctl --unit=opensight --follow --lines=100 --no-pager | ccze --raw-ansi --options nolookups
