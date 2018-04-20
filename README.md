#  Minimalistic Java Modules Example

This repo contains dead simple example with 3 modules: api, provider and consumer. After building, all modules are linked with `jlink` and packed into a slim docker image without jre or jdk. Using `jlink` is an absolutely optional step. A normal java application can be found in `dist` folder.

To follow, see [jigsaw guide](http://openjdk.java.net/projects/jigsaw/quick-start).

The `jlink` gives us docker image with incredible 50Mb size. As soon as `openjdk:X-jdk-alpine` is released, size can be less than 40Mb. Note that `jlink` creates statically linked application, therefore you must forget about cross-platform java applications and go with docker all the way from build to deploy.

## Build

### Building java app with installed jdk (requires Java >= 9)
```
$ ./build.sh
```

### Building docker image without jdk installed (requires Docker >= 1.17)
```
$ docker build . -t example
```

### Building with installed jdk and add to docker image without jdk (don't do this unless you on linux)
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

## Building alpine Early-Access Build

1. Download jdk early-access build for Alpine Linux from http://jdk.java.net/11/
2. Unpack the archive to `jdk-alpine` folder
3. Build `jdk-alpine` docker image `docker build -f Dockerfile.ea . -t jdk-alpine`
4. Build app docker image `docker build -f Dockerfile.alpine . -t hi`

**UPDATES**
* There is [Alpine Linux JDK 11](https://download.java.net/java/early_access/alpine/9/binaries/openjdk-11-ea+9_linux-x64-musl_bin.tar.gz) available on [JDK 11 Early-Access Builds](http://jdk.java.net/11/) page.
* There is an official [project](http://openjdk.java.net/projects/portola/) to provide a port of the JDK to the Alpine Linux.
* The image with `jdk9-apline` was [canceled](https://bugs.alpinelinux.org/issues/8089), but we will probably get alpine image with jdk10 after April 2018.

