function GK = GussianKernal( r1, r2 )

ler1=size(r1,1);
ler2=size(r2,1);
GK=ones(ler1,ler2);

for j=2:ler2
    for i = 1:ler1 
    GK(i,j)=exp(-(r1(i)-r2(j))^2);
    end
end
 
end
