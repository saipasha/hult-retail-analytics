## Shelf space allocation starter
import pandas as pd

p = pd.read_csv("products_set_30.csv")
print(p)

# derived metrics
p['monthly_profit'] = p['unit_margin'] * p['monthly_demand']
p['monthly_profit_per_width'] = p['monthly_profit'] / p['width']
print(p)

# top products by monthly profit
print(p.sort_values('monthly_profit', ascending=False).head(10))

# top products by monthly profit per unit width
print(p.sort_values('monthly_profit_per_width', ascending=False).head(10))

# brands
print(p.groupby('brand_id').count().iloc[:,1])

# total width of all products
print(p['width'].sum())

### suggestion: add a column of 1/0 for product facings
### track total revenue, total width, products per brand

