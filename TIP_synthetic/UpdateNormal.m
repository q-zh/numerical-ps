function n=UpdateNormal(I,LT,n_pre,para,r_ls1)
NL=n_pre*LT;
%NL=max(NL,0);
%theta1=acos(NL);
%r_ls=(sum(NL.*I,2)./sum(NL.*NL,2));


a=NL;%cos(theta1);
b=sqrt(1-NL.^2);%sin(theta1);



v=[0,0,1];
%r_spec=CTBRDF(n_pre,LT,v);

%tI=(I-r_spec.*NL);
%r_ls=(sum(NL.*tI,2)./sum(NL.*NL,2));
%albedo=r_spec+r_ls;

%r_spec=(I-r_ls.*max(NL,1e-10))./(max(NL,1e-10));

%F=1./((r_spec));
%F=1./(abs(r_spec)+1e-10);
%F=(1+a.^2).*b.*b./(abs(a.*a.*I.*(b).*(r_spec.*1e-1+1))+1e-10);%.*(r_spec.*0+1)
%F=1./(abs(I.*I.*(sqrt(max(0,albedo.^2-I.^2))))+1e-10);

%F=sqrt((a+1)/2).*a./((abs((I.*b)))+1e-10);%.*(r_spec.*0+1)

%F_lamber=1./(abs(a.^2.*b)+1e-10);

mean_spec=1;
R=rotationVectorToMatrix(pi/60*n_pre);
t_pre=R*n_pre';
t_pre=t_pre';
 r_spec1=CTBRDF(n_pre,LT,v);
r_spec=zeros(10,size(NL,2));
for i=1:10
    angle=pi/180*i*36;
    R=rotationVectorToMatrix(angle*n_pre);
    r_pre=R*t_pre';
    r_pre=r_pre';
    r_spec(i,:)=CTBRDF(r_pre,LT,v);
end
r_1=1./sqrt(2*pi);
r_2=r_1*exp(-sin(pi/60)/2);
mean_spec=abs(sum(r_spec).*r_2+r_spec1*r_1)+1e-2;

%mean_spec=r_spec1+1e-2;
F_spec=b./(abs(a.*I.*mean_spec.*b)+1e-10);




F=F_spec;


S_I=I.*F;
L_P=LT.*repmat(F,[3,1]);

S_I(isnan(S_I))=0;
S_I(isinf(S_I))=0;

%%
if sum(sum(isinf(L_P)))~=0 || sum(sum(isnan(L_P)))~=0
    S_p=n_pre;
else
    S_p=S_I*pinv(L_P);
end

len= sqrt(sum(S_p.^2));
S = (S_p / len);

if sum(isnan(S))>0
    n=n_pre;
else
    n=S;
end

end
