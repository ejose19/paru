FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN echo "[options]" >> /etc/pacman.conf
RUN echo "NoExtract = etc/hosts etc/resolv.conf" >> /etc/pacman.conf
RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syu --noconfirm
RUN pacman -Su --noconfirm rust
RUN ls -la
RUN ./dist

