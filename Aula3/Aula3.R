#------Visualização de dados (pacote ggplot2)-----
#---------------Pacotes que serao utilizados-----------------#
library(tidyverse)
#--------Principais gráficos usando o ggplot2----------------#
#-------------------------------------------------------------#
# Primeiro Gráfico: Gráfico de dispersão
# Tipo de variáveis: quantitativa x quantitativa
# Iremos exemplificar com data.frame iris existente no R
#carregando o data.frame iris
data(iris)
#vendo a estrutura
str(iris)
# Vamos ver a relação existente entre o Tamanho da Sépala 
#(Sepal.Length) e o Tamanho da Pétala(Petal.Length)

ggplot(data = iris) + 
  geom_point(mapping = aes(x = Sepal.Length, y = Petal.Length))

#temos os seguintes argumentos para os atributos estéticos 
#que podemos atribuir:

#color para definir a cor dos pontos.
#shape para definir o símbolo dos pontos.
#size para definir o tamanho dos pontos.


#atribuindo o argumento color, as cores serão de acordo com a espécie
ggplot(data = iris) + 
  geom_point(mapping = aes(x = Sepal.Length, 
                           y = Petal.Length, 
                           color = Species))

#além das cores podemos mexer no formato dos pontos (shape)
ggplot(data = iris) + 
  geom_point(mapping = aes(x = Sepal.Length, 
                           y = Petal.Length, 
                           color = Species,
                           shape = Species))

#aumentando o tamanho dos pontos de acordo com a largura da pétala
#(Petal.Width)
ggplot(data = iris) + 
  geom_point(mapping = aes(x = Sepal.Length, 
                           y = Petal.Length, 
                           color = Species,
                           size = Petal.Width))
#Neste gráfico de dispersão podemos adicionar uma linha de tendência
#para visualizar a tendência geral
#para isto adicionamremos a camada geom_smooth()
ggplot(data = iris) + 
  geom_point(mapping = aes(x = Sepal.Length, 
                           y = Petal.Length, 
                           color = Species)) +
  geom_smooth(mapping = aes(x = Sepal.Length, 
                            y = Petal.Length))
#podemos ver a tendência por espécie
ggplot(data = iris) + 
  geom_point(mapping = aes(x = Sepal.Length, 
                           y = Petal.Length, 
                           color = Species)) +
  geom_smooth(mapping = aes(x = Sepal.Length, 
                            y = Petal.Length, 
                            color = Species))
#Posso definir os atributos estéticos (aes()) diretamente na função
#ggplot() e não no objeto geométrico. 
#O que isto significa? Que o mapeamento estético definido na função 
#ggplot() é global. Ou seja, é aplicado para todos os objetos 
#geométricos daquele gráfico, não precisarei repetir os argumentos 
#nas geoms, a menos que seja explicitado novamente em alguma camada.
#Exemplo
ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                  y = Petal.Length, 
                                  color = Species)) + 
  geom_point() +
  geom_smooth()
# podemos desligar a área cinza, que é o intervalo de confiança, 
# passando o argumento se = FALSE
# vamos também aumentar os pontos e esclarecer eles, 
# basta colocar na geom_point o argumento size e o argumento alpha
ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                  y = Petal.Length, 
                                  color = Species)) + 
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(se = FALSE)

#podemos mudar o método de regressão, o padrão é regressão local(loess)
#mas podemos mudar para regressão linear, basta colocar
#em geom_smooth o argumento method = "lm"

ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                  y = Petal.Length, 
                                  color = Species)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# adicionando facetas
ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                  y = Petal.Length, 
                                  color = Species)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(. ~ Species) #dividi por especie e fixa o eixo y

ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                  y = Petal.Length, 
                                  color = Species)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(Species ~ .) #dividi por especie e fixa o eixo x


# posso atribuir um gráfico criado a um objeto
graf <- ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                          y = Petal.Length, 
                                          color = Species)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

#vendo o gráfico que está no objeto graf
graf

# agora basta colocar as demais camadas ao objeto graf
graf + facet_grid(. ~ Species) 

#mudando os nomes (labels) de cada faceta usando o argumento labeller
#criando o vetor com os nomes que queremos para cada categoria
lab_name_species <- c("setosa" = "Setosa", "versicolor" = "Versicolor", 
                      "virginica" = "Virginica")
