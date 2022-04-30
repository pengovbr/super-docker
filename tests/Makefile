SHELL := /bin/bash

DOCKER_REGISTRY=supergovbr
# nao mude a var abaixo qd for testar, caso contrario o makefile de conteiner vai tagear o conteiner de teste como latest
# como um dos testes eh enviar as imagens para o seu registry isso geralmente n eh o que se deseja (enviar imagem de teste como latest)
DOCKER_CONTAINER_VERSAO_PRODUTO=test
CONTAINERS_LIST=base-centos7 memcached jod mailcatcher base-mariadb10.5 mariadb10.5 base-sqlserver2017 sqlserver2017 base-oracle11g oracle11g solr8.2.0

IMAGEM_BASE_JOD_SOLR=supergovbr/base-centos7:test
IMAGEM_BASE_MARIADB=supergovbr/base-mariadb10.5:test
IMAGEM_BASE_ORACLE=supergovbr/base-oracle11g:test
IMAGEM_BASE_SQLSERVER=supergovbr/base-sqlserver2017:test


containers-erase:
		@echo "Vamos tentar apagar todos os conteineres locais com o registry $(DOCKER_REGISTRY) com a tag $(DOCKER_CONTAINER_VERSAO_PRODUTO)"
		@echo ""
		@make -C ../containers erase-conteiners-local
		@echo ""
		@echo "Imagens apagadas. Vamos verificar se as imagens nao se encontram presentes"
		@for i in $(CONTAINERS_LIST); \
		do \
		    echo "Verificando se a imagem: $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) existe"; \
				if test -z "$$(docker images -q $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO))"; then \
				    echo "ok! Imagem $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) nao existe."; \
				else \
				    echo "Falha: $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) continua existindo"; \
						exit 1; \
				fi; \
		done

containers-build:
		@echo "Vamos tentar buildar todos os conteineres usando o registry $(DOCKER_REGISTRY) com a tag $(DOCKER_CONTAINER_VERSAO_PRODUTO)"
		@echo ""
		@make -C ../containers IMAGEM_BASE_JOD=$(IMAGEM_BASE_JOD_SOLR) IMAGEM_BASE_MARIADB=$(IMAGEM_BASE_MARIADB) IMAGEM_BASE_SQLSERVER=$(IMAGEM_BASE_SQLSERVER) IMAGEM_BASE_ORACLE=$(IMAGEM_BASE_ORACLE) build-conteiners
		@echo ""
		@echo "Imagens criadas. Vamos verificar se as imagens encontram-se presentes"
		@for i in $(CONTAINERS_LIST); \
		do \
		    echo "Verificando se a imagem: $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) existe"; \
				if test -z "$$(docker images -q $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO))"; then \
				    echo "Falha: $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) nao existe"; \
						exit 1; \
				else \
				    echo "ok! Imagem $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) existe."; \
				fi; \
		done

containers-publish:
		@echo "Vamos tentar publicar todos os conteineres usando o registry $(DOCKER_REGISTRY) com a tag $(DOCKER_CONTAINER_VERSAO_PRODUTO)"
		@echo ""
		@make -C ../containers publish-containers
		@echo ""
		@echo "ok! Imagens publicadas."

containers-download:
		@echo "Vamos agora tentar fazer o download das imagens de teste"
		@for i in $(CONTAINERS_LIST); \
		do \
		    echo "Baixando a imagem: $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO)"; \
				docker pull $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO); \
		done
		@echo "Imagens baixadas. Vamos verificar se as imagens encontram-se presentes"
		@for i in $(CONTAINERS_LIST); \
		do \
		    echo "Verificando se a imagem: $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) existe"; \
				if test -z "$$(docker images -q $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO))"; then \
				    echo "Falha: $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) nao existe"; \
						exit 1; \
				else \
				    echo "ok! Imagem $(DOCKER_REGISTRY)/$$i:$(DOCKER_CONTAINER_VERSAO_PRODUTO) existe."; \
				fi; \
		done


test-containers: 
		@echo "Vamos iniciar a bateria de testes relacionada aos conteineres (erase, build, push e pull)"
		@echo "***********************************************************************************"
		@echo "Erase******************************************************************************"
		@echo "***********************************************************************************"
		make containers-erase
		@echo "***********************************************************************************"
		@echo "Build******************************************************************************"
		@echo "***********************************************************************************"
		make containers-build 
		@echo "***********************************************************************************"
		@echo "Push*******************************************************************************"
		@echo "***********************************************************************************"
		make containers-publish 
		@echo "***********************************************************************************"
		@echo "Erase Novamente********************************************************************"
		@echo "***********************************************************************************"
		make containers-erase 
		@echo "***********************************************************************************"
		@echo "Download **************************************************************************"
		@echo "***********************************************************************************"
		make containers-download
		@echo "***********************************************************************************"
		@echo "Erase Novamente********************************************************************"
		@echo "***********************************************************************************"
		make containers-erase
		@echo "***********************************************************************************"
		@echo "Bateria de testes relacionadas aos conteineres finalizada**************************"
		@echo "***********************************************************************************"
