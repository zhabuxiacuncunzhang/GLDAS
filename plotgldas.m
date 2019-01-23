function plotgldas(gldas,time,num_file)
gldas(find(isnan(gldas)==1)) = 0;
for k=1:num_file
ave_gldas(k,1)=mean(mean(gldas(k,:,:)));
end
time=time-min(time);
plot(time,ave_gldas);