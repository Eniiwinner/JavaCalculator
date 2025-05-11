FROM openjdk:11-jdk-slim

WORKDIR /app

COPY target/java-web-calculator-*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

