clc;
clear;
Ntrain = 200;     %训练集样本数
Ntest = 500;    %测试集样本数
[x,t] = data(Ntrain);  %生成训练数据集
f =  GussianKernal(x,x);  %生成高斯核函数

m=size(f,2);
alpha=rand(1,m);
beta=rand();    %初始化学习参数

for ep = 1:3000
A = diag(alpha);
F = pinv(beta*f'*f+A);
u = beta*F*f'*t;
gamma = 1-alpha.*diag(F)';   %更新参数
alpha_old=alpha;
beta_old=beta;

index=abs(alpha)<1e3; 
alpha(index)=gamma(index)./(u(index)'.^2);
beta=(Ntrain-sum(gamma))/((t-f*u)'*(t-f*u));%将数值小于1000的列标去除，只更新此部分

err=max(abs(alpha(index)-alpha_old(index))./abs(alpha(index)))+abs(beta-beta_old)/abs(beta);
    if err<0.1
        break;
    end %判断如果满足收敛条件，停止迭代
end

tpre=f(:,index)*u(index);  %计算预测数据集

figure(1);
plot(x,t,'r+');
hold on;
plot(x,tpre,'b*');
hold on;
plot(x(index(2:end)),t(index(2:end)),'ko'); %分别绘制原始数据、预测数据和相关向量

title('Testing Data1');
xlabel('x');
ylabel('t');
legend('训练数据','预测数据','相关向量');%标注

[xte,tte]=data(Ntest);%生成500个测试数据集
ftest =  GussianKernal(xte,x);%生成关联矩阵
ttepre=ftest(:,index)*u(index);%预测
figure(2)
plot(xte,tte,'.');
hold on;
plot(xte,ttepre,'+');
hold on;
plot(x(index(2:end)),t(index(2:end)),'ko');%分别绘制原始数据、预测数据和关联向量（由200个数据给出）

title('Testing Data2');
xlabel('x');
ylabel('t');
legend('训练数据','预测数据','相关向量');%标注
