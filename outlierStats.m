clear all; clc %#ok<*CLSCR>
matObj = matfile('~/Desktop/SHUKTI/MG002.mat');
MSmodels = matObj.MSmodels;
param = [2 5 10 11 12 13 16 17 24 25 26 27 28 29 30 31 32 33 36 37];
MSmodelsReq = MSmodels(param,:);
clear MSmodels
MSmodelsReq = MSmodelsReq';
a = MSmodelsReq(:,1);
outliers1 = find(isnan(a));

% %calculation using quantils
% qtable = quantile(MSmodelsReq,[0.01 0.99],1);
% outCell = cell(20,1);
% 
% for i = 1:20
%     outCell{i} = find(~isnan(MSmodelsReq(:,i))&(MSmodelsReq(:,i)<qtable(1,i)|MSmodelsReq(:,i)>qtable(2,i)));
% end
% 
% MSth = cell(20,1);
% for i = 1:20
%     a = MSmodelsReq(:,i);
%     b = outCell{i};
%     a(b) = [];
%     MSth{i} = a;
% end
% 
% %----------------fitting probability distribution function-------
% f = @(x)fitdist(x,'logistic');
% C = cellfun(f, MSth, 'UniformOutput', false);
% p = cellfun(@paramci, C, 'UniformOutput', false);

%------------------alternate method-----------------------------
ptable = prctile(MSmodelsReq,[25 75],1);
ltable = [ptable(1,:)-2.5*(ptable(2,:)-ptable(1,:)); ptable(2,:)+2.5*(ptable(2,:)-ptable(1,:))];

newOutCell = cell(20,1);
for i = 1:20
   newOutCell{i} = find(~isnan(MSmodelsReq(:,i))&(MSmodelsReq(:,i)<ltable(1,i)|MSmodelsReq(:,i)>ltable(2,i)));
end

MSthNew = cell(20,1);
for i = 1:20
    a = MSmodelsReq(:,i);
    b = newOutCell{i};
    c = find(isnan(a));
    a([b;c]) = [];
    MSthNew{i} = a;
end

correctedData = removeOutliers (MSmodelsReq);
