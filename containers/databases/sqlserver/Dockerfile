################################################################################
# Dockerfile de construção do container SqlServer utilizado pelo SUPER
#
# Container preparado e configurado para uso em desenvolvimento e testes
# SQL Server para Linux é uma versão experimental e não deve ser utilizada em
# ambiente de produção
# construa antes a imagem base
################################################################################

ARG IMAGEM_BASE=supergovbr/base-sqlserver2017:latest

FROM ${IMAGEM_BASE}

ARG DB_COMMITHASH_BASEREF=eb81bfdc4bf1acd5d40369cfdd01adf6aa31a4c2

ENV TERM xterm \
    ACCEPT_EULA=Y \
    SA_PASSWORD='yourStrong(!)Password'

ADD assets/install.sh \
    assets/restore.sql \
    https://github.com/spbgovbr/sei-db-ref-executivo/raw/${DB_COMMITHASH_BASEREF}/sqlserver/v4.0.0/sei_4_0_0_BD_Ref_Exec.bak \
    https://github.com/spbgovbr/sei-db-ref-executivo/raw/${DB_COMMITHASH_BASEREF}/sqlserver/v4.0.0/sip_4_0_0_BD_Ref_Exec.bak \
    /tmp/

RUN bash /install.sh