graf+facet_grid(.~ Species, labeller = labeller(Species = lab_name_species))

# colocando nomes dos eixos, titulo e nome das legendas
graf + 
  facet_grid(. ~ Species, labeller = labeller(Species = lab_name_species)) +
  xlab("Tamanho da Sépala") +
  ylab("Tamanho da Pétala") +
  ggtitle("Gráfico de dispersão entre o Tamanho da Pétala e o da Sépala") +
  #mudando a legenda
  scale_color_discrete(name = "Espécie",
                       labels = lab_name_species) + 
  theme(plot.title = element_text(hjust = 0.5))

#customizando outro forma de visualizacao
graf2 <- ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                           y = Petal.Length, 
                                           color = Species,
                                           size = Petal.Width)) + 
  geom_point()
# mostrando o grafico guardado pelo objeto graf2
graf2
#customizando
graf2 + xlab("Tamanho da Sépala") + ylab("Tamanho da Pétala") +
  ggtitle("Gráfico de dispersão entre o Tamanho da Pétala e o da Sépala") +
  scale_color_discrete(name = "Espécie",
                       labels = lab_name_species) + 
  scale_size_continuous(name = "Largura da Pétala",
                        breaks = c(0.5,1.5,2.5)) +
  theme(plot.title = element_text(hjust = 0.5))

#customizando outro forma de visualizacao
graf3 <- ggplot(data = iris, mapping = aes(x = Sepal.Length, 
                                           y = Petal.Length, 
                                           color = Petal.Width)) + 
  geom_point()
# mostrando o grafico guardado pelo objeto graf3
graf3
# customizando 
graf3 + xlab("Tamanho da Sépala") + ylab("Tamanho da Pétala") +
  ggtitle("Gráfico de dispersão entre o Tamanho da Pétala e o da Sépala") +
  scale_color_continuous(name = "Largura da Pétala",
                         breaks = c(0.5,1.5,2.5),
                         type = "viridis")+
  scale_x_continuous(breaks = 3:10, limits = c(3,10))+
  scale_y_continuous(breaks = 0:7, limits = c(0,7))+
  theme(plot.title = element_text(hjust = 0.5))


#--------Principais gráficos usando o ggplot2----------------#
#-------------------------------------------------------------#
# Segundo Gráfico: Boxplot
# Iremos exemplificar com data.frame iris existente no R
#carregando o data.frame iris
data(iris)
#para criar o boxplot usaremos geom_boxplot
ggplot(data = iris, mapping =  aes(y = Sepal.Length)) +
  geom_boxplot()

#vendo o boxplot por espécie
ggplot(data = iris, mapping =  aes(x = Species, y = Sepal.Length)) +
  geom_boxplot()

#colorindo os boxplots
ggplot(data = iris, mapping =  aes(x = Species, y = Sepal.Length, 
                                   color = Species)) +
  geom_boxplot()

#colorindo os boxplots
ggplot(data = iris, mapping =  aes(x = Species, y = Sepal.Length, 
                                   fill = Species)) +
  geom_boxplot()

#invertendo os eixos com coord_flip
ggplot(data = iris, mapping =  aes(x = Species, y = Sepal.Length, 
                                   fill = Species)) +
  geom_boxplot() +
  coord_flip()

#colocando valor médio utilizando stat_summary
ggplot(data = iris, mapping =  aes(x = Species, y = Sepal.Length, 
                                   fill = Species)) +
  geom_boxplot() +
  stat_summary(fun=mean, geom="point", size=2, color="red")

#retirando a legenda
ggplot(data = iris, mapping =  aes(x = Species, y = Sepal.Length, 
                                   fill = Species)) +
  geom_boxplot(show.legend = F) +
  stat_summary(fun=mean, geom="point", size=2, color="red", show.legend = F)

#ordenando por mediana utilizando a função reoder
ggplot(data = iris, mapping =  aes(x = reorder(Species, Sepal.Length, 
                                               FUN = median),
                                   y = Sepal.Length, fill = Species)) +
  geom_boxplot(show.legend = F) +
  stat_summary(fun=mean, geom="point", size=2, color="red", show.legend = F)

