function correctedData = removeOutliers (inputMatr)

%rows of inputMatr should be samples, columns should be features
correctedData = cell(size(inputMatr,2),1);

ptable = prctile(inputMatr,[25 75],1);
ltable = [ptable(1,:)-2.5*(ptable(2,:)-ptable(1,:)); ptable(2,:)+2.5*(ptable(2,:)-ptable(1,:))];


for i = 1 : size(inputMatr,2)
    a = inputMatr(:,i);
    b = find(~isnan(inputMatr(:,i))&(inputMatr(:,i)<ltable(1,i)|inputMatr(:,i)>ltable(2,i)));
    c = find(isnan(a));
    a([b; c]) = [];
    correctedData{i} = a;
end


end