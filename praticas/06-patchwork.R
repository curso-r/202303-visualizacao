library(ggplot2)
library(dados)

p1 <- pixar_filmes |>
  ggplot() +
  geom_line(aes(data_lancamento, duracao))

p2 <- pixar_filmes |>
  ggplot() +
  geom_bar(aes(x = classificacao_indicativa))

p3 <- pixar_bilheteria |>
  dplyr::mutate(
    orcamento_alto_baixo = orcamento > 175e6
  ) |>
  ggplot() +
  aes(bilheteria_eua_canada, bilheteria_mundial,
      colour = orcamento_alto_baixo) +
  geom_point()

p4 <- pixar_bilheteria |>
  dplyr::mutate(
    orcamento_alto_baixo = orcamento > 175e6
  ) |>
  ggplot() +
  aes(x = bilheteria_mundial, fill = orcamento_alto_baixo) +
  geom_histogram()

library(patchwork)
p1 + p2

p1 + p2 + p3

p1 + p2 + p3 + p4

patchwork::wrap_plots(p1, p2)

## customizar o padrão de linhas e colunas

p1 + p2 + plot_layout(ncol = 1)

## usar operações matemáticas para organizar

p1 / p2

(p1 + p2) / p3

## avançado

(p1 + p3 + plot_spacer()) / (p2 + p4)


p3 + p4 +
  plot_layout(guides = "collect")
