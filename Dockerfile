FROM ubuntu:22.04 AS builder
RUN apt-get update -y && \
    apt-get install -y openjdk-17-jdk maven git && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/pavandath/spring-petclinic.git
WORKDIR /spring-petclinic
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY --from=builder /spring-petclinic/target/*.jar spring.jar 
EXPOSE 8080
CMD [ "java", "-jar", "spring.jar" ]
