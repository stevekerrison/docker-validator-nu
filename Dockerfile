FROM ubuntu:18.04
MAINTAINER Steve Kerrison <steve@usec.io>

# Packs the HTML5 validator.nu from
# https://github.com/validator/validator
# into a docker container.

# RUN sed -i -e 's|httpredir.debian.org|ftp.us.debian.org|g' /etc/apt/sources.list

RUN apt-get update && \
	apt-get -y install openjdk-11-jre-headless unzip jq curl

RUN curl -s https://api.github.com/repos/validator/validator/releases/latest | jq --raw-output '.assets[0].browser_download_url' | xargs curl -L > vnu.zip && unzip -d /opt vnu.zip

COPY validate /usr/bin
COPY validate-pedantic /usr/bin

CMD validate-pedantic /code
