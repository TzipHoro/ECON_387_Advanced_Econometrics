#ECON 387
#Problem Set 4

import pandas as pd
import numpy as np
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.iolib.summary2 import summary_col

#1
math_06_12 = pd.read_csv(r"C:\Users\Tziporah\Documents\Major\data science\ECON_387\Math_2006_2012_All.csv")
math_13_17 = pd.read_csv(r"C:\Users\Tziporah\Documents\Major\data science\ECON_387\Math_2013_2017_All.csv")
engl_06_12 = pd.read_csv(r"C:\Users\Tziporah\Documents\Major\data science\ECON_387\English_2006_2012_All.csv")
engl_13_17 = pd.read_csv(r"C:\Users\Tziporah\Documents\Major\data science\ECON_387\English_2013_2017_All.csv")


#2
math_06_12.PctLevel1, math_06_12.PctLevel2, math_06_12.PctLevel3, \
  math_06_12.PctLevel4, math_06_12.PctLevel3and4 =  math_06_12.PctLevel1/100, \
  math_06_12.PctLevel2/100, math_06_12.PctLevel3/100, math_06_12.PctLevel4/100, \
  math_06_12.PctLevel3and4/100

math_13_17.PctLevel1, math_13_17.PctLevel2, math_13_17.PctLevel3, \
  math_13_17.PctLevel4, math_13_17.PctLevel3and4 =  math_13_17.PctLevel1/100, \
  math_13_17.PctLevel2/100, math_13_17.PctLevel3/100, math_13_17.PctLevel4/100, \
  math_13_17.PctLevel3and4/100

engl_06_12.columns = engl_06_12.columns.str.replace(' ', '')

engl_06_12.PctLevel1 = pd.to_numeric(engl_06_12.PctLevel1, errors='coerce')
engl_06_12.PctLevel2 = pd.to_numeric(engl_06_12.PctLevel2, errors='coerce')
engl_06_12.PctLevel3 = pd.to_numeric(engl_06_12.PctLevel3, errors='coerce')
engl_06_12.PctLevel4 = pd.to_numeric(engl_06_12.PctLevel4, errors='coerce')
engl_06_12.PctLevel3and4 = pd.to_numeric(engl_06_12.PctLevel3and4, errors='coerce')

engl_06_12 = engl_06_12.dropna()


engl_06_12.PctLevel1, engl_06_12.PctLevel2, engl_06_12.PctLevel3, \
  engl_06_12.PctLevel4, engl_06_12.PctLevel3and4 =  engl_06_12.PctLevel1/100, \
  engl_06_12.PctLevel2/100, engl_06_12.PctLevel3/100, engl_06_12.PctLevel4/100, \
  engl_06_12.PctLevel3and4/100


engl_13_17 = engl_13_17.rename(columns={"Number.Teted": "NumberTested", "Mean.cale.core": \
  "MeanScaleScore", "Level1_N": "NumLevel1", "Level1": "PctLevel1", "Level2_N": "NumLevel2",\
  "Level2": "PctLevel2", "Level3_N": "NumLevel3", "Level3": "PctLevel3", "Level4_N": \
  "NumLevel4", "Level3_4_N": "NumLevel3and4", "Level4": "PctLevel4", "Level3_4": "PctLevel3and4"})
engl_13_17 = engl_13_17.dropna()

# percent passing variables of engl_13_17 are already ratios


#3
English_2006_2017_all = pd.concat([engl_06_12, engl_13_17])
English_all = English_2006_2017_all.to_csv(r"C:\Users\Tziporah\Documents\Major\data science\ECON_387\English_2006_2017_all.csv")

Math_2006_2017_all = pd.concat([math_06_12, math_13_17])
Math_all = Math_2006_2017_all.to_csv(r"C:\Users\Tziporah\Documents\Major\data science\ECON_387\Math_2006_2017_all.csv")


#4
ME_2006_2017 = pd.merge(English_2006_2017_all, Math_2006_2017_all, on = ["DBN", "Year", "Grade"])
ME_all = ME_2006_2017.to_csv(r"C:\Users\Tziporah\Documents\Major\data science\ECON_387\ME_2006_2017_all.csv")


#5
ME_2006_2017["borough"] = ME_2006_2017.DBN.str.slice(start=2, stop = 3)


#6
ME_2006_2017.describe()


#7
ME_2006_2017.groupby(['borough',"Year", "Grade"])[['PctLevel3and4_x','PctLevel3and4_y']].aggregate([np.mean,np.std,min,max])


#8
ME_2006_2017["district"] = ME_2006_2017.DBN.str.slice(stop = 2)


#9
engl_model = smf.ols(formula= "PctLevel3and4_x~Year+borough+district", data= ME_2006_2017)
engl_result = engl_model.fit()
engl_result.summary()


#10
math_model = smf.ols(formula= "PctLevel3and4_y~Year+borough+district", data= ME_2006_2017)
math_result = math_model.fit()
math_result.summary()
