FROM --platform=linux/amd64 ubuntu:24.04

# 设置环境变量，避免交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 创建openwrt用户和相关目录
RUN useradd -m -s /bin/bash openwrt

# 更新包列表并安装必要的软件包
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    build-essential \
    clang \
    flex \
    bison \
    g++ \
    gawk \
    gcc-multilib \
    g++-multilib \
    gettext \
    git \
    libncurses5-dev \
    libssl-dev \
    python3-setuptools \
    rsync \
    swig \
    unzip \
    zlib1g-dev \
    file \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git config --global http.sslverify false

# 赋予openwrt用户sudo权限
RUN echo "openwrt ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/openwrt && \
    chmod 0440 /etc/sudoers.d/openwrt

# 切换到openwrt用户
USER openwrt

# 设置工作目录
WORKDIR /home/openwrt

# 复制当前目录下的所有文件到 /home/openwrt
COPY . /home/openwrt

# 启动一个shell会话
CMD ["/bin/bash"]