FROM maven:3.6.3-jdk-11-slim AS build
WORKDIR /usr/src/app
COPY pom.xml .
RUN mvn verify clean --fail-never
COPY src ./src
RUN mvn package -Dmaven.test.skip

FROM openjdk:11-jdk-slim
COPY --from=build /usr/src/app/target/cp-helper-1.41.jar /usr/local/bin/cp-helper.jar
COPY ./src/etc /etc
EXPOSE 9999
ENTRYPOINT java $JVM_OPTS -DsettingsDir=/etc/cp-helper -jar /usr/local/bin/cp-helper.jar
