FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt update && \
    apt install --no-install-recommends -y \
        wget \
        git \
        make \
        apt-transport-https \
        unzip && \
    apt install --no-install-recommends -y \
        texlive-full && \
    apt install --no-install-recommends --reinstall -y \
        ttf-mscorefonts-installer \
        fonts-freefont-ttf \
        fontconfig && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    echo "Update font cache." && \
    fc-cache -fv && \
    echo "Delete TeX Live sources and other useless stuff." && \
    (rm -rf /usr/share/texmf/source || true) && \
    (rm -rf /usr/share/texlive/texmf-dist/source || true) && \
    find /usr/share/texlive -type f -name "readme*.*" -delete && \
    find /usr/share/texlive -type f -name "README*.*" -delete && \
    (rm -rf /usr/share/texlive/release-texlive.txt || true) && \
    (rm -rf /usr/share/texlive/doc.html || true) && \
    (rm -rf /usr/share/texlive/index.html || true) && \
    echo "Clean up all temporary files." && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/ssh/ssh_host_* && \
    echo "Delete man pages and documentation." && \
    rm -rf /usr/share/man && \
    mkdir -p /usr/share/man && \
    find /usr/share/doc -depth -type f ! -name copyright -delete && \
    find /usr/share/doc -type f -name "*.pdf" -delete && \
    find /usr/share/doc -type f -name "*.gz" -delete && \
    find /usr/share/doc -type f -name "*.tex" -delete && \
    (find /usr/share/doc -type d -empty -delete || true) && \
    mkdir -p /usr/share/doc && \
    rm -rf /var/cache/apt/archives && \
    mkdir -p /var/cache/apt/archives && \
    rm -rf /tmp/* /var/tmp/* && \
    (find /usr/share/ -type f -empty -delete || true) && \
    (find /usr/share/ -type d -empty -delete || true) && \
    mkdir -p /usr/share/texmf/source && \
    mkdir -p /usr/share/texlive/texmf-dist/source && \
    echo "All done."
