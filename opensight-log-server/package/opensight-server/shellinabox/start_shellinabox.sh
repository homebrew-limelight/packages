#!/bin/bash
shellinaboxd --verbose --port=5800 --disable-ssl \
 --css=/etc/shellinabox/options-available/00_White\ On\ Black.css \
 --css=/etc/shellinabox/options-available/01+Color\ Terminal.css \
 --service=/:opsi:opsi:HOME:SHELL \
 --service=/logs:opsi:opsi:HOME:/usr/share/opensight-server/shellinabox/log_service.sh
