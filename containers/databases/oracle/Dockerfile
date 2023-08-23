################################################################################
# Dockerfile de construção do container Oracle utilizado pelo SUPER
#
# Container preparado e configurado para uso em desenvolvimento e testes
# construa antes a imagem base
################################################################################

ARG IMAGEM_BASE=supergovbr/base-oracle11g:latest

FROM ${IMAGEM_BASE}

ARG GIT_DB_REF=https://github.com/supergovbr/sei-db-ref-executivo/raw/master

ENV TERM xterm \
    ORACLE_ALLOW_REMOTE=true \
    NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252

ADD ${GIT_DB_REF}/oracle/v4.0.x.1/sei_4.0.x.1_BD_Ref_Exec.dmp \
    ${GIT_DB_REF}/oracle/v4.0.x.1/sip_4.0.x.1_BD_Ref_Exec.dmp \
    assets/pre-install.sql \
    assets/sei-config.sql \
    assets/sip-config.sql \
    assets/install.sh \
    /tmp/

RUN bash /tmp/install.sh
