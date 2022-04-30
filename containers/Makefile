SHELL := /bin/bash

ifndef DOCKER_REGISTRY
$(error variavel DOCKER_REGISTRY nao definida. Abandonando execucao.)
endif

ifndef DOCKER_CONTAINER_VERSAO_PRODUTO
$(error variavel DOCKER_CONTAINER_VERSAO_PRODUTO nao definida. Abandonando execucao.)
endif

IMAGEMTMP_FULL=$(DOCKER_REGISTRY)/$(IMAGEMTMP):$(IMAGEMTMP_VERSAO)

ifdef IMAGEM_BASE_JOD_SOLR
BUILD_ARGS_JOD_SOLR="--build-arg IMAGEM_BASE=$(IMAGEM_BASE_JOD_SOLR)"
endif

ifdef IMAGEM_BASE_MARIADB
BUILD_ARGS_MARIADB="--build-arg IMAGEM_BASE=$(IMAGEM_BASE_MARIADB)"
endif

ifdef IMAGEM_BASE_SQLSERVER
BUILD_ARGS_SQLSERVER="--build-arg IMAGEM_BASE=$(IMAGEM_BASE_SQLSERVER)"
endif

ifdef IMAGEM_BASE_ORACLE
BUILD_ARGS_ORACLE="--build-arg IMAGEM_BASE=$(IMAGEM_BASE_ORACLE)"
endif

## help: Lista de comandos disponiveis e descricao. Voce pode usar TAB para completar os comandos
help:
		@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/## //'


## verificar-parametro-imagemtmp: target de apoio para verificar se o parametro make IMAGEMTMP foi passado
verificar-parametro-imagemtmp:
		@if [ "$(IMAGEMTMP)" == "" ]; then echo "Informe a variavel make: IMAGEMTMP"; exit 1; fi;


## verificar-parametro-imagemtmp-versao: target de apoio para verificar se o parametro make IMAGEMTMP_VERSAO foi passado
verificar-parametro-imagemtmp-versao:
		@if [ "$(IMAGEMTMP_VERSAO)" == "" ]; then echo "Informe a variavel make: IMAGEMTMP_VERSAO"; exit 1; fi;


## verificar-parametro-imagemtmp-path: target de apoio para verificar se o parametro make IMAGEMTMP_PATH foi passado
verificar-parametro-imagemtmp-path:
		@if [ "$(IMAGEMTMP_PATH)" == "" ]; then echo "Informe a variavel make: IMAGEMTMP_PATH"; exit 1; fi;


## verificar-conteiner-imagem-rodando: target de apoio para verificar se ha conteiner rodadno com determinada imagem
verificar-conteiner-imagem-rodando: verificar-parametro-imagemtmp verificar-parametro-imagemtmp-versao 
		@echo "Verificando se a imagem: $(IMAGEMTMP_FULL) esta rodando ou parada no pool"; \
    if test "$$(docker ps -a | grep $(IMAGEMTMP_FULL))"; then \
      echo "Imagem $(IMAGEMTMP_FULL) está sendo usada ou ainda persiste no pool docker stopada."; \
						echo "Pare e remova antes o conteiner. Parando execucao..."; \
						echo ""; echo ""; \
      exit 1; \
		fi



######################################################
########ERASE TARGETS#################################
######################################################

## erase-conteiner-generic: target para apagar imagem passada por parametro
erase-conteiner-generic: verificar-conteiner-imagem-rodando
		@if test -z "$$(docker images -q $(IMAGEMTMP_FULL))"; then \
		    echo "Imagem $(IMAGEMTMP_FULL) nao existe. Pulando para o proximo passo"; \
		else \
		    echo "Apagando a imagem: $(IMAGEMTMP_FULL)"; \
		    docker rmi $(IMAGEMTMP_FULL); \
		fi;


## erase-conteiner-base-centos: apagar a imagem base-centos
erase-conteiner-base-centos:
		@make IMAGEMTMP=base-centos7 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-memcached: apagar a imagem memcached
erase-conteiner-memcached:
		@make IMAGEMTMP=memcached IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-jod: apagar a imagem jod
erase-conteiner-jod:
		@make IMAGEMTMP=jod IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-mailcatcher: apagar a imagem mailcatcher
erase-conteiner-mailcatcher:
		@make IMAGEMTMP=mailcatcher IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-base-mariadb: apagar a imagem base-mariadb
erase-conteiner-base-mariadb:
		@make IMAGEMTMP=base-mariadb10.5 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-mariadb: apagar a imagem mariadb
erase-conteiner-mariadb:
		@make IMAGEMTMP=mariadb10.5 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-base-sqlserver: apagar a imagem base-sqlserver
erase-conteiner-base-sqlserver:
		@make IMAGEMTMP=base-sqlserver2017 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-sqlserver: apagar a imagem sqlserver
erase-conteiner-sqlserver:
		@make IMAGEMTMP=sqlserver2017 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-base-oracle: apagar a imagem base-oracle
erase-conteiner-base-oracle:
		@make IMAGEMTMP=base-oracle11g IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-oracle: apagar a imagem oracle
erase-conteiner-oracle:
		@make IMAGEMTMP=oracle11g IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiner-solr: apagar a imagem solr
erase-conteiner-solr:
		@make IMAGEMTMP=solr8.2.0 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) erase-conteiner-generic


