FROM mcr.microsoft.com/powershell

WORKDIR /data
COPY scripts/init .

RUN chmod -R +x /data/*.ps1

VOLUME ["/data/record"]
ENTRYPOINT ["pwsh", "/data/setup.ps1"]
