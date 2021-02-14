% index group (age, month, gender, condition)
% index variables
% result data in double values


% variable names
variable=result(1,6:end);
% participant group index (age, month, gender, condition
groups=result(2:end,1:5);

% Numerical Data
data=result;
data(:,1:5)=[];
data(1,:)=[];
data=cell2mat(data);
ms=[1,4,6,8,10,12,14,16,18,20,22,24,26]; % index of columns that record RT
data(:,ms)=data(:,ms)*1000; % convert into ms

% indexing which participant to exclude (accuracy <0.7)
a=0;

for i=1:size(data,1)
    if data(i,2)<0.7
       excl(a+1)=i;
       a=a+1;
    end
end


% record the age of excluded participants
for i=1:length(excl)
    excl_age(i)=groups(excl(i)+1,1);
end

% Exclude them from the dataset
data(excl,:)=[];
groups(excl,:)=[];
result(excl+1,:)=[];

% Index Age Group with 1='4yr', 2='6yr', 3='adult'

for i=1:length(groups)
    if strcmp(groups{i,1},'adult')
        age_index(i,1)=3;
    elseif strcmp(groups{i,1},'6')
        age_index(i,1)=2;
    else
        age_index(i,1)=1;
    end
end

% Gender Group
for i=1:length(groups)
    if strcmpi(groups{i,4},'m')
        gender_index(i,1)=1;
    
    else
        gender_index(i,1)=2;
    end
end


% age in month
age_month=cell2mat(groups(:,2));

% Condition index
condition_index=cell2mat(groups(:,5));

fprintf(' no. of adults: %d ; male=%d/ female=%d     ', sum(age_index==3), sum(age_index==3 & gender_index==1), sum(age_index==3 & gender_index==2) );
fprintf('\r\n no. of 6-yr-olds: %d ; male=%d/ female=%d     ', sum(age_index==2), sum(age_index==2 & gender_index==1), sum(age_index==2 & gender_index==2) );
fprintf('\r\n no. of 4-yr-olds: %d ; male=%d/ female=%d     ', sum(age_index==1), sum(age_index==1 & gender_index==1), sum(age_index==1 & gender_index==2) );

fprintf('\r\n no. of male: %d     ', sum(gender_index==1));
fprintf('\r\n no. of female: %d     ', sum(gender_index==2));