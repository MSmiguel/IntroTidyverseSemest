#---- Aula 2 ------
# Continuação do dplyr
# Além disso, o  Tidyverse se utiliza do dialeto do R para simplificar a seleção de variáveis:
# Sequencial (:) - para selecionar uma sequencia de colunas:
swiss %>% select(., Agriculture:Catholic)

# Exclusão (!) - para excluir a coluna indesejada:
swiss %>% select(., !Catholic)

# União ou interseção (|; &)
swiss %>% select(., starts_with("E") | Infant.Mortality)
swiss %>% select(., ends_with("ty") & Infant.Mortality)
swiss %>% select(., ends_with("nation") & starts_with("E")| starts_with("A"))

# Combinação (c())
swiss %>% select(., c(contains("tion"), ends_with("ty"), "Agriculture"))


# Renomear colunas.

swiss %>% select(., c(contains("tion"), ends_with("ty"), "Agriculture"), Agricultura = Agriculture)

# Note que:
# As linhas não são modificadas;
# As colunas são um subconjunto do banco original.  



# Filtrar ####
# FILTER - Ao contrário da função anterior, o filter seleciona linhas através de condições indicadas.
# Os operadores logicos (==, > , <, >=, <=, &,...) e as constantes lógicas do R (is.na, near, between, ...)
# podem ser utilizados nesta função.
swiss %>% filter(., Infant.Mortality == 20.0)
swiss %>% filter(., between(Infant.Mortality, 10, 20))

# Além disso, pode ser utilizado em múltiplas variáveis dentro do filter.
swiss %>% filter(., between(Infant.Mortality, 15, 20) & Agriculture >= 50)
swiss %>% filter(., between(Infant.Mortality, 10, 20) | Agriculture >= 50)

iris %>% filter(., Species == "setosa", between(Sepal.Width, 3.5, 4))
iris %>% filter(., (Species == "virginica" & Sepal.Length > 6.5) | (Sepal.Width < 3.3))

# Note que:
# As linhas são subconjuntos do banco de dados original e a ordem das linhas é mantida. 
# As colunas não são modificadas.



# Ordenar ####
# ARRANGE - é utilizada para ordenar as linhas de um data frame a partir de uma ou mais colunas selecionadas.
swiss %>% arrange(Fertility)
swiss %>% arrange(desc(Education), Fertility)
swiss %>% arrange(desc(Education))

iris %>% arrange(., Petal.Width, Petal.Length)

# Se tivermos uma variável qualitativa ordenada, podemos ordenar por ela. Ex.:
iris$Species <- factor(iris$Species, levels = c("virginica", "setosa", "versicolor"))
str(iris)

iris %>% arrange(Species)

iris$Species <- as.character(iris$Species)
str(iris)
# A função across aplica uma função a multiplas colunas e é possível utilizar a semântica do select dentro dela.
iris %>% arrange(across(starts_with("Sepal")))

# Note que: 
# Todas as colunas aparecerão na saída, no entanto, em ordens diferentes.
# As linhas e colunas não são modificadas.



# Modificar ####
# MUTATE / TRANSMUTE - Para modificar variáveis pode-se utilizar o mutate ou o transmute.
# O mutate é utilizado para adicionar variáveis (colunas) preservando todas as as colunas pré existentes.
iris %>% mutate(Species = toupper(Species))

# Operadores matemáticos podem ser utilizados.
iris %>% mutate(Sepal.Length.meter = Sepal.Length / 100)

iris %>% mutate(Sepal.Length.meter = Sepal.Length / 100,
                Sepal.Width.meter = Sepal.Width / 100)

# Bem como modificar o conteúdo mantendo os nomes.
iris %>% mutate(Petal.Length = Petal.Length / 100,
                Petal.Width = Petal.Width / 100,
                Species = toupper(Species))

# Operadores lógicos também podem ser utilizados.
iris %>% mutate(Setosa = if_else(Species == "setosa", "É setosa", "Não é setosa"))

# No entanto, o transmute modifica as colunas e descarta as colunas pré existentes.
iris %>% transmute(Petal.Length.meter = Petal.Length / 100,
                   Petal.Width.meter = Petal.Width / 100,
                   SPECIES = toupper(Species))



