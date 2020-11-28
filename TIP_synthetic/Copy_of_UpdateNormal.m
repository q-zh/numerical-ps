function n=UpdateNormal(I,LT,n_pre,para)
NL=n_pre*LT;
NL=max(NL,0);
theta1=acos(NL);
r_ls=(sum(NL.*I,2)./sum(NL.*NL,2));
for i=1:para.iter_num_r
    
    
    theta2=acos(min(1,I./r_ls));
    a=cos(theta2);
    b=sin(theta1);
    c=theta1-theta2;
    
    F=b./(abs(c.*a)+1e-10);
    if sum(F,2)==0
        rt=r_ls;
    else
        F=F.^2;
        rt=(sum(F.*NL.*I,2)./sum(F.*NL.*NL,2));
    end
    
    if abs(sum((r_ls-rt).^2))<1e-10
        break;
    end
    r_ls=rt;
end

%%
if para.isLamber==0
    [residual, A, r_biqua] = buildPolyHD(n_pre, (LT)', I);
    r_ls=r_biqua';
end

albedo=r_ls.*ones(size(I));
theta2=acos(min(1,I./albedo));

a=cos(theta2);
b=sin(theta1);
c=theta1-theta2;

F=b./(abs(c.*a)+1e-10);

S_I=I./albedo.*F;
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
