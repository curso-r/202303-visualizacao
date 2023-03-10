# bases de dados em inglês
mtcars

iris

library(tidyverse)
diamonds # dplyr

starwars # dplyr

# bases traduzidas
# install.packages("dados")
library(dados)

dados_starwars |> View()

# --------

dados_starwars |> 
  ggplot() +
  geom_point(aes(x = massa, y = altura)) 


# gráfico de barras
# sexo e genero

dados_starwars |> 
  count(sexo_biologico, genero) |> 
  ggplot() +
  geom_col(aes(x = sexo_biologico, y = n, fill = genero))
  

