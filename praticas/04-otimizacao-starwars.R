
library(tidyverse)
library(dados)

imagem <- "https://wallpaperaccess.com/full/11836.jpg"

vader <- dados_starwars |>
  filter(nome == "Darth Vader") |>
  mutate(nome = tolower(nome))

grafico <- dados_starwars |>
  ggplot() +
  geom_point(
    aes(massa, altura),
    colour = "yellow",
    fill = "yellow",
    alpha = .8,
    shape = 23
  ) +
  geom_point(
    aes(massa, altura),
    colour = "red",
    data = vader
  ) +
  geom_label(
    aes(massa, altura, label = nome),
    fill = "red",
    data = vader,
    nudge_y = 12,
    nudge_x = -5,
    family = "Star Jedi",
    size = 3
  ) +
  # scale_x_continuous(limits = c(0, 200)) +
  coord_cartesian(xlim = c(0, 200)) +
  labs(
    title = "Star Wars",
    subtitle = "May the force be with you",
    x = "Massa",
    y = "Altura"
  ) +
  theme(
    panel.background = element_rect(fill = "black"),
    plot.background = element_rect(fill = "black"),
    axis.text = element_text(
      color = "yellow",
      family = "Star Jedi"
    ),
    axis.title = element_text(
      color = "yellow",
      family = "Star Jedi"
    ),
    plot.title = element_text(
      color = "yellow",
      family = "Star Jedi",
      hjust = .5,
      size = 25
    ),
    plot.subtitle = element_text(
      color = "yellow",
      family = "Star Jedi",
      hjust = .5
    ),
    panel.grid = element_blank()
  )

ggimage::ggbackground(
  grafico,
  background = imagem
)
