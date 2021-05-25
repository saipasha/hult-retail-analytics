#' ---
#' title: "Shopping cart analysis starter"
#' author: "Pavel Paramonov"
#' date: "Retail Analytics (2021)"
#' ---
library(tidyverse)
library(arules)
library(arulesViz)
library(RColorBrewer)

# read transactions dataset and convert to arules sparse matrix format
fcsv <- "https://raw.githubusercontent.com/multidis/hult-retail-analytics/main/shopping_cart/transactions_binary.csv"
df_trans <- read_csv(fcsv)
trans <- transactions(as.matrix(df_trans))
summary(trans)

# rules exceeding support and confidence thresholds
rules <- apriori(trans, parameter = list(support=0.001, confidence=0.5))

# top 5 rules in terms of lift
inspect(head(sort(rules, by ="lift"), 5))

# frequency plot
itemFrequencyPlot(trans, topN = 20)

# most promising rules by lift (confidence-support scatterplot)
rules_sel <- head(sort(rules, by="lift"), 50)
plot(rules_sel, engine="plotly", control=list(col=brewer.pal(11,"Spectral")), main="")

# network representation
plot(rules_sel, method = "graph",  engine = "htmlwidget")

# rules for a selected product
rules_selprod <- subset(rules, subset = rhs %pin% "pastry")
inspect(head(sort(rules_selprod, by="lift"), 10))
