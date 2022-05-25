# SUPER-DOCKER


## O que é

O Super-Docker é o projeto disponibilizado para provisionamento de ambientes do Super usando a tecnologia docker e os orquestradores docker-compose, cattle ou kubernetes.

## Para quem

O projeto atende a qualquer dos profissionais que desejem subir uma instância do Super entre eles:
- desenvolvedores
- arquitetos
- analistas de testes
- analistas de segurança (para avaliação/mapeamento de eventuais vulnerabilidades)
- profissionais de TI envolvidos nas atividades de dev e sustentação do Super

## Para que

- desenvolvimento/debug do código-fonte do Super
- desenvolvimento/debug do código-fonte dos módulos do Super
- disponibilização de ambientes diversos para o Super:
	- teste
	- treinamento
	- avaliação
- ambientar profissional de infra com os serviços/componentes necessários para a implantação e sustentação do Super

# Organização

Podemos dividir o projeto em 3 grandes áreas:

- ### Dev

	Na pasta dev há um Automatizador (Makefile) pronto para subir uma instância do Super escolhendo a base de dados e com o xdebug habilitado. Apropriada para subir um ambiente local montando o código fonte do Super. Desta forma você pode usar o seu editor / debugger preferido na edição do código.

	Nessa modalidade o projeto disponibiliza para o desenvolvedor os seguintes componentes:
	- app  (serviço apache para o Super)
	- database (mariadb, sqlserver ou oracle)
	- memcached
	- jod
	- solr
	- mailcatcher (servidor smtp e mailcatcher para visualizar os emails enviados)

	Para maiores informações, acesse a pasta dev e leia o Readme respectivo ou [clique aqui](dev/README.md) para abrir diretamente

- ### Arquitetos e profissionais de infra

	Na pasta infra há um Automatizador (Makefile) pronto para que um profissional de infra suba rapidamente a estrutura completa do Super usando o docker-compose, com opçoes de: 
	- openldap
	- simulador de servidor de email
	- solr admin
	- memcached admim
	- instalacao automática de módulos
	- orgao, siglas e descricoes do ambiente
	- http ou https, com cert proprio ou auto-assinado
	- entre outras customizações

	Usado para criar ambientes de teste, validação, treinamento, tanto para a área técnica quanto para a área negocial

	Há a possibilidade de subir toda a infra em uma única vm ou gerar as receitas kubernetes ou Cattle para rodar em seu cluster local

	Para maiores informações, acesse a pasta infra e leia o Readme respectivo ou [clique aqui](infra/README.md) para abrir diretamente

- ### Containers

	Na pasta containers encontram-se as receitas para as imagens docker. Os conteineres já existem de forma pública para você rodar o projeto em sua máquina local ou infra. Não é necessário entrar aqui ou conhecer essa área para rodar o Super.

	Mas caso mesmo assim deseje buildar as imagens por conta própria, modificá-las ou usar o seu próprio registry; basta acessar essa pasta. Nela estão as receitas docker usadas, bem como as automatizações (Makefile) para criar seus próprios conteineres em seu próprio Docker Registry.

	Para maiores informações, acesse a pasta containers e leia o Readme respectivo ou [clique aqui](containers/README.md) para abrir diretamente

## Testes

Caso faça alguma alteração no projeto, rode os testes propostos para garantir que pelo menos o básico está funcionando de acordo com o esperado.

Dentro de cada grande área há uma pasta de testes.
Nessas pastas ficam os testes automatizados para cada área:

- **containers/tests**: existem diversos testes para os conteineres.

	Rode ``` make test-containers ``` para executar uma bateria com todos os subtestes envolvidos. Aqui ele vai criar os conteineres com a tag test e tentará fazer o push bem como outras operações previstas no makefile

- **dev/tests**: aqui ele irá usar os modelos de envfiles fornecidos, subirá o Super para cada um deles e rodará testes de criacao de processo/documento para saber se está ou não funcionando.

	Rode ``` make tests-all-bases ``` para executar a bateria com todos os subtestes envolvidos.

- **infra/tests**: existem diversos testes para a área de infra. Como são muitas possibilidades de customização esse teste é demorado. O automatizador vai subir e destruir o Super diversas vezes variando as formas e possibilidades de customização.

	Rode ``` make test_lineup_completa ``` para executar todos os subtestes envolvidos. Dependendo da necessidade pode executar os subtestes isoladamente, basta digitar ``` make help ``` para uma lista completa das opções disponíveis.



# Pré-Requisitos

Para utilizar esse projeto você precisa de:
- código fonte do Super
- docker
- docker-compose

# Origem

Este projeto é a junção de dois outros projetos:
- [Sei-Vagrant](https://github.com/spbgovbr/sei-vagrant)
- [Sei-Docker](https://github.com/spbgovbr/sei-docker)


# Dúvidas Sugestões Bugs ou Contribuição

Dúvidas, sugestões ou reporte de bugs usar a parte de issues: https://github.com/supergovbr/super-docker/issues

Para contribuir basta fazer o pull request. Aconselhável antes alinhar os requisitos com algum project owner.

