# Customer Behavior Analysis - Case Study (Excel Import)
# Author: Kalpesh Nardekar
# ---------------------------------------------------------

# 1. Load Libraries
install.packages("tidyverse")
library(tidyverse)

# 2. Import CSV File
# ⚠️ Update the file path to your actual dataset location
# Example: "C:/Users/YourName/Documents/customer_purchases.csv"

file_path <- "D:/VIT MSc/SEM-1/Exploratory Data Analysis/Week 1/customer_purchases.csv"

# Use read_csv from readr package (fast for large files)
customer_data <- read_csv(file_path)

# 3. Inspect Data
cat("✅ Data Imported Successfully!\n\n")
cat("Dataset Dimensions:\n")
print(dim(customer_data))

cat("\nFirst few rows:\n")
print(head(customer_data))

cat("\nStructure of dataset:\n")
str(customer_data)

cat("\nSummary Statistics:\n")
print(summary(customer_data))

# 4. Identify Data Types
cat("\nData Types of Each Column:\n")
print(sapply(customer_data, class))

# 5. Check Missing Values
cat("\nMissing Value Count per Column:\n")
print(colSums(is.na(customer_data)))

# 6. Convert Columns to Proper Data Types (if needed)
# 🧩 Adjust names based on your CSV column headers
# Example assumed columns:
# CustomerID, Gender, Age, ProductCategory, PurchaseAmount, Channel, PurchaseDate

customer_data <- customer_data %>%
  mutate(
    Channel = as.factor(Channel),
    Gender = as.factor(Gender),
    Product_Category = as.factor(Product_Category),
    Purchase_Amount = as.numeric(Purchase_Amount),
    Date_of_Purchase = as.Date(Date_of_Purchase)
  )


# 7. Summary Analytics
# Average Purchase Amount by Channel
avg_purchase <- customer_data %>%
  group_by(Channel) %>%
  summarise(Average_Purchase = mean(Purchase_Amount, na.rm = TRUE), .groups = "drop")

cat("\nAverage Purchase Amount by Channel:\n")
print(avg_purchase)

# Top Product Categories by Total Revenue
top_categories <- customer_data %>%
  group_by(Product_Category) %>%
  summarise(Total_Revenue = sum(Purchase_Amount, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(Total_Revenue))

cat("\nTop Product Categories by Revenue:\n")
print(top_categories)

# 8. Visualization Section
# (Optional: For 1 lakh+ rows, these plots might take a few seconds)

ggplot(customer_data, aes(x = Purchase_Amount)) +
  geom_histogram(binwidth = 500, fill = "steelblue", color = "white") +
  labs(title = "Distribution of Purchase Amounts", x = "Purchase Amount", y = "Count")

ggplot(customer_data, aes(x = Channel, y = Purchase_Amount, fill = Channel)) +
  geom_boxplot() +
  labs(title = "Purchase Amount by Channel")

ggplot(customer_data, aes(x = Product_Category, y = Purchase_Amount, fill = Channel)) +
  geom_bar(stat = "summary", fun = "sum", position = "dodge") +
  labs(title = "Revenue by Product Category and Channel", x = "Product Category", y = "Total Revenue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 9. Summary Insights
cat("\nKey Insights:\n")
cat("- The dataset contains", nrow(customer_data), "transactions.\n")
cat("- Average purchase values and top product categories calculated.\n")
cat("- Visuals reveal spending trends and channel performance.\n")

# -------- Purchase Amount Distribution --------
ggplot(customer_data, aes(x = Purchase_Amount)) +
  geom_histogram(binwidth = 500, fill = "steelblue", color = "white") +
  labs(title = "Distribution of Purchase Amounts", x = "Purchase Amount", y = "Count")

ggsave("plots/purchase_amount_distribution.png", width = 7, height = 5)

# -------- Average Purchase by Channel ---------

ggplot(avg_purchase, aes(x = Channel, y = Average_Purchase, fill = Channel)) +
  geom_bar(stat = "identity", width = 0.6) +
  labs(title = "Average Purchase Amount by Channel", x = "Channel", y = "Average Purchase")

ggsave("plots/avg_purchase_by_channel.png", width = 7, height = 5)


# -------- Revenue by Product Category and Channel --------
ggplot(customer_data, aes(x = Product_Category, y = Purchase_Amount, fill = Channel)) +
  geom_bar(stat = "summary", fun = "sum", position = "dodge") +
  labs(title = "Revenue by Product Category and Channel", x = "Product Category", y = "Total Revenue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("plots/revenue_by_category_channel.png", width = 8, height = 5)


# -------- Top Product Categories by Total Revenue --------
top_categories <- customer_data %>%
  group_by(Product_Category) %>%
  summarise(Total_Revenue = sum(Purchase_Amount, na.rm = TRUE)) %>%
  arrange(desc(Total_Revenue))

ggplot(top_categories, aes(x = reorder(Product_Category, Total_Revenue), y = Total_Revenue)) +
  geom_bar(stat = "identity", fill = "darkorange") +
  coord_flip() +
  labs(title = "Top Product Categories by Revenue", x = "Product Category", y = "Total Revenue")

ggsave("plots/top_product_categories.png", width = 7, height = 5)


# -------- Missing Values Heatmap -------
install.packages("Amelia")
library(Amelia)
missmap(customer_data, main = "Missing Data Heatmap")
ggsave("plots/missing_values_heatmap.png", width = 7, height = 5)
