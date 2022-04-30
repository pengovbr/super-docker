################################################################################
# Dockerfile de construcao do container Solr utilizado pelo SUPER
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

ARG IMAGEM_BASE=supergovbr/base-centos7:latest

FROM ${IMAGEM_BASE}

ENV TERM xterm

ADD assets/ \
    https://github.com/spbgovbr/sei-docker-binarios/raw/main/pacoteslinux/solr-8.2.0.tgz.partaa \
    https://github.com/spbgovbr/sei-docker-binarios/raw/main/pacoteslinux/solr-8.2.0.tgz.partab \
    /tmp/

RUN ls -lh /tmp && sh /tmp/install.sh && rm -rf /tmp/*

EXPOSE 8983
CMD ["/entrypoint.sh"]
