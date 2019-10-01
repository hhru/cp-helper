serviceName=hh-api-app-stat
datacenter=test
allowCrossDCRequests=false

jetty.port=${docker/hh-api-app-stat/application_port}
jetty.minThreads=8
jetty.maxThreads=8
jetty.selectors=1

jclient.connectionTimeoutMs=2000
jclient.requestTimeoutMs=5000
jclient.readTimeoutMs=5000
jclient.hostsWithSession=http://localhost

cassandra.main.nodes=${docker/cassandra/application_host}
cassandra.main.connectTimeoutMs=2000
cassandra.main.readTimeoutPerNodeMs=5000
cassandra.main.heartbeatIntervalSeconds=30
cassandra.main.reconnectBaseDelayMs=1000
cassandra.main.reconnectMaxDelayMs=10000
cassandra.main.logStatements=true
cassandra.main.sendStats=false

log.dir=logs
log.immediate.flush=true
log.toConsole=true

jdebug.enabled=true
jdebug.logFullQuery=true
