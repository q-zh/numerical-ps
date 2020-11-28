function [r_cook_torrance,  G,  D,  F]=CTBRDF(N, LT, v)
alpha=2;
n=0.5;


V=repmat(v',[1,size(LT,2)]);
H=(V+LT)/2;
H=H./repmat((sqrt(sum(H.*H,1))),[3,1]);

NH=N*H;
NV=N*V;
VH=v*H;
NL=N*LT;
HL=sum(H.*LT);

NH_2=NH.^2;
NH_4=NH_2.^2;


m=sqrt(2./(alpha+2));
m_2=m.^2;

D1=(NH_2-1)./(m_2.*NH_2);
D2=pi.*m_2.*NH_4;
D=exp(D1)./D2;

f0=(1-n).^2./((1+n).^2);


%F=((g-c)./(g+c)).^2./2.*(1+(((g+c).*c-1)./((g-c).*c+1)).^2);
F=f0+(1-f0).*((1-VH).^5);

G0=[2.*NH.*NL./VH;2.*NH.*(NV)./VH];
G=min(1,min(G0,[],1));

r_cook_torrance=D.*F.*G./NL./NV./4;
end