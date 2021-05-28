#' ---
#' title: "Price elasticity starter"
#' author: "Pavel Paramonov"
#' date: "Retail Analytics (2021)"
#' ---
library(tidyverse)
library(ggplot2)

# load task dataset and product cost information
price_sales <- read_csv("https://raw.githubusercontent.com/multidis/hult-retail-analytics/main/price_elasticity/price_sales_weekly.csv")
cost <- read_csv("https://raw.githubusercontent.com/multidis/hult-retail-analytics/main/price_elasticity/product_cost.csv")
price_sales
cost

# example selected product
prod <- 1 # "P1"

# linear regression for sales vs. price
# (note the formula interface specific to R)
fit <- lm(as.formula(paste(paste0("Q_P", prod), "~", paste0("price_P", prod))),
          data = price_sales)
fit
C1 <- fit$coefficients[1]
C2 <- -fit$coefficients[2]

# visualize the linear fit
ggplot(price_sales, aes(x=price_P1, y=Q_P1)) + geom_point() +
    geom_smooth(method='lm', formula = y ~ x)

# average price and sales
Pav <- price_sales %>% summarize(Pav = mean(get(paste0("price_P", prod))))
Pav
Qav <- price_sales %>% summarize(Qav = mean(get(paste0("Q_P", prod))))
Qav

# estimate price elasticity
Elast <- -C2 * Pav / Qav
Elast

# find optimal price
Popt <- (C1 + C2*cost[prod, "cost"]) / (2*C2)
Popt
