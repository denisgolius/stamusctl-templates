FROM golang:alpine AS Builder

ARG path=selks

RUN mkdir -p /src
RUN apk update && apk add --no-cache gcc musl-dev make

COPY /bin/$path /src/.
WORKDIR /src

RUN CGO_ENABLED=1 make

FROM busybox:latest as BUNDLE

ARG path=selks

COPY /data/$path /data
COPY /version.txt /data/version
COPY --from=Builder /src/dist /sbin/

ENTRYPOINT [ "bin/sh", "-c" ]