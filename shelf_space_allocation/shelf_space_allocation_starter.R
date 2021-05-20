#' ---
#' title: "Shelf space allocation starter"
#' author: "Pavel Paramonov"
#' date: "Retail Analytics (2021)"
#' ---
library(tidyverse)
library(DT)

# product list
p0 <- read_csv("products_set_30.csv")
p0

# derived metrics
p <- p0 %>% mutate(monthly_profit = unit_margin * monthly_demand, .before = "category_id") %>%
  mutate(monthly_profit_per_width = unit_margin * monthly_demand / width, .before = "category_id")

# top products by monthly profit
p %>% slice_max(monthly_profit, n=10)

# top products by monthly profit per unit width
p %>% slice_max(monthly_profit_per_width, n=10)

# full set of products
datatable(p)

# brands
p %>% count(brand_id)

# total width of all products
p %>% summarize(width_total = sum(width))

### suggestion: add a column of 1/0 for product facings
### track total revenue, total width, products per brand
