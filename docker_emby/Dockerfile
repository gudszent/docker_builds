FROM linuxserver/emby:latest

# build args
ARG EMBY_RELEASE
ENV DEBIAN_FRONTEND="noninteractive" 

#install amdgpu
RUN \
	amdgpu_version="amdgpu-pro-20.45-1188099-ubuntu-20.04" \
	&& url="http://support.amd.com https://drivers.amd.com/drivers/linux/${amdgpu_version}.tar.xz" \
  \
	&& cd \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get --no-install-recommends install -y \
		ca-certificates curl xz-utils \
		clinfo \
        libc6-i386 \
  \
	&& curl -L -O --referer ${url} \
  \
	&& tar -Jxvf ${amdgpu_version}.tar.xz \
	&& rm ${amdgpu_version}.tar.xz \
	&& bash ./${amdgpu_version}/amdgpu-install --no-dkms -y \
	&& rm -fR ${amdgpu_version} \
  \
	&& apt-get -y remove \
		ca-certificates curl xz-utils \
  \
	&& apt-get autoremove -y \
  \
	&& apt-get clean autoclean 

WORKDIR /root


# ports and volumes
EXPOSE 8096 8920
VOLUME /config



