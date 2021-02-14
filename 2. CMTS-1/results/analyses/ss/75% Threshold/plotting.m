function [h]=plotting(result,a,b)

age={result{2:end,3}};
pure={result{2:end,a}};
pure=cell2mat(pure);
mix={result{2:end,b}};
mix=cell2mat(mix);

age=cell2mat(age);
young=age==4;
old=age==6;
adult=age==20;
figure(1)
h=figure(1);
set(h, 'Position', [100 100 800 600])
set(gcf, 'Color', 'w');
set(gca,'FontSize',12);
age=[4,6];
plot(age(1),mean(pure(young)),'ro-',age(2),mean(pure(old)), 'r*-',age(1),mean(mix(young)),'go-',age(2),mean(mix(old)),'g*-');
xlim([3,7]);
ylim([0,4]);
name={'4-a','6-a','4-b','6-b'};
legend(name);
end