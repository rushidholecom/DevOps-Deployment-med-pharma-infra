FROM maven:3.9.9-eclipse-temurin-17 AS build   
ARG WORKDIR=/build
WORKDIR ${WORKDIR}

RUN git clone https://github.com/rushidholecom/med-pharma-erp-application.git

WORKDIR /build/med-pharma-erp-application/auth-service
COPY application.properties /src/main/resources/application.properties

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
ARG WORKDIR=/build
WORKDIR /app

COPY --from=build ${WORKDIR}/target/auth-service-0.0.1-SNAPSHOT.jar /app/auth-service.jar

EXPOSE 8081

ENTRYPOINT [ "java", "-jar", "auth-service.jar" ]