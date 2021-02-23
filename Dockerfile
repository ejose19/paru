FROM archlinux:base-devel

WORKDIR /app

COPY ../ .

RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN sed -i 's/CheckSpace/#CheckSpace/g' /etc/pacman.conf
RUN echo "[options]" >> /etc/pacman.conf
RUN echo "NoExtract = etc/hosts etc/resolv.conf" >> /etc/pacman.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ls -la
RUN ./dist

