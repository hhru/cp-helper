FROM maven:3.6.3-jdk-11-slim AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:11-jdk-slim
COPY --from=build /usr/src/app/target/cp-helper-4.22.20.jar /usr/local/bin/cp-helper.jar
COPY ./src/etc /etc
EXPOSE 9999
ENTRYPOINT ["java", "-DsettingsDir=/etc/cp-helper", "-jar","/usr/local/bin/cp-helper.jar"]
