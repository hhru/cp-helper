FROM registry.pyn.ru/openjdk11-production:2019.07.29

RUN groupadd -f nogroup && useradd -u 3137 -d /home/hh-api-app-stat -g nogroup -m hh-api-app-stat

ENV LANG="en_US.UTF-8"

ENV CONFIG_DIR="/etc/hh-api-app-stat"
ENV LOG_DIR="/var/log"
ENV JAR="hh-api-app-stat-service.jar"

# Актуальные настройки указывать в плейбуке
ENV JVM_OPTS=""

ADD hh-api-app-stat-service/target/$JAR $JAR

USER hh-api-app-stat

CMD ["sh", "-c", "eval exec java \"$JVM_OPTS\" -DsettingsDir=$CONFIG_DIR -jar $JAR >> \"$LOG_DIR/errout.std\" 2>&1"]
