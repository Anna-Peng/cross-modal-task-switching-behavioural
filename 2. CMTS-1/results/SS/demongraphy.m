% calculate mean age

allage=[result(2:end,2)];
allage=cell2mat(allage);

for i=1:length(result)-1
    if strcmpi( result{i+1,1}, 'a')
        adult(i,1)=allage(i);
        if strcmpi( result{i+1,4}, 'm')
            adult(i,2)=1;
        else
            adult(i,2)=2;
        end
    elseif strcmpi( result{i+1,1}, '6')
        six(i,1)=allage(i);
        if strcmpi( result{i+1,4}, 'm')
            six(i,2)=1;
        else
            six(i,2)=2;
        end
    else
        four(i,1)=allage(i);
        if strcmpi( result{i+1,4}, 'm')
            four(i,2)=1;
        else
            four(i,2)=2;
        end
    end
end


adult=nonzeros(adult);
six=nonzeros(six);
four=nonzeros(four);

adult=reshape(adult, [length(adult)/2, 2] );
six=reshape(six, [length(six)/2, 2] );
four=reshape(four, [length(four)/2, 2] );


adultAge=mean(adult(:,1))/12;
adultStd=std(adult(:,1))/12;
sixAge=mean(six(:,1))/12;
sixStd=std(six(:,1))/12;
fourAge=mean(four(:,1))/12;
fourStd=std(four(:,1))/12;

adultM=sum(adult(:,2)==1);
adultF=sum(adult(:,2)==2);
sixM=sum(six(:,2)==1);
sixF=sum(six(:,2)==2);
fourM=sum(four(:,2)==1);
fourF=sum(four(:,2)==2);

fprintf('Mean age for adult is %.3f, Std %.3f, with %d males, and %d females', adultAge, adultStd, adultM, adultF);
fprintf('\n');
fprintf('Mean age for 6-year-olds is %.3f, Std %.3f, with %d males, and %d females',sixAge, sixStd, sixM, sixF);
fprintf('\n');
fprintf('Mean age for 4-year-olds is %.3f, Std %.3f, with %d males, and %d females', fourAge, fourStd, fourM, fourF);




