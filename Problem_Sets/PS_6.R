# ECON 387
# Problem Set 6


library(readr)
library(Hmisc)
library(dplyr)
library(stargazer)

# Import all files to R
math06_12 <- read.csv("Major/data science/ECON_387/Math_2006_2012_All.csv")
math13_17 <- read.csv("Major/data science/ECON_387/Math_2013_2017_All.csv")
engl06_12 <- read.csv("Major/data science/ECON_387/English_2006_2012_All.csv", na.strings = "s")
engl13_17 <- read.csv("Major/data science/ECON_387/English_2013_2017_All.csv", na.strings = "s")

# Math_2006_2012_All
names(math06_12)
str(math06_12)
unique(math06_12$Demographic)

math06_12 <- math06_12 %>% 
  mutate(Demographic = "All Students", PctLevel1 = PctLevel1/100, PctLevel2 = PctLevel2/100, PctLevel3 = PctLevel3/100,
         PctLevel4 = PctLevel4/100, PctLevel3and4 = PctLevel3and4/100)

# Math_2013_2017_All
names(math13_17)
str(math13_17)
unique(math13_17$Demographic)

math13_17 <- math13_17 %>% 
  mutate(Demographic = "All Students", PctLevel1 = PctLevel1/100, PctLevel2 = PctLevel2/100, PctLevel3 = PctLevel3/100,
         PctLevel4 = PctLevel4/100, PctLevel3and4 = PctLevel3and4/100)

# Append math scores
Math_2006_2017_All <- merge(math06_12, math13_17, all = TRUE)
head(Math_2006_2017_All,12)

# English_2006_2012_All
names(engl06_12) <- names(math06_12)
describe(engl06_12)
str(engl06_12)
unique(engl06_12$Demographic)

engl06_12 <- engl06_12 %>% 
  mutate(PctLevel1 = PctLevel1/100, PctLevel2 = PctLevel2/100, PctLevel3 = PctLevel3/100,
         PctLevel4 = PctLevel4/100, PctLevel3and4 = PctLevel3and4/100)
head(engl06_12)

# English_2013_2017_All
names(engl13_17) <- names(engl06_12)
describe(engl13_17)
str(engl13_17)
head(engl13_17)

engl13_17$Meancalecore <- as.numeric(as.character(engl13_17$Meancalecore))
engl13_17$NumLevel1 <- as.numeric(as.character(engl13_17$NumLevel1))
engl13_17$PctLevel1 <- as.numeric(as.character(engl13_17$PctLevel1))
engl13_17$NumLevel2 <- as.numeric(as.character(engl13_17$NumLevel2))
engl13_17$PctLevel2 <- as.numeric(as.character(engl13_17$PctLevel2))
engl13_17$NumLevel3 <- as.numeric(as.character(engl13_17$NumLevel3))
engl13_17$PctLevel3 <- as.numeric(as.character(engl13_17$PctLevel3))
engl13_17$NumLevel4 <- as.numeric(as.character(engl13_17$NumLevel4))
engl13_17$PctLevel4 <- as.numeric(as.character(engl13_17$PctLevel4))
engl13_17$NumLevel3and4 <- as.numeric(as.character(engl13_17$NumLevel3and4))
engl13_17$PctLevel3and4 <- as.numeric(as.character(engl13_17$PctLevel3and4))

str(engl13_17)
head(engl13_17)
unique(engl13_17$Demographic)
engl13_17 <- engl13_17 %>% 
  mutate(Demographic = "All Students")

# Append english scores
English_2006_2017_All <- merge(engl06_12, engl13_17, all = TRUE)
head(English_2006_2017_All,12)

# Merge math and english on DBN, Year, Grade
ME_2006_2017_all <- merge(Math_2006_2017_All, English_2006_2017_All, by = c("DBN", "Year", "Grade"), suffixes = c("_1","_2"))
head(ME_2006_2017_all)

# generate borough
ME_2006_2017_all <- ME_2006_2017_all %>% 
  mutate(borough = substr(DBN, 3, 3))

# generate descriptive statistics
stargazer(ME_2006_2017_all, title = "Descriptive Statistics", type = "text")

# mean, std, min, max for pct passing scores
options(scipen = 999)
na.omit(ME_2006_2017_all) %>% 
  select(borough, Year, Grade, PctLevel3and4_1, PctLevel3and4_2) %>% 
  group_by(borough, Year, Grade) %>% 
  summarize(mean_1 = mean(PctLevel3and4_1),
            mean_2 = mean(PctLevel3and4_2),
            std_1 = sd(PctLevel3and4_1),
            std_2 = sd(PctLevel3and4_2),
            min_1 = min(PctLevel3and4_1),
            min_2 = min(PctLevel3and4_2),
            max_1 = max(PctLevel3and4_1),
            max_2 = max(PctLevel3and4_2))

# generate district
ME_2006_2017_all <- ME_2006_2017_all %>% 
  mutate(district = substr(DBN, 1, 2))

# regressions
model_engl <- lm(ME_2006_2017_all$PctLevel3and4_2 ~ ME_2006_2017_all$Year + 
               ME_2006_2017_all$borough + ME_2006_2017_all$district)
model_math <- lm(ME_2006_2017_all$PctLevel3and4_1 ~ ME_2006_2017_all$Year + 
               ME_2006_2017_all$borough + ME_2006_2017_all$district)
stargazer(model_engl, model_math, title = "Results", type = "text")


