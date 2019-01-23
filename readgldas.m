function [gldas,time,num_file]=readgldas(controlfile_path)
% Read the Control File
fid=fopen(controlfile_path,'r');
num_file= fscanf(fid,'%d',1);
lat= fscanf(fid,'%d',1);%纬度
lon= fscanf(fid,'%d',1);%经度
dir_in=fscanf(fid,'%s',1);%路径
file_name=cell(num_file,1);
for i = 1:num_file 
    file_name{i} = fscanf(fid,'%s',1);
end
%ini
gldas=zeros(num_file,lat,lon);
SWE=zeros(num_file,lat,lon);
SoilMoi0_10cm_inst=zeros(num_file,lat,lon);
SoilMoi100_200cm_inst=zeros(num_file,lat,lon);
SoilMoi10_40cm_inst=zeros(num_file,lat,lon);
SoilMoi40_100cm_inst=zeros(num_file,lat,lon);
time=zeros(num_file,1);
for ii=1:num_file
    file=char(strcat(dir_in,file_name(ii)));
    SWE(ii,:,:)=rot90(ncread(file,'SWE_inst'));
    SoilMoi0_10cm_inst(ii,:,:)=rot90(ncread(file,'SoilMoi0_10cm_inst'));
    SoilMoi100_200cm_inst(ii,:,:)=rot90(ncread(file,'SoilMoi100_200cm_inst'));
    SoilMoi10_40cm_inst(ii,:,:)=rot90(ncread(file,'SoilMoi10_40cm_inst'));
    SoilMoi40_100cm_inst(ii,:,:)=rot90(ncread(file,'SoilMoi40_100cm_inst'));
    time(ii,:,:)=ncread(file,'time');
end
for j=1:num_file
    gldas(j,:,:)=SWE(j,:,:)+SoilMoi0_10cm_inst(j,:,:)+SoilMoi100_200cm_inst(j,:,:)+SoilMoi10_40cm_inst(j,:,:)+SoilMoi40_100cm_inst(j,:,:);
end