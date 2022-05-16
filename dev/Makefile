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

help:
	@echo "Todo: elaborar help dos makefiles e tb README"


env.env:
	@if [ ! -f "env.env" ]; then \
	cp envs/env-$(base).env env.env; \
	echo "Arquivo env.env nao existia. Copiado o arquivo default da pasta envs."; \
	echo "Se for o caso, faca as alteracoes nele antes de subir o ambiente."; \
	echo ""; sleep 5; \
	fi


check-super-path:
	@if [ ! -f $(SUPER_PATH)/sei/web/SEI.php ]; then \
	echo "$${MENSAGEM_AVISO_FONTES}" ; \
	echo ""; \
	exit 1 ; \
	fi


# acessa o super e verifica se esta respondendo a tela de login
check-super-isalive:
	@echo ""
	@echo "Vamos tentar acessar a pagina de login do SUPER, vamos aguardar por 45 segs."
	@for number in 1 2 3 4 5 6 7 8 9 ; do \
	    echo 'Tentando acessar...'; var=$$(echo $$($(CMD_CURL_SUPER_LOGIN))); \
			if [ "$$var" != "" ]; then \
					echo 'Pagina respondeu com tela de login' ; \
					break ; \
			else \
			    echo 'Aguardando resposta ...'; \
			fi; \
			sleep 5; \
	done


prerequisites-up: env.env check-super-path



up: prerequisites-up
	docker-compose --env-file env.env up -d
	make check-super-isalive


config:
	@cp -f envs/env-$(base).env env.env
	@echo "Ambiente configurado para utilizar a base de dados $(base). (base=[mysql|oracle|sqlserver])"


down: 
	docker-compose --env-file env.env down


restart: down up


destroy: 
	docker-compose --env-file env.env down --volumes

