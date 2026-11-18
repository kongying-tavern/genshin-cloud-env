FROM quay.io/minio/mc:RELEASE.2024-01-05T05-04-32Z

WORKDIR /data
COPY scripts/init/setup.sh .
COPY config/minio/policy ./policy

RUN chmod +x /data/setup.sh

VOLUME ["/data/record"]
ENTRYPOINT ["bash", "/data/setup.sh"]
