
library(gganimate)

# Hans Rosling

dados_gapminder

dplyr::glimpse(dados_gapminder)

dados_gapminder |>
  ggplot() +
  aes(
    expectativa_de_vida,
    log10(pib_per_capita),
    size = log10(populacao),
    colour = continente
  ) +
  facet_wrap(vars(ano)) +
  geom_point()

anim <- dados_gapminder |>
  ggplot() +
  aes(
    expectativa_de_vida,
    log10(pib_per_capita),
    size = log10(populacao),
    colour = continente
  ) +
  geom_point() +
  transition_time(ano) +
  labs(
    title = "Ano: {frame_time}",
    x = "Expectativa de vida",
    y = "log10(pib per capita)"
  )

animate(
  anim,
  nframes = 40,
  width = 800,
  height = 400,
  start_pause = 10,
  end_pause = 10
)

# gif -> gifsky
# mp4 -> av

animate(
  anim,
  nframes = 40,
  width = 800,
  height = 400,
  start_pause = 10,
  end_pause = 10,
  renderer = gifski_renderer("praticas/gif_ggplot2.gif")
)

animate(
  anim,
  nframes = 40,
  width = 800,
  height = 400,
  start_pause = 10,
  end_pause = 10,
  renderer = av_renderer("praticas/mp4_ggplot2.mp4")
)
