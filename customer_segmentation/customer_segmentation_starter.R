#' ---
#' title: "Customer segmentation starter"
#' author: "Pavel Paramonov"
#' date: "Retail Analytics (2021)"
#' ---
library(tidyverse)
library(ggplot2)
library(plotly)

# load customer RFM dataset (choose yours instead)
fcsv <- "https://raw.githubusercontent.com/multidis/hult-retail-analytics/main/customer_segmentation/datasets/customers_30.csv"
cust_rfm <- read_csv(fcsv)
cust_rfm

# explore customer metrics in the dataset
qplot(frequency, data=cust_rfm, binwidth=5)
quantile(cust_rfm$frequency, 0.7)
quantile(cust_rfm$frequency, 0.8)

qplot(recency, data=cust_rfm, binwidth=10)
quantile(cust_rfm$recency, 0.3)

qplot(monetary, data=cust_rfm, binwidth=1000)
qplot(monetary, data=cust_rfm, binwidth=500, xlim=c(0, 20000))
quantile(cust_rfm$monetary, 0.7)

# interactive scatter plot to explore most valuable customers
plot_ly(cust_rfm, x = ~frequency, y = ~monetary, color = ~recency,
        hoverinfo = "text", text = ~CustomerID) %>%
    add_markers()

# edit as needed: average values over customer subsets; this is just an example
cust_rfm %>%
  filter(frequency > quantile(cust_rfm$frequency, 0.7)) %>%
  filter(monetary > quantile(cust_rfm$monetary, 0.7)) %>%
  summarize(rec = mean(recency))