#ordenando por mediana em ordem decrescente utilizando a função reoder
ggplot(data = iris, mapping =  aes(x = reorder(Species, -Sepal.Length, 
                                               FUN = median),
                                   y = Sepal.Length, fill = Species)) +
  geom_boxplot(show.legend = F) +
  stat_summary(fun=mean, geom="point", size=2, color="red", show.legend = F)

#ordenando por média utilizando a função reoder
ggplot(data = iris, mapping =  aes(x = reorder(Species, Sepal.Length, 
                                               FUN = mean),
                                   y = Sepal.Length, fill = Species)) +
  geom_boxplot(show.legend = F) +
  stat_summary(fun=mean, geom="point", size=2, color="red", show.legend = F)

#ordenando por média em ordem decrescente utilizando a função reoder
ggplot(data = iris, mapping =  aes(x = reorder(Species, -Sepal.Length, 
                                               FUN = mean),
                                   y = Sepal.Length, fill = Species)) +
  geom_boxplot(show.legend = F) +
  stat_summary(fun=mean, geom="point", size=2, color="red", show.legend = F)

# atribuindo o gráfico ao objeto graf_box
graf_box <- ggplot(data = iris, mapping =  aes(x = Species, y = Sepal.Length, 
                                               fill = Species)) +
  geom_boxplot(show.legend = F) +
  stat_summary(fun=mean, geom="point", size=2, color="red", show.legend = F)

#mostrando o gráfico armazenado no objeto graf_box
graf_box

#customizando
#criando o vetor com os nomes que queremos para cada categoria
lab_name_species <- c("setosa" = "Setosa", "versicolor" = "Versicolor", 
                      "virginica" = "Virginica")

graf_box + xlab("Espécie") +
  ylab("Tamanho da Sépala") +
  ggtitle("Boxplot do Tamanho da Sépala por Espécie")+
  scale_x_discrete(labels = lab_name_species) + 
  theme(plot.title = element_text(hjust = 0.5))

#--------Principais gráficos usando o ggplot2----------------#
#-------------------------------------------------------------#
# Terceiro Gráfico: Histograma
# Histograma tem por objetivo exibir a distribuição da variável
# por meio de retângulos
# Iremos exemplificar com data.frame iris existente no R
#carregando o data.frame iris
data(iris)
#para criar um histograma usaremos geom_histogram
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_histogram()

#diminuindo o número de classes usando o argumento bins
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_histogram(bins = 8)

#adicionando cor
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_histogram(bins = 8, fill = "blue", color = "black")


#customizando o gráfico adicionando linha média e mediana
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_histogram(bins = 8, alpha = 0.5, fill = "blue", color = "black")+
  scale_y_continuous(limits = c(0, 50))+
  geom_vline(mapping = aes(xintercept = mean(Sepal.Length)), color = "red")+
  geom_vline(mapping = aes(xintercept = median(Sepal.Length)), color = "green")+
  xlab("Tamanho da Sépala")+ylab("Frequência")+
  ggtitle("Histograma da variável Tamanho da Sépala")+ 
  theme(plot.title = element_text(hjust = 0.5))

#frequência relativa 
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_histogram(mapping = aes(y = stat(count) / sum(count)), 
                 bins = 8, alpha = 0.5, fill = "blue", color = "black")

#customizando o gráfico da frequência relativa
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_histogram(mapping = aes(y = stat(count) / sum(count)), 
                 bins = 8, alpha = 0.5, fill = "blue", color = "black")+
  scale_y_continuous(labels = scales::percent, limits = c(0, 0.3))+
  xlab("Tamanho da Sépala")+ylab("Frequência relativa")+
  ggtitle("Histograma da variável Tamanho da Sépala")+ 
  theme(plot.title = element_text(hjust = 0.5))


#Por espécie
ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(bins = 8, alpha = 0.5, color = "black")


#dividindo em facetas
ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(bins = 8, alpha = 0.5, color = "black")+
  facet_grid(Species ~ .)

##dividindo em facetas e deixando o eixo y livre
ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(bins = 8, alpha = 0.5, color = "black")+
  facet_grid(Species ~ ., scales = "free_y")

# dividindo em facetas o gráfico de frequência relativa

ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(mapping = aes(y = stat(count) / sum(count)), 
                 bins = 8, alpha = 0.5, color = "black")+
  scale_y_continuous(labels = scales::percent)+
  facet_grid(Species ~ .)



