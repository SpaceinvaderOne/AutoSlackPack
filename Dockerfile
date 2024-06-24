# base
FROM aclemons/slackware:latest

# stop interactive prompts
ENV TERM=xterm \
    DIALOG=off \
    PAGER=cat \
    STDOUT=on

# update and install packages
RUN slackpkg update gpg && \
    slackpkg update && \
    slackpkg install wget curl

RUN slackpkg install binutils gcc-g++ libffi glibc libunistring elfutils guile make gc kernel-headers gcc && \
    slackpkg install clang ca-certificates cyrus-sasl brotli nghttp2 openssl openssl-devel libxml2 autoconf automake cmake pkg-config git gdb doxygen cppcheck && \
    slackpkg install flex bison perl python3 python-pip m4 libtool tcl tk gettext readline sqlite expat libpng freetype fontconfig libjpeg-turbo libtiff harfbuzz cairo pango gdk-pixbuf && \
    slackpkg install atk at-spi2-atk gtk+3 qt5 alsa-lib libXrender libXi libXtst libXcomposite libXcursor libXdamage libXfixes libXinerama libxkbcommon libXrandr libXres libXScrnSaver libXv libXvMC libXxf86vm libdrm vulkan-sdk libarchive && \
    slackpkg install flac libogg libvorbis libtheora speex opus x264 x265 ffmpeg boost icu4c json-c yaml-cpp libuv libevent && \
    slackpkg install mariadb-client postgresql-libs unixODBC curl libcurl nmap samba xz lzma gzip bzip2 lzip lzop zstd lz4 imagemagick graphicsmagick gnutls nettle p11-kit dbus glib2 libcap pcre pcre2 && \
    slackpkg install coreutils fileutils findutils gawk sed grep util-linux meson ninja ncurses ncurses-devel zlib zlib-devel mesa mesa-devel libX11 libX11-devel libXext libXext-devel libxcb libxcb-devel libXau libXau-devel libXdmcp libXdmcp-devel

# cleanup
RUN slackpkg clean-system || true && \
    rm -rf /var/cache/packages/* /var/lib/slackpkg/* /usr/share/man/* /usr/share/info/* /usr/share/doc/* && \
    rm -rf /tmp/* /var/tmp/*

# copy the build script 
COPY build.sh /usr/local/bin/build.sh

# make the script executable
RUN chmod +x /usr/local/bin/build.sh

# set  entrypoint 
ENTRYPOINT ["/usr/local/bin/build.sh"]

