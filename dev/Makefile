SHELL := /bin/bash

ifneq ("$(wildcard env.env)","")
include env.env
endif

ifndef base
base=mysql
endif

ifndef HOST_URL
HOST_URL=http://localhost:8000
endif


define MENSAGEM_AVISO_FONTES
Nao foi possivel localizar o fonte do Super.
Verifique o valor da variavel SUPER_PATH
Vc pode definir um valor para a variavel SUPER_PATH:
- adicionando SUPER_PATH=caminhodosfontes ao seu env.env ou
- exportando a var rodadno o seguinte comando: export SUPER_PATH=caminhodosfontes

endef
export MENSAGEM_AVISO_FONTES

CMD_CURL_SUPER_LOGIN = curl -s -L $(HOST_URL)/sei | grep "txtUsuario"

help: ## Mostra essa ajuda. Voce pode usar tab para completar os comandos
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' | sed -e 's|^\ ||'

env.env: ## Target de apoio. Carrega o arquivo env de acordo com a base escolhida
	@if [ ! -f "env.env" ]; then \
	cp envs/env-$(base).env env.env; \
	echo "Arquivo env.env nao existia. Copiado o arquivo default da pasta envs."; \
	echo "Se for o caso, faca as alteracoes nele antes de subir o ambiente."; \
	echo ""; sleep 5; \
	fi


check-super-path:  ## Target de apoio. Verifica se o codigo do Super existe no local indicado
	@if [ ! -f $(SUPER_PATH)/sei/web/SEI.php ]; then \
	echo "$${MENSAGEM_AVISO_FONTES}" ; \
	echo ""; \
	exit 1 ; \
	fi


# acessa o super e verifica se esta respondendo a tela de login
check-super-isalive: ## Target de apoio. Verifica se o Super respondeu a tela de login
	@echo ""
	@echo "Vamos tentar acessar a pagina de login do SUPER, vamos aguardar por 45 segs."
	@for number in 1 2 3 4 5 6 7 8 9 ; do \
	    echo 'Tentando acessar...'; var=$$(echo $$($(CMD_CURL_SUPER_LOGIN))); \
			if [ "$$var" != "" ]; then \
					echo 'Pagina respondeu com tela de login' ; \
					echo 'Acesse com $(HOST_URL)/sei ou $(HOST_URL)/sip' ; \
					break ; \
			else \
			    echo 'Aguardando resposta ...'; \
			fi; \
			sleep 5; \
	done

## prerequisites-up: Target de apoio. Encadeia env.env e check-super-path
prerequisites-up: env.env check-super-path


## up: Sobe o projeto, mas antes verifica os pre-requisitos
up: prerequisites-up
	docker-compose --env-file env.env up -d
	make check-super-isalive


config: ## sobreescreve o arquivo env.env para uma nova base de dados. Ex: make base=sqlserver config
	@cp -f envs/env-$(base).env env.env
	@echo "Ambiente configurado para utilizar a base de dados $(base). (base=[mysql|oracle|sqlserver])"


down: ## apenas para o projeto com possibilidade de subir novamente mais tarde
	docker-compose --env-file env.env down


## restart: Roda os targets down e up na sequencia
restart: down up


## destroy: destroi os componentes e também apaga os volumes de dados
destroy: env.env
	docker-compose --env-file env.env down --volumes
