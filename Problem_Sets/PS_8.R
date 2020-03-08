# ECON 387
# Problem Set 8

install.packages("plm")
library(plm)
library(lmtest)
library(readr)

CornwellData <- read_csv("C:\\Users\\Tziporah\\Downloads\\cornwell_rupert(1).csv")
MunnellData <- read_csv("C:\\Users\\Tziporah\\Downloads\\munnell(1).csv")

# Cornwell and Rupert
CornwellData <- pdata.frame(CornwellData, index = c("ID", "YEAR"),
                         drop.index = FALSE,
                         row.names = TRUE)

# 1a
Cornwell_Fixed <- plm(LWAGE ~ EXP + (EXP ^ 2) + WKS, data = CornwellData,
                      effect = "individual",
                      model = "within")
coeftest(Cornwell_Fixed)
# For each additional year of experience, wage increases by 10 percentage points when other variables are held constant.

# 1b
plmtest(LWAGE ~ EXP + (EXP ^ 2) + WKS,
        data = CornwellData,
        effect = "individual")

# 1c
Cornwell_Random <- plm(LWAGE ~ EXP + (EXP ^ 2) + WKS + ED, data = CornwellData,
                      effect = "individual",
                      model = "random")
coeftest(Cornwell_Random)
# For each additional year of experience, wage increases by 6 percentage points when other variables are held constant.

# 1d
bptest(LWAGE ~ EXP + (EXP ^ 2) + WKS + ED, data = CornwellData)


# Munnell
MunnellData <- pdata.frame(CornwellData, index = c("STATE", "YEAR"),
                         drop.index = FALSE,
                         row.names = TRUE)

# 2a
Munnell_Pooled <- plm(log(GSP) ~ log(P_CAP + HWY + WATER + UTIL) + log(PC) + log(EMP) + UNEMP,
                      data = MunnellData,
                      model = "pooling")
coeftest(Munnell_Pooled)
# The elasticity of gross state product with respect to log(P_CAP + HWY + WATER + UTIL) is 16 percentage points and is statistically significant.
# The elasticity of gross state product with respect to private capital is 31 percentage points and is statistically significant.

#2b
Munnell_Fixed <- plm(log(GSP) ~ log(P_CAP + HWY + WATER + UTIL) + log(PC) + log(EMP) + UNEMP,
                      data = MunnellData,
                      effect = "individual",
                      model = "within")
G <- length(unique(MunnellData$STATE))
cons <- G / (G - 1)
coeftest(Munnell_Fixed, cons * vcovHC(Munnell_Fixed, type = "HC0", cluster = "group"))
# The elasticity of gross state product with respect to log(P_CAP + HWY + WATER + UTIL) is -3 percentage points but is not statistically significant.
# The elasticity of gross state product with respect to private capital is 29 percentage points and is statistically significant.

# 2c
plmtest(log(GSP) ~ log(P_CAP + HWY + WATER + UTIL) + log(PC) + log(EMP) + UNEMP,
        data = MunnellData,
        effect = "individual")

# 2d
Munnell_Random <- plm(log(GSP) ~ log(P_CAP + HWY + WATER + UTIL) + log(PC) + log(EMP) + UNEMP,
                      data = MunnellData,
                      effect = "individual",
                      model = "random")
coeftest(Munnell_Random)
# The elasticity of gross state product with respect to log(P_CAP + HWY + WATER + UTIL) is 0.4 percentage points but is not statistically significant.
# The elasticity of gross state product with respect to private capital is 31 percentage points and is statistically significant.

# 2e
bptest(log(GSP) ~ log(P_CAP + HWY + WATER + UTIL) + log(PC) + log(EMP) + UNEMP,
       data = MunnellData)
