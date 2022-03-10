import pandas as pd
try:
    df = pd.read_csv("csv.csv")
except:
    df = pd.read_csv("backup.csv")

keywords = ["mice","garbage","contam","cold"]

pct_A = {}
for k in keywords:
    df[k] = df['VIOLATION DESCRIPTION'].str.contains(k, case=False)
    pct_A[k] = len(df.query("%s==True & GRADE=='A'" % k)) / len(df.query("%s==True" % k))
    
s = pd.Series(pct_A, name='pct')
s.sort_values()
