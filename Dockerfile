FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

# # WORKAROUND for glibc 2.33 and old Docker
# # See https://github.com/actions/virtual-environments/issues/2658
# # Thanks to https://github.com/lxqt/lxqt-panel/pull/1562
# RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
#     curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
#     bsdtar -C / -xvf "$patched_glibc" && \
#     sed -i "s/#\(IgnorePkg   =\)/\1 glibc/" /etc/pacman.conf && \
#     rm /usr/include/crypt.h /usr/lib/libcrypt.so

RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN sed -i 's/CheckSpace/#CheckSpace/g' /etc/pacman.conf
RUN echo "[options]" >> /etc/pacman.conf
RUN echo "NoExtract = etc/hosts etc/resolv.conf" >> /etc/pacman.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ls -la
RUN ./dist

