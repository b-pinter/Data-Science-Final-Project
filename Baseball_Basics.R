#install.packages("baseballr")
install.packages('tibble')
install.packages('dplyr')
install.packages('lubridate')
install.packages("olsrr")
install.packages('readr')
install.packages('rsample')
install.packages('tidymodels')
install.packages('glmnet')
install.packages('rpart')
install.packages('caret')
install.packages('rpart.plot')
install.packages('caTools')
install.packages('randomForest')
install.packages('shiny')
library(baseballr)
library(tidyverse)
library(tidymodels)
library(tibble)
library(dplyr)
library(lubridate)
library(olsrr)
library(readr)
library(rsample)
library(tidymodels)
library(glmnet)
library(rpart)
library(rpart.plot)
library(caret)
library(caTools) 
library(randomForest) 

#RUN THIS LINE IF BROKEN, AND RESTART KERNAL!
devtools::install_github(repo = "BillPetti/baseballr", force = T)
#For loop?
#liam <- try(statcast_search(start_date = "2016-04-06",
#                        end_date = "2023-08-01", 
#                       playerid = 521230,
#                       player_type = 'pitcher'))
#print(liam)
#statcast_leaderboards(leaderboard = "exit_velocity_barrels", year = 2021)
#Getting multiple statcast searches to run
#Both starting and relief pitchers
#mlb_id_surgery = c(521230,663556,664062,622780,645261)
#pitching_data = numeric(6)
#for(i in length(mlb_id_surgery)){
  #id_insert = mlb_id_surgery[i]
  #data_list[[i]] <- try(statcast_search(start_date = "2020-04-06",
#                          end_date = "2023-08-01", 
#                          playerid = id_insert,
#                         player_type = 'pitcher'))
#}
#Working example in use here
#data_list <- vector("list", length(mlb_id_surgery))
#for (i in seq_along(mlb_id_surgery)) {
  #id_insert <- mlb_id_surgery[i]
  #data_list[[i]] <- try(statcast_search(start_date = "2020-04-06",
                                    #end_date = "2023-08-01", 
                                    #playerid = id_insert,
                                    #player_type = 'pitcher'))
# }

#Onlne active database contained all players who had Tommy John Surgery
#Data was confidmed from at least "one news article" by the person who made it.

#The following code will take all pitchers who HAD Tommy John Surgery since 2020
#Takes all data from pitchers TWO YEARS prior to surgery
surgeryList <- read.csv('Surgery_List.csv')
surgeryList$TJ.Surgery.Date <- as.Date(surgeryList$TJ.Surgery.Date, format = "%m/%d/%Y")
filtered_df <- surgeryList[surgeryList$TJ.Surgery.Date > as.Date("2020-01-01"), ]

df_subset <- subset(filtered_df, Level == "MLB")

df_pitchers <- subset(df_subset, Position == 'P' )
df_dates <- tibble(df_pitchers$TJ.Surgery.Date)
df_dates <- df_dates %>% mutate(new_dates = df_pitchers$TJ.Surgery.Date %m-% years(2))
ID_list <- na.omit(as.list(df_pitchers$mlbamid))
data_list <- list()
for (i in seq_along(ID_list)) {
  id_insert <- ID_list[i]
  data_list[[i]] <- try(statcast_search(start_date = df_dates$new_dates[i],
                                    end_date = df_dates$`df_pitchers$TJ.Surgery.Date`[i], 
                                    playerid = id_insert,
                                    player_type = 'pitcher'))
}

test <- discard(data_list, ~nrow(.x) == 0)
combined_tibble <- bind_rows(test)
#Completed data, all pitchers with injuries present here
surgery_pitchers <- read.csv("data_surgery.csv")
surgery_pitchers <- surgery_pitchers %>% mutate(surgery = 1)

#Non-Injured Players
#Pulls data on all pitches from non-injured pitchers from 2018 to 2024.
#Complies into a tibble for use.
non_injured_2024 <- statcast_search(start_date = "2024-04-15",
                               end_date = "2024-10-15",
                               player_type = 'pitcher') %>%
  mutate(pitcher = as.character(pitcher)) %>%
  filter(!is.na(pitcher) & !(pitcher %in% as.character(ID_list)))
