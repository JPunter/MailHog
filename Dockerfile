#
# MailHog Dockerfile
#
FROM --platform=$BUILDPLATFORM golang:alpine as builder

ARG TARGETARCH
ARG BUILDPLATFORM

RUN apk --no-cache add bash make openssl git
COPY . /go/src/github.com/mailhog/MailHog
RUN cd /go/src/github.com/mailhog/MailHog && ./build.sh "$TARGETARCH"

FROM scratch

ARG TARGETARCH
COPY --from=builder /go/src/github.com/mailhog/MailHog/MailHog.linux."$TARGETARCH" /MailHog

ENTRYPOINT [ "/MailHog" ]

EXPOSE 1025 8025
