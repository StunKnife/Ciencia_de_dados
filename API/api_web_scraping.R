#-----------------------#
# Obtendo dados por API
#-----------------------#

#O que � API?

#Application Programming Interface (API) � uma forma de comunica��o de dados mais apropriada para as trocas de informa��es entre softwares.
#Normalmente APIs trocam dados em formato hier�rquico. Os dois formatos hier�rquicos mais comuns s�o
#Javascript Object Notation (JSON) e eXtensible Markup Language (XML).


#Pacotes

library(jsonlite)
library(dplyr)


#pag 69

#No exemplo a seguir utilizamos a API do github (portal para reposit�rios) e veremos quais os reposit�rios
#do Hadley Wickham:

hadley.rep <- jsonlite::fromJSON("https://api.github.com/users/hadley/repos")
dim(hadley.rep)

head(hadley.rep[,c('name', 'description')], 15)

#Outro exemplo de API muito interessante � o portal de dados abertos da C�mara dos Deputados. Eles
#possuem diversas APIs para consultar os dados do processo legislativo. Veja o exemplo a seguir, que resgata
#as proposi��es utilizando API:

proposicoes <- jsonlite::fromJSON("https://dadosabertos.camara.leg.br/api/v2/proposicoes")

head(proposicoes$dados %>% select(siglaTipo, numero, ano, ementa))

#---------------#
# Web Scrapping #
#---------------#

#Existe um pacote em R que facilita muito o cosumo de dados em HTML: rvest, criado tamb�m por Hadley
#Wickham. O rvest mapeia os elementos HTML (tags) de uma p�gina web e facilita a "navega��o" do R
#por esses n�s da �rvore do HTML. 

#Veja o exemplo a seguir:


library(rvest)
html <- read_html("https://pt.wikipedia.org/wiki/Organiza%C3%A7%C3%A3o_das_Na%C3%A7%C3%B5es_Unidas")

html.table <- html %>% html_nodes("table")

html.table

dados <- html.table[[1]] %>% html_table()
dados <- dados %>%  select("wikitable")
head(dados)

#Obtivemos todo o HTML da p�gina, mapeamos os n�s de tabela (table) e pegamos seu conte�do. A partir
#da�, trata-se de um dataframe normal, que pode ser manipulado com o dplyr.

