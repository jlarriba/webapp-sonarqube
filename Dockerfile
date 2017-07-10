FROM openjdk:8

ENV APPSETTING_SONAR_VERSION=6.4 \
    APPSETTING_SONARQUBE_HOME=/opt/sonarqube \
    # Database configuration
    # Defaults to using H2
    APPSETTING_SONARQUBE_JDBC_USERNAME=sonar \
    APPSETTING_SONARQUBE_JDBC_PASSWORD=sonar \
    APPSETTING_SONARQUBE_JDBC_URL=

# Http port
EXPOSE 9000

RUN set -x \

    # pub   2048R/D26468DE 2015-05-25
    #       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
    # uid                  sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
    # sub   2048R/06855C1D 2015-05-25
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \

    && cd /opt \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$APPSETTING_SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$APPSETTING_SONAR_VERSION.zip.asc \
    && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    && unzip sonarqube.zip \
    && mv sonarqube-$APPSETTING_SONAR_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $APPSETTING_SONARQUBE_HOME/bin/*

VOLUME "$APPSETTING_SONARQUBE_HOME/data"

WORKDIR $APPSETTING_SONARQUBE_HOME
COPY run.sh $APPSETTING_SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/run.sh"]
