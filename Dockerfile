FROM openjdk:10-jdk-slim as build
WORKDIR /project
COPY src /project/src
COPY build.sh /project/build.sh
RUN /project/build.sh

FROM blitznote/baseimage
COPY --from=build /project/image /app
WORKDIR /app
CMD ["/app/bin/java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-m", "app/io.b3.app.Main"]
