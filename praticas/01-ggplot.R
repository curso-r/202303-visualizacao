# Carregar pacotes
library(tidyverse)

# Ler a base IMDB
imdb <- read_rds("dados/imdb.rds")

imdb <- imdb |>
  mutate(lucro = receita - orcamento)

# Gráficos!

# apenas o canva!
imdb |> 
  ggplot()

imdb |> 
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point()

# AVISO DE QUE REMOVEU LINHAS COM NA!
# Warning message:
# Removed 23758 rows containing missing values
# (`geom_point()`).

# Inserir uma linha horizontal
imdb |> 
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_point() +
  geom_hline(yintercept = 1000000000,
             color = "red",
             linetype = 2)

# alterando a ordem!
imdb |> 
  ggplot() +
  aes(x = orcamento, y = receita) +
  geom_hline(yintercept = 1000000000,
             color = "red",
             linetype = 2) +
  geom_point()



# Pergunta do Nathan: podemos colocar o aes()
# dentro do ggplot
imdb |> 
  ggplot() +
  aes(x = orcamento, y = receita) + 
  geom_point()

imdb |> 
  ggplot(aes(x = orcamento, y = receita)) +
  geom_point() 


imdb |> 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita))

# voltando aos gráficos de pontos

imdb |> 
  ggplot() +
  aes(x = orcamento, y = receita, color = lucro) + 
  geom_point(size = 0.5)

imdb |> 
  ggplot() +
  aes(x = orcamento, y = receita, color = lucro) + 
  geom_point(aes(size = lucro))

grafico_lucro <- imdb |> 
  mutate(lucrou = lucro > 0) |> 
  ggplot() +
  aes(x = orcamento, y = receita, color = lucrou) +
  geom_point(alpha = 0.5)

grafico_lucro

ggsave(filename = "output/grafico-1-ggplot.png",
       plot =  grafico_lucro,  # grafico para salvar
       dpi = 900, # resolucao
       width = 10, # largura
       height = 5 # altura
        )

# Gráfico de linhas ----

# geom_line()

# Nota média dos filmes por ano
# tempo - eixo X
# eixo y = nota média dos filmes de cada ano!


imdb |> 
  group_by(ano) |> 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) |> 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))

# quantos filmes por ano?
imdb |> 
  group_by(ano) |> 
  summarise(n_filmes = n())

# quantos filmes por ano
imdb |> 
  count(ano) |> 
  filter(ano < 2020) |> 
  ggplot() +
  geom_line(aes(x = ano, y = n))


# duvida João - curvas suavizadas!
imdb |> 
  group_by(ano) |> 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) |> 
  ggplot() +
  geom_smooth(aes(x = ano, y = nota_media), 
              span = 0.1, se = FALSE)











