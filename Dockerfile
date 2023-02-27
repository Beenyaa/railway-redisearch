ARG RELEASE
ARG LAUNCHPAD_BUILD_ARCH
LABEL org.opencontainers.image.ref.name=ubuntu
LABEL org.opencontainers.image.version=20.04
ADD file:8b180a9b4497de0c6e131d6b48cf5c69a885379e63033ab9639d1655991e626c in / 
CMD ["/bin/bash"]
RUN /bin/sh -c apt-get update -qqy # buildkit
RUN /bin/sh -c apt-get upgrade -qqy # buildkit
RUN /bin/sh -c apt-get install dumb-init # buildkit
RUN /bin/sh -c apt-get install -y libssl-dev libgomp1 # buildkit
ADD ./redis-stack /var/cache/apt/redis-stack/ # buildkit
RUN /bin/sh -c mkdir -p /data/redis /data/redisinsight # buildkit
RUN /bin/sh -c touch /.dockerenv # buildkit
RUN /bin/sh -c dpkg -i /var/cache/apt/redis-stack/redis-stack-server*.deb # buildkit
RUN /bin/sh -c rm -rf /var/cache/apt # buildkit
COPY ./etc/scripts/entrypoint.sh /entrypoint.sh # buildkit
RUN /bin/sh -c chmod a+x /entrypoint.sh # buildkit
EXPOSE map[6379/tcp:{}]
ENV REDISBLOOM_ARGS=
ENV REDISEARCH_ARGS=
ENV REDISJSON_ARGS=
ENV REDISTIMESERIES_ARGS=
ENV REDISGRAPH_ARGS=
ENV REDIS_ARGS=
CMD ["/entrypoint.sh"]
