FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN pacman-key --populate
RUN pacman-key --keyserver hkps://keyserver.ubuntu.com --refresh-keys || true
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ./dist

