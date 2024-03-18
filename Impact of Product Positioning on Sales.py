#!/usr/bin/env python
# coding: utf-8

# In[2]:


# Load the data

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

product_positioning = pd.read_csv('product_positioning.csv')
product_positioning.head(5)


# In[3]:


# Exploration


print(f"product_positioning shape: {product_positioning.shape}")
print("\n")
print(f"product_positioning number of categories: {product_positioning.columns.nunique()}")
print("\n")
print(f"product_positioning columns datatypes: {product_positioning.dtypes}")
print("\n")


# In[4]:


# check for immediate anomolies using summary stats

product_positioning .info()


# In[5]:


round(product_positioning.describe(), 2)


# In[6]:


print(f"Missing Value Check:\n{product_positioning.isnull().sum()}")
#confirms no empty fields


# In[7]:


print(f" Number of Duplicated Rows: {product_positioning.duplicated().sum()}")


# In[30]:


# Data Analysis

# 1) How does the product position affect the consumer demographic?

df = product_positioning.groupby(['Product Position', 'Consumer Demographics']).agg({'Sales Volume': 'mean'}).reset_index()

plt.figure(figsize=(12, 6))
sns.barplot(data=df, x='Product Position', y='Sales Volume', hue='Consumer Demographics')
plt.title('Average Sales Volume by Product Position and Consumer Demographics')
plt.xlabel('Product Position')
plt.ylabel('Average Sales Volume')
plt.xticks(rotation=45)
plt.legend(title='Consumer Demographics')
plt.tight_layout()
plt.show()



# In[20]:


# 2) Where is each product most effectively placed for sales volume?

position_category_sales = product_positioning.groupby(['Product Position', 'Product Category'])['Sales Volume'].mean().reset_index()

# Pivot the data to create a heatmap
heatmap_data = position_category_sales.pivot('Product Position', 'Product Category', 'Sales Volume')

# Creating a heatmap to visualise the relationship between product position, category, and sales volume
plt.figure(figsize=(10, 6))
sns.heatmap(heatmap_data, cmap='Blues', annot=True, fmt=".1f")
plt.title('Average Sales Volume by Product Position and Category')
plt.xlabel('Product Category')
plt.ylabel('Product Position')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# It can be seen from the heatmap below that, based on this dataset, each product has a favoured position to maximise sales; 
# Clothing at the front of store, Electronics on aisles, and Food end cap.


# In[27]:


# 3) Assessing most frequently bought items by consumer demographic.

grouped_data.plot(kind='bar', figsize=(12, 8))
plt.title('Frequency of Purchases by Consumer Demographics and Product Category')
plt.xlabel('Consumer Demographics')
plt.ylabel('Frequency')
plt.xticks(rotation=45)
plt.legend(title='Product Category')
plt.tight_layout()
plt.show()

