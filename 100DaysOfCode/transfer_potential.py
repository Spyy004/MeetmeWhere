if __name__=="__main__":

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from matplotlib.pyplot import figure
    figure(figsize=(8, 6), dpi=80)


    # In[2]:


    df = pd.read_csv('top250-00-19.csv')
    df.head(5)


    # In[3]:


    df.isna().sum()


    # In[4]:


    df.dropna(inplace=True)
    df.reset_index(drop=True, inplace=True)


    # In[15]:


    df['diff'] = df['Transfer_fee'] - df['Market_value']
    seasons = df.groupby('Season')['diff'].mean().reset_index()
    seasons


    # In[18]:


    seasons.plot(x='Season', y='diff')
    plt.title('average differences across all seasons')
    plt.xlabel('seasons')
    plt.ylabel('avg. difference of value and price')
    plt.show()


    # In[41]:


    transfer_trend = pd.pivot_table(df, index='Season', values='Market_value', aggfunc=np.max).reset_index()
    transfer_trend.plot(x='Season', y='Market_value')
    plt.title('transfer_trend')
    plt.xlabel('Season')
    plt.ylabel('max_transfer_value')
    plt.show()


    # In[37]:


    age_variation = pd.pivot_table(df, index='Age', values='Transfer_fee', aggfunc=np.max).reset_index()
    age_variation
