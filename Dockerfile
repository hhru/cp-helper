FROM openjdk:11-jdk-slim
COPY ./src/etc  /etc
ADD target/cp-helper-4.22.20.jar .
CMD ["java", "-DsettingsDir=/etc/cp-helper", "-jar", "cp-helper-4.22.20.jar"]