#customizando o último gráfico
#criando o vetor com os nomes que queremos para cada categoria
lab_name_species <- c("setosa" = "Setosa", "versicolor" = "Versicolor", 
                      "virginica" = "Virginica")

ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(mapping = aes(y = stat(count) / sum(count)), 
                 bins = 8, alpha = 0.5, color = "black")+
  scale_y_continuous(labels = scales::percent)+
  facet_grid(Species ~ ., labeller = labeller(Species = lab_name_species)) + 
  xlab("Tamanho da Sépala") +
  ylab("Frequência relativa") +
  ggtitle("Histograma do Tamanho da Sépala por Espécie")+
  scale_fill_discrete(name = "Espécie",
                      labels = lab_name_species) + 
  theme(plot.title = element_text(hjust = 0.5))

#-------------------------------------------------------------#
# Quarto Gráfico: Densidade
# Densidade tem por objetivo exibir a distribuição da variável,
# porém mostrando uma curva suavizada
# Iremos exemplificar com data.frame iris existente no R
#carregando o data.frame iris
data(iris)
#para criar uma densidade usaremos geom_density
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_density()

#customizando
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_density(alpha = 0.5, fill = "blue", color = "black")+
  xlab("Tamanho da Sépala")+ylab("Densidade")+
  ggtitle("Densidade da variável Tamanho da Sépala")+ 
  theme(plot.title = element_text(hjust = 0.5))


#Por espécie
ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_density()

#adicionando cor
ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.5, color = "black")

#dividindo em facetas
ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.5, color = "black")+
  facet_grid(Species ~ .)

#ajustando a densidade a um histograma
ggplot(data = iris, mapping =  aes(x = Sepal.Length)) +
  geom_histogram(mapping = aes(y=..density..), 
                 bins = 8, alpha = 0.5, fill = "blue", color = "black")+
  geom_density(alpha = 0.2, color = "black", fill = "blue")

#ajustando a densidade a um histograma para cada espécie
ggplot(data = iris, mapping =  aes(x = Sepal.Length, fill = Species)) +
  geom_histogram(mapping = aes(y=..density..), 
                 bins = 8, alpha = 0.5, color = "black")+
  geom_density(alpha = 0.2, color = "black")+
  facet_grid(Species ~ .)


#--------Principais gráficos usando o ggplot2----------------#
#-------------------------------------------------------------#
# Quinto Gráfico: Colunas e Barras
# Geralmente utilizado para a representação de variáveis qualitativas
# Iremos exemplificar com o arquivo Banco_de_dados.csv utilizado na Unidade 3

dados <- read_csv2('Banco_de_dados.csv', 
                   locale = locale(encoding = "latin1"))

#geom_bar faz a contagem para o eixo y
ggplot(data = dados, mapping = aes(x = Genero))+
  geom_bar()

#adicionando cor
ggplot(data = dados, mapping = aes(x = Genero))+
  geom_bar(fill = "blue", color = "black")

#customizando
ggplot(data = dados, mapping = aes(x = Genero))+
  geom_bar(fill = "blue", color = "black")+
  scale_x_discrete(name = "Gênero",
                   labels = c("F"="Feminino", "M"="Masculino"))+
  geom_text(stat = "count", mapping = aes(label = stat(count)), vjust = -1)+
  scale_y_continuous(name = "Frequência", limits = c(0, 20))

#usando o geom_col
#no geom_col precisa definir o eixo y

#iremos obter a frequência por gênero utilizando a função table
freq_genero <- as.data.frame(table(dados$Genero))

#usando a geom_col informando quem será x e y
ggplot(data = freq_genero, mapping = aes(x = Var1, y = Freq))+
  geom_col()

#customizando
ggplot(data = freq_genero, mapping = aes(x = Var1, y = Freq))+
  geom_col(fill = "blue", color = "black")+
  scale_x_discrete(name = "Gênero",
                   labels = c("F"="Feminino", "M"="Masculino"))+
  geom_text(mapping = aes(label = Freq), vjust = -1)+
  scale_y_continuous(name = "Frequência", limits = c(0, 20))

#fazendo por proporção
prop_genero <- as.data.frame(prop.table(table(dados$Genero)))

