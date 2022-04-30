################################################################################
# Dockerfile de construção do container Oracle utilizado pelo SUPER
#
# Container preparado e configurado para uso em desenvolvimento e testes
# construa antes a imagem base
################################################################################

ARG IMAGEM_BASE=supergovbr/base-oracle11g:latest

FROM ${IMAGEM_BASE}

ENV TERM xterm
ENV ORACLE_ALLOW_REMOTE=true
ENV NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252

ADD https://github.com/spbgovbr/sei-db-ref-executivo/raw/eb81bfdc4bf1acd5d40369cfdd01adf6aa31a4c2/oracle/v4.0.0/sei_4_0_0_BD_Ref_Exec.dmp \
    https://github.com/spbgovbr/sei-db-ref-executivo/raw/eb81bfdc4bf1acd5d40369cfdd01adf6aa31a4c2/oracle/v4.0.0/sip_4_0_0_BD_Ref_Exec.dmp \
    assets/pre-install.sql \
    assets/sei-config.sql \
    assets/sip-config.sql \
    assets/install.sh \
    /tmp

RUN bash /tmp/install.sh
