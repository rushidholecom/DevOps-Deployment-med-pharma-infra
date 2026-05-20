FROM maven:3.9.9-eclipse-temurin-17 AS build
ARG WORKDIR=/auth-service
WORKDIR /build

RUN git clone https://github.com/rushidholecom/med-pharma-erp-application.git

WORKDIR /build/med-pharma-erp-application/${WORKDIR}
COPY application.properties /src/main/resources/application.properties

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
ARG WORKDIR=/auth-service
WORKDIR /app

COPY --from=build /build/med-pharma-erp-application/${WORKDIR}/target/*.jar /app/${WORKDIR}.jar

EXPOSE 8081

ENTRYPOINT [ "java", "-jar", "${WORKDIR}.jar" ]