#customizando
ggplot(data = prop_genero, mapping = aes(x = Var1, y = Freq))+
  geom_col(fill = "blue", color = "black")+
  scale_x_discrete(name = "Gênero",
                   labels = c("F"="Feminino", "M"="Masculino"))+
  geom_text(mapping = aes(label = scales::percent(Freq)), vjust = -1)+
  scale_y_continuous(name = "Percentual", limits = c(0, 0.6),
                     labels = scales::percent)

#usando a variável grau de instrução
freq_esc <- as.data.frame(table(dados$Grau_de_Instruçao))

ggplot(data = freq_esc, 
       mapping = aes(x = factor(Var1, 
                                levels = c("Ens Fundamental", 
                                           "Ensino Médio", "Superior"),
                                labels = c("Ensino Fundamental", 
                                           "Ensino Médio", "Ensino Superior"),
                                ordered = T), y = Freq))+
  geom_col(fill = "blue", color = "black")+
  geom_text(mapping = aes(label = Freq), vjust = -1)+
  scale_y_continuous(name = "Frequência", limits = c(0, 20))+
  xlab("Grau de Instrução") 

#rotacionar o gráfico usando coord_flip
ggplot(data = freq_esc, 
       mapping = aes(x = factor(Var1, 
                                levels = c("Ens Fundamental", 
                                           "Ensino Médio", "Superior"),
                                labels = c("Ensino Fundamental", 
                                           "Ensino Médio", "Ensino Superior"),
                                ordered = T), y = Freq))+
  geom_col(fill = "blue", color = "black")+
  geom_text(mapping = aes(label = Freq), hjust = -1)+
  scale_y_continuous(name = "Frequência", limits = c(0, 20))+
  xlab("Grau de Instrução") + coord_flip()


#gráfico de colunas múltiplas
genero_esc <- as.data.frame(table(dados$Genero, dados$Grau_de_Instruçao))

ggplot(data = genero_esc, 
       mapping = aes(x = factor(Var2, 
                                levels = c("Ens Fundamental", 
                                           "Ensino Médio", "Superior"),
                                labels = c("Ensino Fundamental", 
                                           "Ensino Médio", "Ensino Superior"),
                                ordered = T), y = Freq, fill = Var1))+
  geom_col(color = "black")

#customizando
ggplot(data = genero_esc, 
       mapping = aes(x = factor(Var2, 
                                levels = c("Ens Fundamental", 
                                           "Ensino Médio", "Superior"),
                                labels = c("Ensino Fundamental", 
                                           "Ensino Médio", "Ensino Superior"),
                                ordered = T), y = Freq, fill = Var1))+
  geom_col(color = "black", position = "dodge")+
  geom_text(mapping = aes(label=Freq), position=position_dodge(width=0.9), 
            vjust=-0.25)
#gráfico de colunas múltiplas usando proporção
genero_esc_prop <- as.data.frame(prop.table(table(dados$Genero, 
                                                  dados$Grau_de_Instruçao)))
ggplot(data = genero_esc_prop, 
       mapping = aes(x = factor(Var2, 
                                levels = c("Ens Fundamental", 
                                           "Ensino Médio", "Superior"),
                                labels = c("Ensino Fundamental", 
                                           "Ensino Médio", "Ensino Superior"),
                                ordered = T), y = Freq, fill = Var1))+
  geom_col(color = "black", position = "dodge")+
  geom_text(mapping = aes(label=scales::percent(Freq)), 
            position=position_dodge(width=0.9), vjust=-0.25)+
  scale_y_continuous(name = "Percentual", limits = c(0, 0.3),
                     labels = scales::percent)

#percentual de gênero por grau de instrução
genero_esc_prop_2 <- as.data.frame(prop.table(table(dados$Genero, 
                                                    dados$Grau_de_Instruçao),
                                              margin = 2))

ggplot(data = genero_esc_prop_2, 
       mapping = aes(x = factor(Var2, 
                                levels = c("Ens Fundamental", 
                                           "Ensino Médio", "Superior"),
                                labels = c("Ensino Fundamental", 
                                           "Ensino Médio", "Ensino Superior"),
                                ordered = T), y = Freq, fill = Var1))+
  geom_col(color = "black", position = "dodge")+
  geom_text(mapping = aes(label=scales::percent(Freq)), 
            position=position_dodge(width=0.9), vjust=-0.25)+
  scale_y_continuous(name = "Percentual", limits = c(0, 1),
                     labels = scales::percent)+
  xlab("Grau de Instrução")+
  scale_fill_discrete(name = "Gênero",
                      labels = c("F"="Feminino", "M"="Masculino"))


