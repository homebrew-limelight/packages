#!/bin/bash

source /usr/share/opensight-server/env

shellinaboxd --quiet --port=5800 --disable-ssl --no-beep \
 --css=/etc/shellinabox/options-available/00_White\ On\ Black.css \
 --css=/etc/shellinabox/options-available/01+Color\ Terminal.css \
 --static-file=favicon.ico:$OPENSIGHT_FAVICON \
 --service=/:root:root:HOME:/usr/share/opensight-server/shellinabox/opsi_shell.sh \
 --service=/logs:opsi:opsi:HOME:/usr/share/opensight-server/shellinabox/log_service.sh
