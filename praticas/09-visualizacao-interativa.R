library(tidyverse)
library(dados)
library(plotly)
library(highcharter)
library(echarts4r)



starwars_sem_jabba <- dados_starwars |> 
  filter(massa < 1000)

# gráfico de dispersao -------------
# ggplot

grafico_com_ggplot <- starwars_sem_jabba |> 
  ggplot() +
  geom_point(aes(x = massa, y = altura, color = genero)) + 
  theme_light()

grafico_com_ggplot

# plotly

plotly::ggplotly(grafico_com_ggplot)

# plotly sem ggplot


starwars_sem_jabba |>
  plot_ly(
    mode = "markers",
    type = "scatter",
    x = ~ massa,
    y = ~ altura,
    color = ~ genero
  )

# gráfico de barras -----------

starwars_contagem <- dados_starwars |> 
  count(sexo_biologico) |> 
  tidyr::drop_na() |> 
  mutate(sexo_biologico = forcats::fct_reorder(sexo_biologico, n))

# ggplot
grafico_contagem_ggplot <- starwars_contagem |> 
  ggplot() +
  geom_col(aes(y = sexo_biologico, x = n)) +
  theme_light()

grafico_contagem_ggplot

# plotly

ggplotly(grafico_contagem_ggplot)


# plotly - sem ggplot

starwars_contagem |> 
  plot_ly(x = ~ n, y = ~ sexo_biologico, type = "bar")


# highcharter --------

## gráfico de dispersão  --

starwars_sem_jabba |> 
  hchart(type = "scatter", mapping = hcaes(x = massa,
                                           y = altura,
                                           group = genero))


## gráfico de barras

# cuidado com o X e Y
# bar = sempre horizontal
# col = sempre vertical
starwars_contagem |>
  arrange(desc(n)) |> 
  hchart(type = "bar", mapping = hcaes(y = n,
                                       x = sexo_biologico))

starwars_contagem |>
  arrange(desc(n)) |> 
  hchart(type = "column", mapping = hcaes(y = n,
                                       x = sexo_biologico))


# echarts4r

# dispersao

starwars_sem_jabba |> 
  group_by(genero) |> 
  e_charts(x = massa) |> 
  e_scatter(serie = altura, symbol_size = 15)


# gráfico de colunas

starwars_contagem |> 
  arrange(n) |> 
  e_charts(sexo_biologico) |> 
  e_bar(n) |> 
  e_flip_coords()













