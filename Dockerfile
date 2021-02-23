FROM lopsided/archlinux:devel

WORKDIR /app

COPY ../ .

RUN if [[ $(uname -m) = "x86_64" ]]; then \
      mkdir ci-fix && \
      cd ci-fix && \
      curl -O https://archive.archlinux.org/packages/g/glibc/glibc-2.33-2-x86_64.pkg.tar.zst && \
      curl -O https://archive.archlinux.org/packages/g/glibc/glibc-2.33-2-x86_64.pkg.tar.zst.sig && \
      pacman-key --verify glibc-2.33-2-x86_64.pkg.tar.zst.sig &&
      pacman -U --noconfirm glibc-2.33-2-x86_64.pkg.tar.zst &&
      sed -i "s/#\(IgnorePkg   =\)/\1 glibc/" /etc/pacman.conf; \
    fi

RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf
RUN sed -i 's/CheckSpace/#CheckSpace/g' /etc/pacman.conf
RUN echo "[options]" >> /etc/pacman.conf
RUN echo "NoExtract = etc/hosts etc/resolv.conf" >> /etc/pacman.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm rust
RUN ls -la
RUN ./dist

