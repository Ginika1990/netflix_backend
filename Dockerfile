FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -DskipTests clean package

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

RUN groupadd -r spring && useradd --no-log-init -r -g spring spring

COPY --from=build /app/target/movieist-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
USER spring:spring

ENTRYPOINT ["java", "-jar", "/app/app.jar"]