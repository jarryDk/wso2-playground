FROM eclipse-temurin:17-jdk

RUN mkdir -p /opt/wso2am-4.2.0
COPY wso2am-4.2.0 /opt/wso2am-4.2.0

# expose ports
EXPOSE 9763 9443 9999 11111 8280 8243 5672 9711 9611 9099

ENTRYPOINT ["/opt/wso2am-4.2.0/bin/api-manager.sh", "--console"]