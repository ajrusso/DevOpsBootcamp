# Stage 1: Build the application
FROM gradle:8.12-jdk17 AS build
WORKDIR /app
COPY src/ src/
COPY build.gradle settings.gradle ./
RUN gradle build

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/docker-exercises-project-1.0-SNAPSHOT.jar /app/my-app.jar
EXPOSE 8080
CMD ["java", "-jar", "my-app.jar"]
