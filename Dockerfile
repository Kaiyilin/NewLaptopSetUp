FROM ubuntu:20.04
VOLUME /tmp
# ARG JAVA_OPTS
# ENV JAVA_OPTS=$JAVA_OPTS
# COPY javalearning.jar javalearning.jars
EXPOSE 3000
# ENTRYPOINT exec java $JAVA_OPTS -jar javalearning.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar javalearning.jar
