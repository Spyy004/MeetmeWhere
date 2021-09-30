#include<bits/stdc++.h>
using namespace std;

int main()
{
    string num1, num2;
    cout<<"Enter two floating no. : \n";
    cin>>num1>>num2;

    string a1,a2,b1,b2;


    int i=0;
    while (num1[i]!='.')
    {
        a1.push_back(num1[i]);
        i++;
    }
    i++;
    while (i<num1.length())
    {
        b1.push_back(num1[i]);
        i++;
    }
    int j=0;
    while (num2[j]!='.')
    {
        a2.push_back(num2[j]);
        j++;
    }
    j++;
    while (j<num2.length())
    {
        b2.push_back(num2[j]);
        j++;
    }

    if(b1.length()>b2.length())
    {
        for(int i=b2.length();i<b1.length();i++)
            b2.push_back('0');

    }
    else
    {
        for(int i=b1.length();i<b2.length();i++)
            b1.push_back('0');
    }


    reverse(b1.begin(),b1.end());
    reverse(b2.begin(),b2.end());

    int len=b1.length();

    string b="";
    int c=0;

    for(i=0;i<len;i++)
    {
        int tempsum=((b1[i]-'0')+(b2[i]-'0')+c);
        b.push_back(tempsum%10+'0');
        c=tempsum/10;
    }

    reverse(b.begin(),b.end());


    int len1=a1.length(),len2=a2.length();

    if(len1>len2)
    {
        swap(a1,a2);
        swap(len1,len2);
    }

    reverse(a1.begin(),a1.end());
    reverse(a2.begin(),a2.end());

    string a="";
    int tempsum=((a1[0]-'0')+(a2[0]-'0')+c);
    a.push_back(tempsum%10+'0');
    int c2=tempsum/10;

    for(int i=1;i<len1;i++)
    {
        int tempsum=((a1[i]-'0')+(a2[i]-'0')+c2);
        a.push_back(tempsum%10+'0');
        c2=tempsum/10;
    }
    for(int i=len1;i<len2;i++)
    {
        int tempsum=((a2[i]-'0') + c2);
        a.push_back(tempsum%10+'0');
        c2=tempsum/10;
    }
    if(c2)
        a.push_back(c2+'0');

    reverse(a.begin(),a.end());

    cout<<"Sum = "<<a<<"."<<b<<endl;

}



