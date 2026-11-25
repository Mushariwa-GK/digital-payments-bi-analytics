from pathlib import Path
import numpy as np
import pandas as pd
r=np.random.default_rng(42)
p=Path(__file__).parent/'data'; p.mkdir(exist_ok=True)
markets=['Singapore','Malaysia','Indonesia','Thailand','Vietnam','Philippines']
c=pd.DataFrame({'customer_id':range(1,8001),'market':r.choice(markets,8000),'signup_date':pd.Timestamp('2024-07-01')+pd.to_timedelta(r.integers(0,500,8000),unit='D')})
m=pd.DataFrame({'merchant_id':range(1,351),'category':r.choice(['Retail','Food','Transport','Utilities','Entertainment'],350),'market':r.choice(markets,350)})
n=50000; ci=r.integers(0,len(c),n); mi=r.integers(0,len(m),n)
dates=pd.Timestamp('2025-01-01')+pd.to_timedelta(r.integers(0,365,n),unit='D'); dates=np.maximum(dates.to_numpy(),c.signup_date.to_numpy()[ci]); method=r.choice(['Wallet','Card','Bank transfer','QR'],n); risk=np.select([method=='Card',method=='Bank transfer'],[.06,.04],default=.02); u=r.random(n); status=np.where(u<risk,'Failed',np.where(u<risk+.01,'Pending','Successful')); amount=np.round(r.lognormal(3.5,.8,n),2); fee=np.where(status=='Successful',np.round(amount*.008,2),0)
t=pd.DataFrame({'transaction_id':range(1,n+1),'transaction_date':dates,'customer_id':c.customer_id.to_numpy()[ci],'merchant_id':m.merchant_id.to_numpy()[mi],'payment_method':method,'status':status,'amount_sgd_equivalent':amount,'fee_sgd_equivalent':fee,'failure_reason':np.where(status=='Failed',r.choice(['Timeout','Insufficient funds','Declined'],n),'')})
for name,df in [('customers',c),('merchants',m),('transactions',t)]: df.to_csv(p/f'{name}.csv',index=False)
assert t.transaction_id.is_unique and (t.amount_sgd_equivalent>0).all() and (t.transaction_date>=c.signup_date.to_numpy()[ci]).all()
print(t.status.value_counts()); print(t.fee_sgd_equivalent.sum()); print(t.loc[t.status=='Successful','amount_sgd_equivalent'].sum())
