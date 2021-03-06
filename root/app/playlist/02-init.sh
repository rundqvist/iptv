#!/bin/sh

mkdir -p /www/

> /www/playlist.m3u8
echo "#EXTM3U x-tvg-url=\"http://$(var HOST_IP):8880/epg.xml\"" >> /www/playlist.m3u8

for service in $(var IPTV_SERVICES)
do
    log -v "Adding service $service"
    for channel in $(var -k iptv.channel $service)
    do
        log -v "Adding channel $channel"
        #echo "" >> /www/playlist.m3u8
        echo "#EXTINF:-1 tvg-id=\"$(var -k channel.port $channel)\" tvg-name=\"$(var -k channel.name $channel)\",$(var -k channel.name $channel)" >> /www/playlist.m3u8
        #echo "#EXTINF:-1 tvg-id=\"$(var -k channel.port $channel)\" tvg-name=\"$(var -k channel.name $channel)\"" >> /www/playlist.m3u8
        echo "http://$(var HOST_IP):1935/$(var -k channel.port $channel).ts" >> /www/playlist.m3u8
        
    done
done

exit 0;
