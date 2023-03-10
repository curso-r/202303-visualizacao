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


# Nota média de Tom Hanks por ano

nota_media_tom <- imdb |> 
  filter(str_detect(elenco, "Tom Hanks")) |> 
  group_by(ano) |> 
  summarise(nota_media = round(mean(nota_imdb, na.rm = TRUE), 1))

nota_media_tom |> 
  ggplot() +
  aes(x = ano, y = nota_media) +
  geom_line() +
  geom_point() +
  geom_label(aes(label = nota_media))


round(mean(imdb$nota_imdb), digits =  1)
round(mean(imdb$nota_imdb), digits =  2)



# slices

imdb |> 
  slice_max(order_by = nota_imdb, n = 5)


imdb |> 
  slice_min(order_by = nota_imdb, n = 5)


imdb |> 
  slice_sample(n = 5)

# Gráfico de Barras (geom_col())

# 10 diretores/as com mais filmes!
# quantidade de filmes
# nome

dez_diretores <- imdb |> 
  separate_longer_delim(direcao, delim = ", ") |> 
  count(direcao, name = "quantidade") |> 
  slice_max(order_by = quantidade, n = 10) |> 
  mutate(direcao = fct_reorder(direcao, quantidade),
         destaque = if_else(
           direcao == "Lesley Selander", 
           "Diretor destaque",
           "Sem destaque"
         ))


dez_diretores |> 
  ggplot() +
  aes(y = direcao, x = quantidade) +
  geom_col(aes(fill = destaque), show.legend = FALSE) +
  geom_label(aes(label = quantidade, x = quantidade/2))

# Histograma geom_histogram()


imdb |> 
  filter(str_detect(direcao, "Steven Spielberg")) |> 
  ggplot() +
  aes(x = lucro) +
  geom_histogram(binwidth = 100000000) # 100 milhoes

imdb |> 
  ggplot(aes(x = nota_imdb)) +
  geom_histogram(binwidth = 1)

imdb |> 
  ggplot(aes(x = nota_imdb)) +
  geom_histogram(bins = 10)

imdb |> 
  ggplot(aes(x = nota_imdb)) +
  geom_density()


# Boxplot geom_boxplot()
# lucro dos filmes
# dirigiram pelo menos 15 filmes

imdb |> 
  drop_na(lucro, direcao) |> 
  separate_longer_delim(direcao, ", ") |> 
  group_by(direcao) |> 
  mutate(quantidade = n()) |>
  ungroup() |> 
  filter(quantidade >= 15) |> 
  mutate(direcao = fct_reorder(direcao, lucro, .fun = median)) |> 
  ggplot() + 
  geom_boxplot(aes(y = direcao, x = lucro))
  

# Dúvida do Jõao - Curva normal

filmes_steven <- imdb |>
  drop_na(lucro) |>
  filter(str_detect(direcao, "Steven Spielberg"))

filmes_steven |>
  ggplot() +
  geom_histogram(aes(x = lucro, y = after_stat(density))) +
  geom_density(aes(lucro)) +
  stat_function(fun = dnorm,
                args = list(
                  mean = mean(filmes_steven$lucro),
                  sd = sd(filmes_steven$lucro)
                ),
                color = "red")


# ----------------------------------------------------

# Labels
imdb |> 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucro)) +
  labs(
    x = "Orçamento ($)",
    y = "Receita ($)",
    color = "Lucro ($)",
  #  fill = "nome da coluna"
    title = "Gráfico de dispersão",
    subtitle = "Receita vs Orçamento",
    caption = "Fonte: imdb.com"
  )

# ESCALAS

seq(1, 10, 2)
seq(1880, 2020, 10)

imdb |> 
  group_by(ano) |> 
  summarise(nota_media = mean(nota_imdb)) |> 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) + 
  scale_x_continuous(breaks = seq(1880, 2020, 20), limits = c(1920, 2020)) +
  scale_y_continuous(breaks = seq(0, 10, 1), limits = c(0, 10))
  

# cores!!

dez_diretores |> 
  head() |> 
  ggplot() +
  aes(y = direcao, x = quantidade) +
  geom_col(aes(fill = direcao), show.legend = FALSE) +
  geom_label(aes(label = quantidade, x = quantidade/2)) +
  scale_fill_brewer(type = "qual", palette =  "Set3")


dez_diretores |> 
  head() |> 
  ggplot() +
  aes(y = direcao, x = quantidade) +
  geom_col(aes(fill = direcao), show.legend = FALSE) +
  geom_label(aes(label = quantidade, x = quantidade/2)) +
  scale_fill_viridis_d(option = "D")



dez_diretores |> 
  head() |> 
  ggplot() +
  aes(y = direcao, x = quantidade) +
  geom_col(aes(fill = direcao), show.legend = FALSE) +
  geom_label(aes(label = quantidade, x = quantidade/2)) +
  scale_fill_manual(values = c("red", "blue", "pink",
                               "orange", "salmon", "royalblue"))

paleta_sorteada <- colors() |> sample(6)


dez_diretores |> 
  head() |> 
  ggplot() +
  aes(y = direcao, x = quantidade) +
  geom_col(aes(fill = direcao), show.legend = FALSE) +
  geom_label(aes(label = quantidade, x = quantidade/2)) +
  scale_fill_manual(values = paleta_sorteada)


dez_diretores |> 
  head() |> 
  ggplot() +
  aes(y = direcao, x = quantidade) +
  geom_col(aes(fill = direcao), show.legend = FALSE) +
  geom_label(aes(label = quantidade, x = quantidade/2)) +
  scale_fill_manual(values = c("#9022AB", "#F7CC63", "#D54AF7",
                               "#31F7B0", "#2BAB7D", "#459AAD"))


# Temas


imdb |> 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) + 
  # theme_bw()
  # theme_light() 
  # theme_void() 
   theme_minimal() 
  
  