#!/bin/bash

set -e

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

exec java -jar lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$APPSETTING_SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$APPSETTING_SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$APPSETTING_SONARQUBE_JDBC_URL" \
  -Dsonar.web.javaAdditionalOpts="$APPSETTING_SONARQUBE_WEB_JVM_OPTS -Djava.security.egd=file:/dev/./urandom" \
  "$@"
