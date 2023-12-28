#!/bin/bash
./compile.sh \
  BOARD=orangepizero3 \
  BRANCH=current \
  BUILD_MINIMAL=yes \
  BUILD_DESKTOP=no \
  RELEASE=bookworm \
  COMPRESS_OUTPUTIMAGE=xz
