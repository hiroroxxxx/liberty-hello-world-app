#IMAGE: Get the base image for Liberty
FROM websphere-liberty:19.0.0.9-kernel

#RUN featureManager install servlet-4.0 --when-file-exists=ignore --acceptLicense

#BINARIES: Add in all necessary application binaries
COPY wlp/config/server.xml /config/server.xml
USER root
RUN chown 1001:0 /config/server.xml
USER 1001

COPY repositories.properties /opt/ibm/wlp/etc/repositories.properties
USER root
RUN chown 1001:0 /opt/ibm/wlp/etc
RUN chown 1001:0 /opt/ibm/wlp/etc/repositories.properties
USER 1001

ARG VERBOSE=true

# Generate Liberty config based on server.xml
RUN configure.sh

ADD target/hw-web.war /opt/ibm/wlp/usr/servers/defaultServer/apps