# Agrupamento e sumarização ####
# GROUP_BY - esta função agrupa a partir de uma ou mais variáves e assim realiza as operações nestes grupos.
# SUMMARISE - esta função serve para resumir as variáveis.

iris %>% group_by(Species)  

iris %>% group_by(Species) %>%
  select(., contains("Length")) %>% 
  filter(Sepal.Length > 5)

# Contagem
iris %>% summarise(n())


# Medidas de tendencia central e variabilidade
iris %>% summarise(mean(Sepal.Length))

iris %>% summarise(media.spl.lth = mean(Sepal.Length))


iris %>% summarise(media.spl.lth = mean(Sepal.Length),
                   sd.spl.lth = sd(Sepal.Length))

# Valores lógicos

iris %>% summarise(any(Sepal.Length == 6))

# Misturando
iris %>% group_by(Species) %>% summarise(n())

iris %>% group_by(Species) %>% 
  summarise(., media.Spl.Lth = mean(Sepal.Length),
            dp.Spl.Lth = sd(Sepal.Length))







# Spoiler de ggplot 
iris %>% ggplot(., aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point()

iris %>% group_by(Species) %>% 
  ggplot(., aes(x = Sepal.Length, y = Petal.Length, colour = Species)) +
  geom_point() 

iris %>% group_by(Species) %>% 
  ggplot(., aes(x = Sepal.Length, y = Petal.Length, colour = Species)) +
  geom_point() +
  facet_wrap(~Species)

iris %>% group_by(Species) %>%  
  ggplot(., aes(x = Sepal.Length, y = Petal.Length, colour = Species)) +
  geom_point() +
  facet_wrap(~Species) 

#------ Limpando dados  -----
#instalando tidyr
#install.packages("tidyr")
library(tidyr)
#Exemplo
#**********************gather*******************************#
#gather faz com que colunas se tornem uma única coluna.
#key é o nome da coluna que será criada.
#value é o nome da coluna que irá receber os valores.
#E após indicar os argumentos key e value, colocar as colunas que serão
#transformadas em uma única.
dados_wide <- tibble(Estado = c("PA", "AM"), 
                     `2019` = c(8636113, 4144597), 
                     `2020` = c(8690745, 4207714))

dados_long <- dados_wide %>% 
  gather(key = "Ano", value = "Populacao", "2019", "2020")
dados_long

dados_long <- dados_wide %>% 
  gather(key = "Ano", value = "Populacao", "2019", "2020", convert = TRUE)
dados_long

dados_long <- dados_wide %>% 
  pivot_longer(cols = c("2019","2020"),
               names_to = "Ano",
               values_to = "Populacao"
  )
dados_long

dados_long <- dados_wide %>% 
  pivot_longer(cols = c("2019","2020"),
               names_to = "Ano",
               values_to = "Populacao",
               names_transform = list("Ano" = as.integer())
  )
dados_long

#install.packages("gapminder")
library(gapminder)
head(gapminder)
gapminder_long <- gapminder %>%
  pivot_longer(
    cols = lifeExp:gdpPercap,
    names_to = "Variavel",
    values_to = "Valor"
  )

#**********************spread******************************#
#spread faz a operação inversa da gather
#ou seja, faz com que variáveis que estão em uma coluna se tornem colunas
#key é a coluna que possue as variáveis que irão virar colunas
#value é a variável que será distribuida entre as colunas criadas

dados_wide <- dados_long %>% 
  spread(key = Ano, value = Populacao)
dados_wide

gapminder_wide <- gapminder_long %>%
  pivot_wider(
    names_from = Variavel,
    values_from = Valor
  )

# link para ver mais sobre pivoteamento: 
# https://www.r-bloggers.com/2019/10/data-pivoting-with-tidyr/

#*******************unite********************************#
#juntar colunas usando um caractere

gapminder_unite <- gapminder %>% 
  unite(col = "Pais_Continet_Ano", country, continent, year, 
        sep = "/", remove = TRUE)

#*********************separate*******************************#
#separar colunas de acordo com um caracter especifico

gapminder_unite_separate <- gapminder_unite %>% 
  separate(col = "Pais_Continet_Ano", 
           into = c("country", "continent", "year"), 
           sep="/")

gapminder_unite_separate <- gapminder_unite %>% 
  separate(col = "Pais_Continet_Ano", 
           into = c("country", "continent", "year"), 
           sep="/",convert = TRUE)


#*******************drop_na************************#
#deletando as linhas que possuem ao menos um NA
#ou seja, só registros completos

Exemplo1 <- tibble(Sexo = c("M","F","M","F"),
                   Idade = c(23,24,NA,NA),
                   Altura = c(1.72,1.65,NA,1.60)
)

Exemplo1.sem.na <- Exemplo1 %>% drop_na() 
#deletando as linhas usando colunas específicas
#deletando as linhas que possuem  NA na coluna Altura
Exemplo1.sem.na.alt <- Exemplo1 %>% drop_na(Altura)
#deletando as linhas que possuem  NA na coluna Idade
Exemplo1.sem.na.Idad <- Exemplo1 %>% drop_na(Idade)

# ------- Juntando dados ------
#União de dados (Union)
#função union ou union_all
library(dplyr)
dados2016 <- data.frame(ano = c(2016, 2016, 2016), 
                        valor = c(938, 113, 1748), 
                        produto = c('A', 'B', 'C'))

dados2017 <- data.frame(valor = c(8400, 837, 1748), 
                        produto = c('H', 'Z', 'C'),
                        ano = c(2017, 2017, 2016))

dados2018 <- data.frame(ano = c(2018, 2018, 2018), 
                        valor = c(938, 113, 1748), 
                        produto = c('A', 'B', 'C'),
                        tipo = c("X1","X2","X3"))
#usando o union remove duplicadas
dados.finais.union <- union(dados2016, dados2017)


#usando o union_all permanece valores duplicadas
dados.finais.union_all <- union_all(dados2016, dados2017)

#union não permite unir data.frames com tamanhos diferentes
dados.finais2.union <- union(dados2016, dados2018)

#union não permite unir data.frames com tamanhos diferentes
dados.finais2.union_all <- union_all(dados2016, dados2018)


#inner_join
id.empregado <- 1:11
nome.empregado <- c('Renato', 'Miguel', 'Paulo', 
                    'Patrícia', 'Inês', 'Saulo', 
                    'Diego', 'Maria', 'Jose', 'Julia', 
                    'Tiago')
idade <- c(30, 31, 29, 30, 25, 30, 30, 35, 24, 31, 29)
uf <- c('MG', 'DF', 'CE', 'DF', 'DF', 'DF', 'RJ', 'SP', 
        'RS', 'SC', 'BA')
id.cargo <- c(4, 4, 4, 4, 5, 4, 6, 3, 1, 2, 8)
empregados <- data.frame(id.empregado, nome.empregado, 
                         idade, uf, id.cargo)

id.cargo <- 1:7
nome.cargo <- c('Técnico', 'Assistente', 'Consultor', 'Analista', 'Auditor', 'Gerente', 'Gestor')
salario <- c(7000, 4000, 15000, 11000, 10000, 13000, 20000)
cargos <- data.frame(id.cargo, nome.cargo, salario)

join.dplyr <- inner_join(empregados, cargos, 
                         by = c("id.cargo" = "id.cargo"))
#O inner join despreza os registros de ambos os data.frames 
#onde as chaves não coincidem.
#Mas existem situações em que esse descarte de registro 
#não é interessante. Nesses casos usamos Outer join.
#Existem 3 tipos básicos de outer join: full outer join 
#(ou apenas full join), left outer join (ou só left join) 
#e o right outer join (ou só right join).

#Left outer join (Left join)
#preserva todos os registros do data.frame da esquerda.
left.join.dplyr <- left_join(empregados, cargos, 
                             by = c("id.cargo" = "id.cargo"))

#Right outer join (Right join)
#preserva todos os registros do data.frame da esquerda.
right.join.dplyr <- right_join(cargos, empregados, 
                               by = c("id.cargo" = "id.cargo"))

#Full outer join (Full join)
#preservar os registros das duas tabelas
full.join.dplyr <- full_join(cargos, empregados, 
                             by = c("id.cargo" = "id.cargo"))