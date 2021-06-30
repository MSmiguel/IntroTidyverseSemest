#--- O tidyverse ----
#Comando para instalar: install.packages("tidyverse")

library(tidyverse)

#------ pacote tibble -----
#dataset iris

iris_df <- iris

#transformando um data.frame em tibble usando o comando as_tibble

iris_tibble <- as_tibble(iris)

#printando data.frame

iris_df

#printando tibble

iris_tibble

#printando usando o glimpse

glimpse(iris_df)

glimpse(iris_tibble)

#vendo um resumo da tabela usando o pacote skimr 
#obs: skimr não é do tidyverse
#install.packages("skimr")

library(skimr)
skim(iris_tibble)

#não precisa utilizar o library para chamar uma função de um pacote

skimr::skim(iris_tibble)

#vantagens
#1 - o código executa mais rápido pois são carregadas 
#menos funções no ambiente global (Global Enviroment)

#2 - ajuda na criação de pacotes pois é mais fácil de identificar as 
#dependências


#----- leitura de dados (pacotes readr e readxl) ------
# Funções de importação: read_*()

#read_delim

iris1 <- read_delim(file = "iris_csv.csv", delim = ",", col_names = TRUE,
                    col_types = NULL, na = c("","NA"), skip = 0,
                    skip_empty_rows = TRUE)

#atribuindo o tipo de coluna

iris1 <- read_delim(file = "iris_csv.csv", delim = ",", col_names = TRUE,
                    col_types = cols(
                      Comprimento_Sepala = "d",
                      Largura_Sepala = "d",
                      Comprimento_Petala = "d",
                      Largura_Petala = "d",
                      Especies = "f"
                    ), na = c("","NA"), skip = 0, skip_empty_rows = TRUE)

#ou

iris1 <- read_delim(file = "iris_csv.csv", delim = ",", col_names = TRUE,
                    col_types = cols(
                      Comprimento_Sepala = col_double(),
                      Largura_Sepala = col_double(),
                      Comprimento_Petala = col_double(),
                      Largura_Petala = col_double(),
                      Especies = col_factor(levels=NULL)
                    ), na = c("","NA"), skip = 0, skip_empty_rows = TRUE)

#atribuindo o tipo de coluna em colunas especificas

iris1 <- read_delim(file = "iris_csv.csv", delim = ",", col_names = TRUE,
                    col_types = cols(Especies = "f"), 
                    na = c("","NA"), skip = 0, skip_empty_rows = TRUE)

#Carregando colunas selecionadas (cols_only)

iris1 <- read_delim(file = "iris_csv.csv", delim = ",", col_names = TRUE,
                    col_types = cols_only(Especies = "f"), 
                    na = c("","NA"), skip = 0, skip_empty_rows = TRUE)

#read_csv

iris2 <- read_csv(file = "iris_csv.csv", col_names = TRUE,
                  col_types = NULL, na = c("","NA"),skip = 0,
                  skip_empty_rows = TRUE)
#read_csv2

iris3 <- read_csv2(file = "iris_csv2.csv", col_names = TRUE,
                   col_types = NULL,na = c("","NA","SI"), skip = 0,
                   skip_empty_rows = TRUE)
#read_tsv, separador tab

iris4 <- read_tsv(file = "iris_tab.txt", col_names = TRUE,
                  col_types = NULL, na = c("","NA"), skip = 0,
                  skip_empty_rows = TRUE)
#read_delim com separador |

iris5 <- read_delim(file = "iris_txt.txt", delim = "|", col_names = TRUE,
                    col_types = NULL, na = c("","NA"), skip = 0,
                    skip_empty_rows = TRUE)

#uma forma de descobrir o separador de colunas sem carregar a base toda
readLines(con = "iris_csv.csv", n = 2)

#Arquivos excel

library(readxl) #não pertence ao tidyverse, mas harmoniza

#Lendo o arquivo iris usando read_excel

iris6 <- read_excel(path = "iris_xlsx.xlsx", sheet = 1, col_names = TRUE,
                    col_types = NULL, na = c("","NA","SI"), skip = 0)


#------ Manipuação de dados (pacotes dplyr e tidyr) ----

#----- Operador %>% -----

#Exemplo: vamos calcular a raiz quadrada da soma dos valores 
#de 1 a 4 e arredondar o valor da raiz para duas casas decimais.

#Sem usar o pipe
x <- c(1, 2, 3, 4)
sum(x)
round(sqrt(sum(x)), 2)

#usando o pipe
#o pipe use o objeto à esquerda do pipe (%>%) como o primeiro
#argumento da função à direita do pipe

#arredondando o número de 2.333 usando pipe

2.333 %>%  round(2)

#sem usar o pipe

round(2.333, 2)

#vamos calcular a raiz quadrada da soma dos valores 
#de 1 a 4 e arredondar o valor da raiz para duas 
#casas decimais usando o pipe

x %>% sum %>% sqrt %>% round(2)

#também é possível dizer em qual argumento específico quero atribuir
#o elemento da esquerda. Exemplo:

2 %>%  round(2.333, digits = .)
round(2.333, 2)
# Manipulação com o pacote dplyr
# O Pacote dplyr é composto por funções de aplicação básicas, porém essenciais, na manipulação de dados.
# É um pacote voltado para a organização de dados e com ele podemos filtrar, ordernar, agregar, resumir
# (contagem, média,...), entre outras funções.
# Vamos nos ater as seguintes funções:

select()
filter()
arrange()
mutate()
group_by()
summarise()

# BANCO DE DADOS ####

# swiss ---> Swiss Fertility and Socioeconomic Indicators (1888) Data
# Esse banco se refere a dados socioeconomicos e de fertilidade de 47 províncias de falantes de francês
# da Suiça.
data(swiss)

# iris ---> Edgar Anderson's Iris Data
# Esse banco dá as medidas em centímetros das características de tres especies de íris.
data(iris)



# Selecionar ####
# SELECT - A função select, em uma abordagem bem simplista, é utilizada para seleção de colunas em um
# data frame.


# Ex:
swiss %>% select(., Infant.Mortality)

iris %>% select(., Sepal.Length, Species)


# Mas o select não se resume a isso. Podemos selecionar variáves de acordo com um padrão:

# Ex. starts_with():
swiss %>% select(., starts_with("E"))
iris %>% select(., starts_with("Petal"))

# Ex. ends_with():
swiss %>% select(., ends_with("ty"))
iris %>% select(., ends_with(".Length"))

# Ex. contains():
swiss %>% select(., contains("ti"))
iris %>% select(., contains("."))

# Ex. matches():
swiss %>% select(., matches("\\wit"))  # Pode ser usado com regex.
swiss %>% select(., contains("\\wit")) # Não funciona com regex só com expressoes simples.

# \\w significa que o programa vai buscar qualquer caractere de palavra (letras em geral).
# No exemplo acima, a função irá buscar qualquer letra + as letras "it".

swiss %>% select(., matches("\\."))  # Usado com regex.
swiss %>% select(., contains("\\.")) # Não funciona com regex.

iris %>% select(., matches("^S"))
iris %>% select(., contains("^S"))

swiss %>% select(., matches("t\\.$")) 
swiss %>% select(., matches("t\\."))


# Ver mais sobre regular expressions.
# Cheat sheet.
