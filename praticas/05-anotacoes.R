# esquisse
library(ggplot2)

# Addins -> ggplot2 builder
# gráfico gerado com esquisse
# lembrem de copiar o código
ggplot(dados::diamante) +
  aes(x = quilate, y = preco, colour = corte) +
  geom_point(shape = "diamond", size = 2.05) +
  scale_color_brewer(palette = "Set2", direction = 1) +
  labs(color = "Corte") +
  ggthemes::theme_fivethirtyeight() +
  theme(legend.position = "top")


# Anotações -------------

library(dados)
library(ggplot2)
library(dplyr)

jabba <- dados_starwars |> 
  filter(massa > 1000)

dados_starwars |> 
  ggplot() + 
  aes(x = massa, y = altura) +
  geom_point() +
  annotate("label",
           x = jabba$massa,
           y = jabba$altura,
           label = jabba$nome, 
           hjust = 0.8, vjust = -0.5)


dados_starwars |> 
  ggplot() + 
  aes(x = massa, y = altura) +
  geom_point() +
  annotate("text", # alteramos para text
           x = jabba$massa,
           y = jabba$altura,
           label = jabba$nome, 
           hjust = 0.8, vjust = -0.5)



# geom_label
dados_starwars |> 
  ggplot() + 
  aes(x = massa, y = altura) +
  geom_point() +
  geom_label(aes(x = massa, 
                 y = altura,
                 label = nome),
             data = jabba, 
             nudge_x = -80, nudge_y = 10)

dados_starwars |> 
  ggplot() + 
  aes(x = massa, y = altura) +
  geom_point() +
  geom_text(aes(x = massa, 
                 y = altura,
                 label = nome),
             data = jabba, 
             nudge_x = -80, nudge_y = 10)



# Setas!!! 
grafico_jabba <- dados_starwars |>
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point() +
  geom_label(
    aes(x = massa,
        y = altura,
        label = nome),
    data = jabba,
    nudge_x = -250,
    nudge_y = 15
  ) +
  geom_point(aes(x = massa, y = altura),
             color = "red",  data = jabba) +
  geom_curve(
    aes(
      x = massa + 2,
      y = altura + 2,
      xend = massa - 100,
      yend = altura + 15
    ),
    arrow = arrow(
      type = "closed",
      ends = "first",
      length = unit(0.3, "cm")
    ),
    colour = "red",
    data = jabba
  )


# adicionar uma imagem!!

imagem_jabba <- "https://www.pikpng.com/pngl/b/277-2778885_jabba-the-hut-6-star-wars-black-series.png"

img <- httr::GET(imagem_jabba) |> 
  httr::content()


grafico_jabba + 
  annotation_raster(
    raster = img,
    xmin = jabba$massa - 600,
    ymin = jabba$altura - 100,
    xmax = jabba$massa - 5,
    ymax = jabba$altura -2, 
    
  )


# gghighlight

# install.packages("gghighlight")
library(gghighlight)

dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura) + 
  geom_point() +
  gghighlight(massa > 1000, label_key = nome)


dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura) + 
  geom_point() +
  gghighlight(altura > 225, label_key = nome)



dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura) + 
  geom_point()  + 
  geom_label(aes(label = nome))


# repelir os textos, evitar que fique sobrepondo
# install.packages("ggrepel")
library(ggrepel)


dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura) + 
  geom_point() +
  geom_label_repel(aes(label = nome))


pixar_bilheteria |> 
  ggplot() +
  aes(x = orcamento, y = bilheteria_mundial) +
  geom_point() +
  geom_label_repel(aes(label = filme))

pixar_bilheteria |> 
  ggplot() +
  aes(x = orcamento, y = bilheteria_mundial) +
  geom_point() +
  geom_label(aes(label = filme))


# circular pontos!!
# install.packages("ggalt")
library(ggalt)

filmes_baixa_bilheteria <- filter(pixar_bilheteria, 
                                 bilheteria_mundial < 500000000)

pixar_bilheteria |> 
  ggplot() +
  aes(x = orcamento, y = bilheteria_mundial) +
  geom_point() +
  geom_encircle(data = filmes_baixa_bilheteria,
                color = "blue",
                s_shape = 0.8, # formato
                expand = 0.02, # expande, 
                spread = 0.05 # largura
                )


# 


