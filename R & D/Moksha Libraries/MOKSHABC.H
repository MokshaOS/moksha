
//Header file for copying any binary file
#ifndef MOKSHABCOPY_H
#define MOKSHABCOPY_H
int copy_file(char source[],char destination[])
{
char file_data;
int copy_result;
ifstream openfile(source,ios::binary,ios::beg);
ofstream writefile(destination,ios::binary);
if(!openfile)
{
copy_result=0; // Copy operation failed
}
else
{
while(!openfile.eof())
{
openfile.read((char *)&file_data,sizeof(file_data));
writefile.write((char *)&file_data,sizeof(file_data));
}
openfile.close();
writefile.close();
copy_result=1; // Copy operation successful
}
return copy_result;
}
#endif