# Builder
FROM maven:3-eclipse-temurin-11 AS builder

WORKDIR /data

ARG BUILD_PROFILE

COPY --from=source genshin-map-commons genshin-map-commons
COPY --from=source genshin-map-config genshin-map-config
COPY --from=source genshin-map-dependencies genshin-map-dependencies
COPY --from=source genshin-map-data genshin-map-data
COPY --from=source genshin-map-generator genshin-map-generator
COPY --from=source genshin-map-ability genshin-map-ability
COPY --from=source genshin-map-api genshin-map-api
COPY --from=source pom.xml pom.xml
COPY --from=common config/maven config/maven
COPY .tmp .tmp

RUN --mount=type=cache,target=/root/.m2,rw \
    cp -f ./.tmp/application-datasource.yml ./genshin-map-config/src/main/resources-${BUILD_PROFILE}/application-datasource-${BUILD_PROFILE}.yml && \
    cp -f ./.tmp/application-image.yml ./genshin-map-config/src/main/resources-${BUILD_PROFILE}/application-image-${BUILD_PROFILE}.yml && \
    cp -f ./.tmp/application-websocket.yml ./genshin-map-config/src/main/resources-${BUILD_PROFILE}/application-websocket-${BUILD_PROFILE}.yml && \
    cp -f ./.tmp/application-oauth.yml ./genshin-map-config/src/main/resources-${BUILD_PROFILE}/application-oauth-${BUILD_PROFILE}.yml && \
    cp -f ./.tmp/application-nacos.yml ./genshin-map-config/src/main/resources-${BUILD_PROFILE}/bootstrap-nacos-${BUILD_PROFILE}.yml && \
    cp -f ./.tmp/application-nacos.yml ./genshin-map-ability/genshin-map-ability-gateway/src/main/resources-${BUILD_PROFILE}/bootstrap-nacos-${BUILD_PROFILE}.yml && \
    cp -f ./.tmp/application-nacos.yml ./genshin-map-api/genshin-map-api-core/genshin-map-api-core-core/src/main/resources-${BUILD_PROFILE}/bootstrap-nacos-${BUILD_PROFILE}.yml && \
    mvn clean package -s ./config/maven/maven.xml -P ${BUILD_PROFILE} -f pom.xml && \
    mkdir -p ./dist && \
    cp -f ./genshin-map-ability/genshin-map-ability-gateway/target/genshin-map-ability-gateway-1.0.jar ./dist && \
    cp -f ./genshin-map-api/genshin-map-api-core/genshin-map-api-core-core/target/genshin-map-api-core-core-1.0.jar ./dist
