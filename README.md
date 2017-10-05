#  Minimalistic Java 9 Modules Example

This repo contains dead simple example with 3 modules: api, provider and consumer. After building, all modules are linked with `jlink` and packed into a slim docker image without jre or jdk. Using `jlink` is an absolutely optional step. A normal java application can be found in `dist` folder.

To follow, see [jigsaw guide](http://openjdk.java.net/projects/jigsaw/quick-start).

The `jlink` gives us docker image with incredible 50Mb size. As soon as `openjdk:9-jdk-alpine` will be released, size can be even smaller. Note that `jlink` creates statically linked application, therefore you must forget about cross-platform java applications and go with docker all the way from build to deploy.

## Build

### Building java app with installed jdk9
```
$ ./build.sh
```

### Building docker image without jdk (requires Docker >= 1.17)
```
$ docker build . -t example
```

### Building with installed jdk9 and add to docker image without jdk (don't do this unless you on linux)
```
$ ./build.sh
$ docker build -f Dockerfile.wrap . -t example
```

## Run

### Running module `app` with dependencies in `dist` folder (pretty much like before with classpath)
```
java --module-path dist -m app
```

### Running jlink runtime image (no jre needed)
```
image/bin/java -m app/io.b3.app.Main
```

### Running docker image
```
$ docker run --rm example
```