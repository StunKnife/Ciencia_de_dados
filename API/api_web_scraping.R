#-----------------------#
# Obtendo dados por API
#-----------------------#

#O que é API?

#Application Programming Interface (API) é uma forma de comunicação de dados mais apropriada para as trocas de informações entre softwares.
#Normalmente APIs trocam dados em formato hierárquico. Os dois formatos hierárquicos mais comuns são
#Javascript Object Notation (JSON) e eXtensible Markup Language (XML).


#Pacotes

library(jsonlite)
library(dplyr)


#pag 69

#No exemplo a seguir utilizamos a API do github (portal para repositórios) e veremos quais os repositórios
#do Hadley Wickham:

hadley.rep <- jsonlite::fromJSON("https://api.github.com/users/hadley/repos")
dim(hadley.rep)

head(hadley.rep[,c('name', 'description')], 15)

#Outro exemplo de API muito interessante é o portal de dados abertos da Câmara dos Deputados. Eles
#possuem diversas APIs para consultar os dados do processo legislativo. Veja o exemplo a seguir, que resgata
#as proposições utilizando API:

proposicoes <- jsonlite::fromJSON("https://dadosabertos.camara.leg.br/api/v2/proposicoes")

head(proposicoes$dados %>% select(siglaTipo, numero, ano, ementa))

#---------------#
# Web Scrapping #
#---------------#

#Existe um pacote em R que facilita muito o cosumo de dados em HTML: rvest, criado também por Hadley
#Wickham. O rvest mapeia os elementos HTML (tags) de uma página web e facilita a "navegação" do R
#por esses nós da árvore do HTML. 

#Veja o exemplo a seguir:


library(rvest)
html <- read_html("https://pt.wikipedia.org/wiki/Organiza%C3%A7%C3%A3o_das_Na%C3%A7%C3%B5es_Unidas")

html.table <- html %>% html_nodes("table")

html.table

dados <- html.table[[1]] %>% html_table()
dados <- dados %>%  select("wikitable")
head(dados)

#Obtivemos todo o HTML da página, mapeamos os nós de tabela (table) e pegamos seu conteúdo. A partir
#daí, trata-se de um dataframe normal, que pode ser manipulado com o dplyr.

