FROM maven:3-eclipse-temurin-11@sha256:5a781a7e008965e5631baa8240150d81e0de730377112f58b8c30a0a28c3e570 as builder

WORKDIR /build
COPY . .
RUN mvn clean verify

FROM eclipse-temurin:11.0.21_9-jre@sha256:35d141ff2b190d4600317468beaec17c4ea88998e686d3af4d0f2fc74615994e

# renovate: datasource=github-releases depName=apangin/jattach
ENV JATTACH_VERSION=1.5

RUN curl -Lo /usr/local/bin/jattach https://github.com/apangin/jattach/releases/download/v${JATTACH_VERSION}/jattach \
 && chmod +x /usr/local/bin/jattach

COPY --from=builder /build/target/demo.jar /demo.jar

ENTRYPOINT ["java", "-jar", "/demo.jar"]
