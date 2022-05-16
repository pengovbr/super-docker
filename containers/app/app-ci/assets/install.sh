#!/bin/bash

set -e

cp /tmp/assets/conf/sei.ini /etc/php.d/
cp /tmp/assets/conf/sei.conf /etc/httpd/conf.d/ 

cp /tmp/assets/scripts-e-automatizadores/entrypoint.sh /
cp /tmp/assets/scripts-e-automatizadores/entrypoint-atualizador.sh /

/tmp/assets/scripts-e-automatizadores/clone-modules.sh

mkdir -p /sei/controlador-instalacoes/ /sei/arquivos_externos_sei/ /sei/certs
mkdir -p /sei/files/conf /sei/files/scripts-e-automatizadores/modulos
mv /tmp/assets/conf/ConfiguracaoSEI.php /sei/files/conf
mv /tmp/assets/conf/ConfiguracaoSip.php /sei/files/conf
mv /tmp/assets/scripts-e-automatizadores/openldap /sei/files/scripts-e-automatizadores/
mv /tmp/assets/scripts-e-automatizadores/modulos/mod-sei-estatisticas /sei/files/scripts-e-automatizadores/modulos/