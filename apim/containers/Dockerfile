FROM eclipse-temurin:17-jdk

RUN mkdir -p /opt/wso2am-4.2.0
COPY wso2am-4.2.0 /opt/wso2am-4.2.0
EXPOSE 8243 9443

ENTRYPOINT ["/opt/wso2am-4.2.0/bin/api-manager.sh", "--console"]