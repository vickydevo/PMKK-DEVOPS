## Dockerfile Directives: WORKDIR, MAINTAINER, COPY vs ADD

### 1. `WORKDIR`
Sets the working directory inside the container. All subsequent commands run from this directory.

```Dockerfile
FROM httpd
WORKDIR /usr/local/apache2/htdocs
```

### 2. `MAINTAINER`
Sets the author/maintainer info (deprecated, use `LABEL` instead).

```Dockerfile
FROM httpd
LABEL "author"=vignan1
MAINTAINER vignan@example.com
WORKDIR /tmp
```

> **Note:** Prefer `LABEL maintainer="vignan@example.com"` for modern Dockerfiles.

### 3. `COPY` vs `ADD`
- `COPY`: Copies files/directories from build context to container.
- `ADD`: Like `COPY`, but can also extract local archives and fetch remote URLs.

#### Example with `COPY`:
```Dockerfile
FROM httpd
COPY ./index.html /usr/local/apache2/htdocs/
```

#### Example with `ADD`:
```Dockerfile
FROM httpd
ADD ./site.tar.gz /usr/local/apache2/htdocs/
```
*(This extracts `site.tar.gz` into the target directory)*

---

### Full Example Dockerfile

```Dockerfile
FROM httpd
LABEL maintainer="vignan@example.com"
WORKDIR /usr/local/apache2/htdocs
COPY ./index.html .
ADD ./images.tar.gz ./images/
```

---

**Summary Table**

| Directive   | Purpose                                      | Example Usage                        |
|-------------|----------------------------------------------|--------------------------------------|
| WORKDIR     | Set working directory                        | `WORKDIR /app`                       |
| MAINTAINER  | Set author/maintainer (deprecated)           | `MAINTAINER vignan@example.com`      |
| LABEL       | Modern way to set metadata                   | `LABEL maintainer="vignan@example.com"` |
| COPY        | Copy files/directories                       | `COPY ./src /app/src`                |
| ADD         | Copy + extract archives/fetch URLs           | `ADD site.tar.gz /app/`              |




























# EC2 Maven vs Docker: Why Use Docker if Maven Creates an Executable JAR?

## 1. Maven: Creates an Executable JAR
- Maven builds the application and packages it as a `.jar` file.
- Includes all dependencies, making it portable on systems with Java installed.
- **Limitations:**
  - Requires Java to be installed separately.
  - Might face OS compatibility issues.
  - Does not include system-level dependencies.

## 2. Docker: Creates a Containerized Image
- Docker packages the application **along with** Java, system dependencies, and configurations.
- Runs consistently across different OS and cloud environments.
- **Advantages:**
  ✅ No need for Java installation on the host machine.
  ✅ Works identically across dev, test, and prod.
  ✅ Simplifies cloud and Kubernetes deployment.

## 3. When to Use What?
| Scenario | Maven (JAR only) | Docker |
|----------|----------------|--------|
| Controlled environment | ✅ Works | ✅ Works |
| Different OS (Windows/Linux) | ❌ Might break | ✅ Works |
| Cloud & containerized deployment | ❌ Manual setup needed | ✅ Easy deployment |
| Microservices & scalability | ❌ Harder to manage | ✅ Perfect for microservices |

## 4. Best Practice: Use Both
1️⃣ **Use Maven** to build the JAR (`mvn package`).
2️⃣ **Use Docker** to containerize it (`docker build -t myapp .`).

By combining Maven and Docker, you get **portability + consistency**, making deployments easier and more reliable. 🚀






```Dockerfile 
# Use Maven with Java 24 (Temurin) as the build environment
FROM maven:3.9.11-eclipse-temurin-24-noble AS stage1

# Set author label for image metadata
LABEL AUTHOR="VIGNAN"

# Set working directory inside the container
WORKDIR /opt

# Copy Maven build file and source code into the container
COPY pom.xml .
COPY src ./src

# Build the application and create a JAR file, skipping tests for faster build
 # This RUN command executes in a temporary container during the build stage
    # RUN mvn clean package -DskipTests


# Use a lightweight Java 21 runtime image for running the application

# --- Stage 2 starts here ---
FROM eclipse-temurin:21

# Copy the JAR file from localhost to the runtime image
COPY  ./target/gs-spring-boot-0.1.0.jar ./app.jar

# Expose port 8090 for the application
EXPOSE 8090

# Set the default command to run the Spring Boot application
ENTRYPOINT ["java","-jar","app.jar"]
```