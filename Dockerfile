FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN pacman-key --keyserver hkps://keyserver.ubuntu.com --refresh-keys
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ./dist

