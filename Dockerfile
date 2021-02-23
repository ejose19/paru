FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

# Required by buildx as some files are read-only (see https://github.com/moby/buildkit/issues/1267#issuecomment-769880570)
RUN sed -i "s/#\(IgnorePkg   =\)/\1 filesystem/" /etc/pacman.conf
# Using a more reliable gpg server (see https://wiki.archlinux.org/index.php/Pacman/Package_signing#Change_keyserver)
RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ls -la
RUN ./dist