non_injured_2023 <- statcast_search(start_date = "2023-04-15",
                                    end_date = "2023-10-15",
                                    player_type = 'pitcher') %>%
  mutate(pitcher = as.character(pitcher)) %>%
  filter(!is.na(pitcher) & !(pitcher %in% as.character(ID_list)))
non_injured_2022 <- statcast_search(start_date = "2022-04-15",
                                    end_date = "2022-10-15",
                                    player_type = 'pitcher') %>%
  mutate(pitcher = as.character(pitcher)) %>%
  filter(!is.na(pitcher) & !(pitcher %in% as.character(ID_list)))
non_injured_2021 <- statcast_search(start_date = "2021-04-15",
                                    end_date = "2021-10-15",
                                    player_type = 'pitcher') %>%
  mutate(pitcher = as.character(pitcher)) %>%
  filter(!is.na(pitcher) & !(pitcher %in% as.character(ID_list)))
non_injured_2020 <- statcast_search(start_date = "2020-04-15",
                                    end_date = "2020-10-15",
                                    player_type = 'pitcher') %>%
  mutate(pitcher = as.character(pitcher)) %>%
  filter(!is.na(pitcher) & !(pitcher %in% as.character(ID_list)))

non_injured_list = list(non_injured_2024,non_injured_2023,non_injured_2022
                        ,non_injured_2021,non_injured_2020)
combined_non_injured <- bind_rows(non_injured_list)
combined_non_injured <- combined_non_injured %>% mutate(surgery = 0)
#write_csv(combined_non_injured, "data_noSurgery.csv")

non_surgery_pitchers <- read.csv('data_noSurgery.csv')
#Add column since all pitcher data here is from players with no injury.

model <- lm(surgery ~  release_speed + release, data = non_injured)
ols_step_all_possible(model)

#Completed dataset, before removing useless columns
complete_pitchers <- bind_rows(non_surgery_pitchers,surgery_pitchers)

#EXTRA CLEANING
#Removing redundant and useless columns from the data
data_complete = drop_na(data_complete)
data_complete_test <- data_complete %>% select(-c(game_date, player_name
                                             , batter, pitcher, events, description,
                                             des, game_type, stand, home_team, away_team,
                                             hit_location, bb_type, balls, strikes,
                                             on_3b, on_2b, outs_when_up, inning, inning_topbot,
                                             umpire, fielder_2, fielder_3, fielder_4, fielder_5,
                                             fielder_6, fielder_7, fielder_8, fielder_9, pitch_name, home_score,
                                             away_score, bat_score,
                                             fld_score, post_away_score, post_fld_score)) %>%
  mutate(pitch_type = as.factor(pitch_type))

#write_csv(data_complete_test, "data_smaller.csv")
#Final dataset for use.
data_final <- read_csv('data_smaller.csv')
data_final$surgery <- as.factor(data_final$surgery)
#Machine Learning Modeling Testing/Preliminary Work
#Logit Regression, will automatically delete nans
model <- glm(surgery ~  release_speed + arm_angle + 
              pitch_type + spin_axis + api_break_x_arm + release_spin_rate, data = data_final,
             family = "binomial")
#This takes forever to run, SKIP!!
#ols_step_all_possible(model)
summary(model)
#confint(model)
#exp(confint(model))
#SIGNIFICANCE OF PITCHES
#ADD TO PAPER
#CU = Curveball
#FC = Cutter
#FF = Four-Seam Fastball
#FS = Splitter
#KC = Knuckle-curve
#SI = Sinker
#SL = Slider
#ST = Sweeper


#Logisitic Regression

#Splitting Data

split <- initial_split(data_final, prop = 0.8, strata = surgery)
train <- split %>% 
  training()
test <- split %>% 
  testing()

# Train a logistic regression model
model <- logistic_reg(mixture = double(1), penalty = double(1)) %>%
  set_engine("glmnet") %>%
  set_mode("classification") %>%
  fit(surgery ~ release_speed + arm_angle + 
        pitch_type + spin_axis + api_break_x_arm + release_spin_rate, data = train)