#calculando média salarial por Grau de Instrução
#usando dplyr
media_salarial_esc <- dados %>% group_by(Grau_de_Instruçao) %>% 
  summarise(media_salarial = mean(Salario, na.rm = T))

ggplot(data = media_salarial_esc, 
       mapping = aes(x = factor(Grau_de_Instruçao, 
                                levels = c("Ens Fundamental", 
                                           "Ensino Médio", "Superior"),
                                labels = c("Ensino Fundamental", 
                                           "Ensino Médio", "Ensino Superior"),
                                ordered = T), y = media_salarial))+
  geom_col(fill = "blue", color = "black")+
  geom_text(mapping = aes(label = round(media_salarial,2)), vjust = -1)+
  scale_y_continuous(name = "Média Salarial", limits = c(0,4))+
  xlab("Grau de Instrução")

#------------------------------------------------#
# Sexto Gráfico: gráfico de linhas
# Geralmente utilizados para descrever dados cronológicos
#criando um data.frame
Ano <- 2001:2010
Vendas <- c(1000, 1220, 1020, 3000, 2000, 1300, 700, 800, 900, 500)
Vendas_ano <- data.frame(Ano, Vendas)

#para constuir um gráfico de linha usa-se a geom_line
ggplot(data = Vendas_ano, mapping = aes(x = Ano, y = Vendas))+
  geom_line()

# para ajutar o eixo x basta colocar scale_x_continuous(breaks = Ano)
ggplot(data = Vendas_ano, mapping = aes(x = Ano, y = Vendas))+
  geom_line()+
  scale_x_continuous(breaks = Ano)

# colocando para mostrar de dois em dois anos
ggplot(data = Vendas_ano, mapping = aes(x = Ano, y = Vendas))+
  geom_line()+
  scale_x_continuous(breaks = seq(2001, 2010, 2))

# outra maneira
# criando uma coluna do tipo data
# ano-mes-dia
# 2001-01-01 significa 01 de janeiro de 2001
# 2001-03-02 significa 02 de março de 2001
# as.Date faz transformar "2001-01-01" em um objeto tipo date
Vendas_ano_2 <- Vendas_ano %>% 
  mutate(Ano_data = seq(from = as.Date("2001-01-01"), 
                        to = as.Date("2010-01-01"), by = "years"))

#vendo a estrutura
str(Vendas_ano_2)

#criando o gráfico
ggplot(data = Vendas_ano_2, mapping = aes(x = Ano_data, y = Vendas))+
  geom_line()



#para configurar o eixo x usamos scale_x_date
# pois o que vai ser mapeado para o eixo x é do tipo date (data)
ggplot(data = Vendas_ano_2, mapping = aes(x = Ano_data, y = Vendas))+
  geom_line()+
  scale_x_date(breaks = "1 year", date_labels = "%Y")
#para breaks temos: year(s) para ano(s), month(s) para mes(es), 
#day(s) para dia(s)


#Outras formas de visualização
#install.packages("GGally")
library(GGally)
#------------------------------------------------------------#
## O pacote GGally é uma extensão do ggplot2

#utilizando o data.frame iris
data(iris)

#utilizando a função ggpairs do pacote GGally para visualizar todo o data.frame
ggpairs(iris)
#com o argumento columns posso selecionar as colunas que quero visualizar
ggpairs(iris, columns = 1:4)

# posso mapear também os atributos estéticos
ggpairs(iris, columns = 1:4, mapping = aes(color=Species))

# utilizando o arquivo Banco_de_dados.csv da Unidade 3
dados <- read.csv2('Banco_de_dados.csv')

#Vendo as variáveis Idade e salário por Genero
ggpairs(dados, columns = c(5,7), mapping = aes(color=Genero))

#Vendo as variáveis Idade e salário por Grau de Instrução
ggpairs(dados, columns = c(5,7), mapping = aes(color=Grau_de_Instruçao))

#melhorando a visualização
ggpairs(dados, columns = c(5,7), mapping = aes(color=Grau_de_Instruçao, 
                                               alpha = 0.5))