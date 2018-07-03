#include <iostream>
#include <stdio.h>
#include <math.h>
#include <cstring>

using namespace std;

struct cache_content
{
	bool v;
	unsigned int tag;
    // unsigned int	data[16];
};

const int K = 1024;

double log2(double n)
{  
    // log(n) / log(2) is log2.
    return log(n) / log(double(2));
}

int search_cache(cache_content *cache,int way)
{
	int i;
	for(i=0;i<way;i++)
		if(!cache[i].v)
			break;
	return i;
}

void insert(cache_content *cache,int s,int t,unsigned int tag)
{
	for(int i=s;i<=t;i++)
	{
		cache[i-1].tag=cache[i].tag;
		cache[i-1].v=true;
	}
	cache[t].tag=tag;
	cache[t].v=true;
	return;
}

void simulate(char *file,int cache_size, int block_size,int way)
{
	unsigned int tag, index, x;

	int offset_bit = (int)log2(block_size);
	int index_bit = (int)log2(cache_size / block_size);
	int line = cache_size >> (offset_bit);

	int miss=0;
	int total=0;
	int set_num=line/way;
	bool c=false;

	cache_content **cache = new cache_content*[set_num];
	for(int i=0;i<set_num;i++)
	{
		cache[i]=new cache_content[way];
		for(int j=0;j<way;j++)
			cache[i][j].v=false;
	}
	
    FILE *fp = fopen(file, "r");  // read file
	
	while(fscanf(fp, "%x", &x) != EOF)
    {
		index = (x >> offset_bit) & (set_num - 1);
		tag = x >> offset_bit;
		total++;
		c=false;
		for(int i=0;i<way;i++)
			if(cache[index][i].v && cache[index][i].tag==tag)
			{
				// hit
				c=true;
				int idx=search_cache(cache[index],way);
				insert(cache[index],i+1,idx-1,tag);
				break;
			}
		if(!c)
        {
        	miss++;	// miss
        	int idx=search_cache(cache[index],way);
        	if(idx==way)
        		insert(cache[index],1,way-1,tag);
        	else
        	{
        		cache[index][idx].v = true;
				cache[index][idx].tag = tag;
        	}
		}
	}
	cout<<"cache size: "<<cache_size<<endl;
	cout<<"way: "<<way<<endl;
	cout<<"miss ratio: "<<(double)miss/(double)total<<endl<<endl;
	fclose(fp);

	for(int i=0;i<set_num;i++)
		delete [] cache[i];
	delete [] cache;
}
	
int main()
{
	int cash,way;
	char file[2][20];
	strcpy(file[0],"LU.txt");
	strcpy(file[1],"RADIX.txt");
	for(int i=0;i<2;i++)
	{
		cout<<file[i]<<endl<<endl;
		for(cash=1;cash<=32;cash<<=1)
		{
			for(way=1;way<=8;way<<=1)
				simulate(file[i],cash * K, 64, way);
			cout<<"= = = = = = = = = = = = = ="<<endl<<endl;
		}
		cout<<endl;
	}
}