# Model summary
tidy(model)

# Class Predictions
pred_class <- predict(model,
                      new_data = test,
                      type = "class")

# Class Probabilities
pred_proba <- predict(model,
                      new_data = test,
                      type = "prob")
results <- test %>%
  select(surgery) %>%
  bind_cols(pred_class, pred_proba)

accuracy(results, truth = surgery, estimate = .pred_class)

# Create confusion matrix
conf_mat(results, truth = surgery,
         estimate = .pred_class)

#Decision Tree

train_index <- createDataPartition(data_final$surgery, p = 0.8, list = FALSE)
train_data <- data_final[train_index, ]
test_data <- data_final[-train_index, ]

tree_model <- rpart(surgery ~ release_speed + arm_angle + 
                      pitch_type + spin_axis + api_break_x_arm + release_spin_rate, 
                    data = train_data, 
                    method = "class",  # For classification
                    control = rpart.control(minsplit = 10, cp = 0.01))

rpart.plot(tree_model, box.palette = "auto", nn = TRUE)

predictions <- predict(tree_model, test_data, type = "class")
confusionMatrix(predictions, test_data$surgery)

#Random Forest


split <- initial_split(data_final, prop = 0.7, strata = surgery)
train <- split %>% 
  training()
test <- split %>% 
  testing()

train <- sample (1: nrow(data_final), nrow(data_final) / 2)

#A issue with nans is occurring here, and I have not found a way to move past it.
rf.surgery <- randomForest(surgery ~ release_speed + arm_angle + 
                              pitch_type + spin_axis + api_break_x_arm + release_spin_rate,
                            data = data_final ,
                            subset = train , mtry = 6, importance = TRUE )

#Random Forest NAN Issues

# Replace all NAs with 0

#

# Define your logistic regression model

split <- initial_split(data_final, prop = 0.8, strata = surgery)
train <- split %>% 
  training()
test <- split %>% 
  testing()

#BETTER MODEL - USE THIS
model <- logistic_reg(mixture = double(1), penalty = double(1)) %>%
  set_engine("glmnet") %>%
  set_mode("classification") %>%
  fit(surgery ~ release_speed + arm_angle + 
        pitch_type + spin_axis + api_break_x_arm + release_spin_rate, data = train)

# Get class probabilities instead of default classifications
pred_probs <- predict(model, new_data = train, type = "prob")

# Set custom threshold (e.g., 0.3)
threshold <- 0.3
pred_labels <- ifelse(pred_probs$.pred_1 > threshold, "1", "0")

# Convert to factors for evaluation
pred_labels <- as.factor(pred_labels)
actual <- as.factor(train$surgery)

# Compute confusion matrix
conf_matrix <- yardstick::conf_mat(data.frame(actual, pred_labels), truth = actual, estimate = pred_labels)
print(conf_matrix)

#Accuracy Score Portion
results <- data.frame(actual = actual, predicted = pred_labels)
accuracy_score <- yardstick::accuracy(results, truth = actual, estimate = predicted)
print(accuracy_score)


# Combine actual values and predicted probabilities into a dataframe
roc_data <- data.frame(
  actual = train$surgery,   # Actual class labels
  prob_1 = pred_probs$.pred_1  # Probability of class "1"
)

# Compute ROC curve data
roc_curve_data <- yardstick::roc_curve(roc_data, truth = actual, prob_1)

# Compute AUC score
auc_score <- yardstick::roc_auc(roc_data, truth = actual, prob_1)
print(auc_score)

# Plot ROC Curve
ggplot(roc_curve_data, aes(x = 1 - specificity, y = sensitivity)) +
  geom_line(color = "blue", size = 1) +  # ROC curve
  geom_abline(linetype = "dashed", color = "gray") +  # Random classifier line
  labs(title = "ROC Curve for Logistic Regression",
       x = "1 - Specificity (False Positive Rate)",
       y = "Sensitivity (True Positive Rate)") +
  theme_minimal()

data_complete.head()
head(data_complete)



pitcher_total <- read.csv('data_complete.csv')

head(pitcher_total)