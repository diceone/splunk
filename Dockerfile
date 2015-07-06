FROMM centos:latest

MAINTAINER Dr. Doom <doom@dev-ops.de>

#install wget
RUN yum install -y wget


#install splunk using .rpm package
RUN wget "https://www.splunk.com/page/download_track?file=6.2.3/splunk/linux/splunk-6.2.3-264376-linux-2.6-x86_64.rpm&platform=Linux&architecture=x86_64&version=6.2.3&product=splunk&typed=release&name=linux_installer&d=pro&wget=true" -O splunk.rpm

RUN yum localinstall -y /splunk.rpm

#create the splunk service as root
RUN /opt/splunk/bin/splunk enable boot-start --accept-license
RUN chmod 755 /etc/init.d/splunk #give read/execute to non-root users (like splunk user)
RUN chown -R splunk:splunk /opt/splunk #enable boot-start creates a bunch of stuff as root, so re-chown the whole splunk dir to splunk:splunk

USER splunk

EXPOSE 8000 8089 9997 514 10001 10002 10003 10004 10005

VOLUME ["/opt/splunk/var", "/data", "/license"]

