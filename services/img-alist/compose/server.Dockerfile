FROM xhofe/alist:v3.40.0

WORKDIR /alist
COPY scripts/server .

RUN chmod -R +x /alist/*.sh

VOLUME ["/alist/data"]
EXPOSE 5244
ENTRYPOINT ["bash", "/alist/startup.sh"]