## erase-conteiners-local: apagar todas as imagens do projeto
erase-conteiners-local: erase-conteiner-base-centos erase-conteiner-memcached erase-conteiner-jod erase-conteiner-mailcatcher erase-conteiner-base-mariadb erase-conteiner-mariadb erase-conteiner-base-sqlserver erase-conteiner-sqlserver erase-conteiner-base-oracle erase-conteiner-oracle erase-conteiner-solr


######################################################
########BUILD CONTAINERS TARGETS######################
######################################################

build-conteiner-generic: verificar-parametro-imagemtmp-path
		@make IMAGEMTMP=$(IMAGEMTMP) IMAGEMTMP_VERSAO=$(IMAGEMTMP_VERSAO) verificar-conteiner-imagem-rodando
		docker build $(BUILD_ARGS) -t $(IMAGEMTMP_FULL) $(IMAGEMTMP_PATH)
		@if [ "$(IMAGEMTMP_VERSAO)" != "test" ]; then \
		docker tag $(IMAGEMTMP_FULL) $(DOCKER_REGISTRY)/$(IMAGEMTMP):latest; \
		fi;

build-conteiner-base-centos:
		@make IMAGEMTMP=base-centos7 \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=base-centos \
					build-conteiner-generic

build-conteiner-memcached:
		@make IMAGEMTMP=memcached \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=memcached \
					build-conteiner-generic

build-conteiner-jod:
		@make IMAGEMTMP=jod \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=jod \
					BUILD_ARGS=$(BUILD_ARGS_JOD_SOLR) \
					build-conteiner-generic

build-conteiner-mailcatcher:
		@make IMAGEMTMP=mailcatcher \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=mailcatcher \
					build-conteiner-generic

build-conteiner-base-mariadb:
		@make IMAGEMTMP=base-mariadb10.5 \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=databases/mariadb-base \
					build-conteiner-generic

build-conteiner-mariadb:
		@make IMAGEMTMP=mariadb10.5 \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=databases/mariadb \
					BUILD_ARGS=$(BUILD_ARGS_MARIADB) \
					build-conteiner-generic

build-conteiner-base-sqlserver:
		@make IMAGEMTMP=base-sqlserver2017 \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=databases/sqlserver-base \
					build-conteiner-generic

build-conteiner-sqlserver:
		@make IMAGEMTMP=sqlserver2017 \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=databases/sqlserver \
					BUILD_ARGS=$(BUILD_ARGS_SQLSERVER) \
					build-conteiner-generic

build-conteiner-base-oracle:
		@make IMAGEMTMP=base-oracle11g \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=databases/oracle-base \
					build-conteiner-generic

build-conteiner-oracle:
		@make IMAGEMTMP=oracle11g \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=databases/oracle \
					BUILD_ARGS=$(BUILD_ARGS_ORACLE) \
					build-conteiner-generic

build-conteiner-solr:
		@make IMAGEMTMP=solr8.2.0 \
		      IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) \
					IMAGEMTMP_PATH=solr \
					BUILD_ARGS=$(BUILD_ARGS_JOD_SOLR) \
					build-conteiner-generic

build-conteiners: build-conteiner-base-centos build-conteiner-memcached build-conteiner-jod build-conteiner-mailcatcher build-conteiner-base-mariadb build-conteiner-mariadb build-conteiner-base-sqlserver build-conteiner-sqlserver build-conteiner-base-oracle build-conteiner-oracle build-conteiner-solr


######################################################
########PUBLISH CONTAINERS TARGETS####################
######################################################

publish-container-generic: verificar-parametro-imagemtmp
		@if test -z "$$(docker images -q $(IMAGEMTMP_FULL))"; then \
		    echo "Imagem $(IMAGEMTMP_FULL) nao existe. Rode o build respectivo antes"; \
				exit 1; \
		else \
		    echo "Publicando a imagem: $(IMAGEMTMP_FULL)"; \
				echo "Caso nao publique verifique se vc esta logado no registry informado no seu env"; echo ""; \
				set -e; \
		    docker push $(IMAGEMTMP_FULL); \
				if [ "$(IMAGEMTMP_VERSAO)" != "test" ]; then \
    				docker push $(DOCKER_REGISTRY)/$(IMAGEMTMP):latest; \
				fi; \
		fi;


publish-container-base-centos:
		@make IMAGEMTMP=base-centos7 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-memcached:
		@make IMAGEMTMP=memcached IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-jod:
		@make IMAGEMTMP=jod IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-mailcatcher:
		@make IMAGEMTMP=mailcatcher IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-base-mariadb:
		@make IMAGEMTMP=base-mariadb10.5 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-mariadb:
		@make IMAGEMTMP=mariadb10.5 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-base-sqlserver:
		@make IMAGEMTMP=base-sqlserver2017 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-sqlserver:
		@make IMAGEMTMP=sqlserver2017 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-base-oracle:
		@make IMAGEMTMP=base-oracle11g IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-oracle:
		@make IMAGEMTMP=oracle11g IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-container-solr:
		@make IMAGEMTMP=solr8.2.0 IMAGEMTMP_VERSAO=$(DOCKER_CONTAINER_VERSAO_PRODUTO) publish-container-generic


publish-containers: publish-container-base-centos publish-container-memcached publish-container-jod publish-container-mailcatcher publish-container-base-mariadb publish-container-mariadb publish-container-base-sqlserver publish-container-sqlserver publish-container-base-oracle publish-container-oracle publish-container-solr