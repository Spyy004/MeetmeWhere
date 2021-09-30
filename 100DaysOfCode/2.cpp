#include <bits/stdc++.h>
#include <unordered_map>

using namespace std;

int main()
{
    int z;
    cin>>z;
    int n;
    cin>>n;
    int a[n];
    map<int,int> m;
    int sum=0;
    for(int i=0;i<n;i++)
    {
        cin>>a[i];
        m[a[i]]=i+1;
    }
    for(auto a : m)
    {
        while(a.second>0){
        if(z-a.first>=0)
        {
            z=z-a.first;
            sum++;
            a.second--;
        }
        else
        break;
        }
    }
    cout<<sum<<endl;

    return 0;
}
