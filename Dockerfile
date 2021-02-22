FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN pacman-key --refresh-keys
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ./dist

