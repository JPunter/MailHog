#!/usr/bin/env bash
set -e
NAME=MailHog
OS=linux

ARCH=$1

echo "Building for arch: $ARCH"

export GOFLAGS=-mod=vendor
export GO111MODULE=on

FILE=${NAME}.${OS}.${ARCH}
CGO_ENABLED=0 GOOS=${OS} GOARCH=${ARCH} go build -o ${FILE} .
SHA=`openssl sha256 ${FILE} | awk '{print $2}'`
echo "${SHA} ${FILE}" > ${FILE}.sha256.txt

