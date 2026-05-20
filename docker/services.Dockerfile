FROM maven:3.9.9-eclipse-temurin-17 AS build

RUN git clone https://github.com/rushidholecom/med-pharma-erp-application.git

WORKDIR ${WORKDIR}
COPY application.properties ${WORKDIR}/src/main/resources/application.properties
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
COPY --from=build ${WORKDIR}/target/auth-service-0.0.1-SNAPSHOT.jar /app/auth-service.jar
WORKDIR /app
ENTRYPOINT [ "java", "-jar", "auth-service.jar" ]