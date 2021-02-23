FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN sed -i 's/CheckSpace/#CheckSpace/g' /etc/pacman.conf
RUN echo "[options]" >> /etc/pacman.conf
RUN echo "NoExtract = etc/hosts etc/resolv.conf" >> /etc/pacman.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syu --noconfirm rust
RUN mkdir -p /var/lib/pacman/ && pacman-db-upgrade
RUN ls -la
RUN ./dist

