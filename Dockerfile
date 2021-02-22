FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN pacman-key --keyserver hkps://keyserver.ubuntu.com --refresh-keys || true
RUN pacman -Sy --noconfirm rustup
RUN rustup install stable
RUN ./dist

