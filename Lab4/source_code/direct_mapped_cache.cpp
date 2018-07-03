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


void simulate(char *file,int cache_size, int block_size)
{
	unsigned int tag, index, x;

	int offset_bit = (int)log2(block_size);
	int index_bit = (int)log2(cache_size / block_size);
	int line = cache_size >> (offset_bit);

	int miss=0;
	int total=0;

	cache_content *cache = new cache_content[line];
	
    cout << "cache line: " << line << endl;

	for(int j = 0; j < line; j++)
		cache[j].v = false;
	
    FILE *fp = fopen(file, "r");  // read file
	
	while(fscanf(fp, "%x", &x) != EOF)
    {
		// cout << hex << x << " ";
		index = (x >> offset_bit) & (line - 1);
		tag = x >> (index_bit + offset_bit);
		total++;
		if(cache[index].v && cache[index].tag == tag)
			cache[index].v = true;    // hit
		else
        {
        	miss++;
			cache[index].v = true;  // miss
			cache[index].tag = tag;
		}
	}
	cout<<"cache size: "<<cache_size<<endl;
	cout<<"Block size: "<<block_size<<endl;
	cout<<"miss ratio: "<<(double)miss/(double)total<<endl<<endl;
	fclose(fp);

	delete [] cache;
}
	
int main()
{
	int cash,block;
	char file[2][20];
	strcpy(file[0],"ICACHE.txt");
	strcpy(file[1],"DCACHE.txt");
	for(int i=0;i<2;i++)
	{
		cout<<file[i]<<endl<<endl;
		for(cash=4;cash<=256;cash<<=2)
		{
			for(block=16;block<=256;block<<=1)
				simulate(file[i],cash * K, block);
			cout<<"= = = = = = = = = = = = = ="<<endl<<endl;
		}
		cout<<endl;
	}
}
