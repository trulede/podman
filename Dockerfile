
FROM debian:bookworm-slim

ARG IMAGE_USERNAME=taskfile

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
        curl \
        gnupg \
	; \
    . /etc/os-release; \
    curl -L http://downloadcontent.opensuse.org/repositories/home:/alvistack/Debian_${VERSION_ID}/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/alvistack.gpg  >/dev/null; \
    echo "deb http://downloadcontent.opensuse.org/repositories/home:/alvistack/Debian_${VERSION_ID}/ /" | tee  /etc/apt/sources.list.d/alvistack.list; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		podman \
	; \
	rm -rf /var/lib/apt/lists/*

RUN useradd $IMAGE_USERNAME
USER $IMAGE_USERNAME
WORKDIR /home/${IMAGE_USERNAME}
