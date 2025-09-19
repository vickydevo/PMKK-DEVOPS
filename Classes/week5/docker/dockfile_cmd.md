FROM openjdk:24-slim-bullseye

LABEL maintainer="Your Name <your.email@example.com>"

# Install Maven
USER root
RUN apt update -y && apt install -y maven

# Create app directory and user
RUN useradd -ms /bin/bash devopsuser \
    && mkdir /home/devopsuser/app \
    && chown -R devopsuser:devopsuser /home/devopsuser

# Set working directory
WORKDIR /home/devopsuser/app

# Switch to the new user
USER devopsuser

# Copy all project files into app folder
COPY --chown=devopsuser:devopsuser . .

# Build the application inside the container
RUN mvn clean package

# Set the entrypoint
ENTRYPOINT ["java", "-jar", "target/gs-spring-boot-0.1.0.jar"]
