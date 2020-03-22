FROM maven:3.6.3-jdk-11-slim
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package
EXPOSE 9999
ENTRYPOINT ["java", "-DsettingsDir=/usr/src/app/src/etc/cp-helper", "-jar","/usr/src/app/target/cp-helper-4.22.20.jar"]
