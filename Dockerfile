FROM python:3.7.2

ARG no_proxy
ARG NO_PROXY
ARG http_proxy
ARG HTTP_PROXY
ARG https_proxy
ARG HTTPS_PROXY

ENV no_proxy $no_proxy \
	NO_PROXY $NO_PROXY \
	http_proxy $http_proxy \
	HTTP_PROXY $HTTP_PROXY \
	https_proxy $https_proxy \
	HTTPS_PROXY $HTTPS_PROXY

WORKDIR /usr/src/app

RUN pip install --upgrade pip \
	&& pip install virtualenv
