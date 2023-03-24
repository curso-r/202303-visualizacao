
library(ggridges)

diamante |>
  ggplot() +
  aes(x = preco) +
  geom_density() +
  facet_wrap(vars(corte))

diamante |>
  ggplot() +
  aes(x = preco, colour = corte) +
  geom_density()

diamante |>
  dplyr::filter(preco < 0)

diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    show.legend = FALSE,
    quantile_lines = TRUE,
    quantiles = 2
  )

## limitando com scale_x_continuous()

diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    show.legend = FALSE,
    quantile_lines = TRUE,
    quantiles = 2
  ) +
  scale_x_continuous(limits = c(0 ,10000))

diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    show.legend = FALSE,
    quantile_lines = TRUE,
    quantiles = 2
  ) +
  lims(x = c(0 ,10000))

diamante |>
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  geom_density_ridges(
    show.legend = FALSE,
    quantile_lines = TRUE,
    quantiles = 2
  ) +
  lims(x = c(0, NA)) +
  coord_cartesian(xlim = c(0, 10000))
