FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN sed -i "s/#\(IgnorePkg   =\)/\1 glibc/" /etc/pacman.conf
RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN sed -i 's/CheckSpace/#CheckSpace/g' /etc/pacman.conf
RUN echo "[options]" >> /etc/pacman.conf
RUN echo "NoExtract = etc/hosts etc/resolv.conf" >> /etc/pacman.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ls -la
RUN ./dist

