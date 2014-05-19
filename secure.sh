#!/bin/sh
tar czvpf - secure | gpg --symmetric --cipher-algo aes256 -o secure.tar.gz.gpg
