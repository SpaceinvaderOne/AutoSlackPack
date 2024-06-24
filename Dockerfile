# base
FROM aclemons/slackware:latest

# stop interactive prompts
ENV TERM=xterm \
    DIALOG=off \
    PAGER=cat \
    STDOUT=on

# update and install packages
RUN slackpkg update gpg && \
    slackpkg update

RUN slackpkg install alsa-lib \
at-spi2-atk \
atk \
autoconf \
automake \
binutils \
bison \
boost \
brotli \
bzip2 \
ca-certificates \
cairo \
clang \
cmake \
coreutils \
cppcheck \
curl \
cyrus-sasl \
dbus \
doxygen \
elfutils \
expat \
ffmpeg \
fileutils \
findutils \
flac \
flex \
fontconfig \
freetype \
gawk \
gc \
gcc \
gcc-g++ \
gdb \
gdk-pixbuf \
gettext \
git \
glib2 \
glibc \
gnutls \
graphicsmagick \
grep \
gtk+3 \
guile \
gzip \
harfbuzz \
icu4c \
imagemagick \
json-c \
kernel-headers \
libX11 \
libX11-devel \
libXScrnSaver \
libXau \
libXau-devel \
libXcomposite \
libXcursor \
libXdamage \
libXdmcp \
libXdmcp-devel \
libXext \
libXext-devel \
libXfixes \
libXi \
libXinerama \
libXrandr \
libXrender \
libXres \
libXtst \
libXv \
libXvMC \
libXxf86vm \
libarchive \
libcap \
libcurl \
libdrm \
libevent \
libffi \
libjpeg-turbo \
libogg \
libpng \
libtheora \
libtiff \
libtool \
libunistring \
libuv \
libvorbis \
libxcb \
libxcb-devel \
libxkbcommon \
libxml2 \
lz4 \
lzip \
lzma \
lzop \
m4 \
make \
mariadb-client \
mesa \
mesa-devel \
meson \
ncurses \
ncurses-devel \
nettle \
nghttp2 \
ninja \
nmap \
opus \
p11-kit \
pango \
pcre \
pcre2 \
perl \
pkg-config \
postgresql-libs \
python-pip \
python3 \
qt5 \
readline \
samba \
sed \
speex \
sqlite \
tcl \
tk \
unixODBC \
util-linux \
vulkan-sdk \
wget \
x264 \
x265 \
xz \
yaml-cpp \
zlib \
zlib-devel \
zstd

RUN slackpkg install openssl openssl-devel

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

