
library(tidyverse)
library(dados)

p1 <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = sexo_biologico) +
  geom_point(size = 3) +
  theme_minimal()

p2 <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = log10(ano_nascimento)) +
  geom_point(size = 3) +
  theme_minimal()

p1
p2

## discretas

p1 +
  scale_colour_brewer(palette = "Dark2",
                      na.value = "#222222")

p1 +
  scale_colour_viridis_d(
    option = "D",
    begin = .2,
    end = .8,
    na.value = "#222222"
  )

p1 +
  scale_colour_manual(
    values = c(
      ghibli::ghibli_palette("SpiritedMedium")[c(1,5,6)]
    ),
    na.value = "#222222"
  )

## contínuas

### divergentes
p2 +
  scale_colour_distiller(
    palette = "Spectral",
    na.value = "#FFFFFF"
  )

### sequenciais
p2 +
  scale_colour_distiller(
    palette = "BuPu",
    direction = 1,
    na.value = "#FFFFFF"
  )

p2 +
  scale_colour_fermenter(
    palette = "BuPu",
    direction = 1,
    na.value = "#FFFFFF"
  )


p2 +
  scale_colour_viridis_c(
    option = "C",
    begin = .2, end = .8,
    na.value = "#FFFFFF"
  )


p2 +
  scale_colour_viridis_b(
    option = "C",
    begin = .2, end = .8,
    na.value = "#FFFFFF"
  )


p2 +
  scale_color_gradient(
    low = "#FFFFFF",
    high = "#000000",
  )


# pacote ggthemes ---------------------------------------------------------

library(ggthemes)

p1 +
  scale_color_excel() +
  theme_excel()

p1 +
  scale_colour_fivethirtyeight() +
  theme_fivethirtyeight()

p1 +
  theme_grey() +
  facet_wrap(vars(sexo_biologico)) +
  # scale_colour_hc() +
  theme_hc()


# pacote tvthemes ---------------------------------------------------------

library(tvthemes)

extrafont::font_import(
  "praticas/some_time_later/",
  prompt = FALSE
)
extrafont::loadfonts("win")

p1 +
  scale_colour_spongeBob() +
  theme_spongeBob(
    text.font = "Some Time Later",
    title.size = 40
  ) +
  labs(title = "Duas horas depois...")

ggsave("bobsponja.png")

knitr::imgur_upload("bobsponja.png")


ggplot() +
  aes(x = 1, y = 1) +
  geom_text(
    aes(label = "Duas horas depois..."),
    family = "Some Time Later",
    size = 20,
    colour = "red"
  ) +
  theme_void()


ggsave("arquivo.png",
       grafico_gg,

       bg = "white")

# exercício ---------------------------------------------------------------

# Montar um gráfico com base no exemplo explorando
# o ggthemes, scales ou o tvthemes.

