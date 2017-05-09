FROM openjdk:8-jdk
COPY kafka-manager-* /app
CMD ["/app/bin/kafka-manager"]