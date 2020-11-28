function RGB = lookup_brdf_val(BRDF, theta_i, phi_i, theta_v, phi_v)
%Function for interpolation of BRDF value (9/2014, J. Filip, UTIA AV CR)
%  INPUTS: 
%   BRDF - BRDF image as 3D array (rows,colums,RGB planes)
%   theta_i - vector of illum. elevations
%   phi_i   - vector of illum. azimuths
%   theta_v - vector of view elevations
%   phi_v   - vector of view azimuths
%  OUTPUT:
%   RGB - matrix consisting [R,G,B] vectors of interpolated BRDf values

theta_i(theta_i>0.5*pi,:) = 0.5*pi;% clamping range of elev > pi/2 to pi/2
theta_v(theta_v>0.5*pi,:) = 0.5*pi;

step_t = 15;%15.0;
step_p = 9;%7.5;
nti = 6;
ntv = 6;
npi = 360.0/step_p;
npv = npi;
planes = 3;
RGB = zeros(size(theta_i,1),3);

d2r = 180.0/pi;
theta_i = theta_i*d2r;
theta_v = theta_v*d2r;
phi_i = phi_i*d2r;
phi_v = phi_v*d2r;
if(phi_i>=360.0) phi_i = 0.0; end
if(phi_v>=360.0) phi_v = 0.0; end

iti = cell(2);
itv = cell(2);
ipi = cell(2);
ipv = cell(2);
iti{1} = floor(theta_i/step_t);
iti{2} = iti{1}+1;
iti{1}(iti{1}>nti-2) = nti-2;
iti{2}(iti{1}>nti-2) = nti-1;

itv{1} = floor(theta_v/step_t);
itv{2} = itv{1}+1;
itv{1}(itv{1}>ntv-2) = ntv-2;
itv{2}(itv{1}>ntv-2) = ntv-1;

ipi{1} = floor(phi_i/step_p);
ipi{2} = ipi{1}+1;
ipv{1} = floor(phi_v/step_p);
ipv{2} = ipv{1}+1;

wti = cell(2);
wtv = cell(2);
wpi = cell(2);
wpv = cell(2);
wti{2} = theta_i - step_t*iti{1};
wti{1} = step_t*iti{2} - theta_i;
sum = wti{1}+wti{2};
wti{1} = wti{1}./sum;
wti{2} = wti{2}./sum;
wtv{2} = theta_v - step_t*itv{1};
wtv{1} = step_t*itv{2} - theta_v;
sum = wtv{1}+wtv{2};
wtv{1} = wtv{1}./sum;
wtv{2} = wtv{2}./sum;

wpi{2} = phi_i - step_p*ipi{1};
wpi{1} = step_p*ipi{2} - phi_i;
sum = wpi{1}+wpi{2};
wpi{1} = wpi{1}./sum;
wpi{2} = wpi{2}./sum;
wpv{2} = phi_v - step_p*ipv{1};
wpv{1} = step_p*ipv{2} - phi_v;
sum = wpv{1}+wpv{2};
wpv{1} = wpv{1}./sum;
wpv{2} = wpv{2}./sum;

ipi{2}(ipi{2}==npi) = 0;
ipv{2}(ipv{2}==npv) = 0;

for j=1:3
    BRDFr(:,j) = reshape(BRDF(:,:,j),288*288,1);
end
for isp=1:planes
    RGB(:,isp) = 0.0;
    for i=1:2
        for j=1:2
            for k=1:2
                for l=1:2
                    ni = npi*iti{i}+ipi{k};
                    nv = npv*itv{j}+ipv{l};
                    RGB(:,isp) = RGB(:,isp) + BRDFr(nv*288+ni+1,isp) .* wti{i} .* wtv{j} .* wpi{k} .* wpv{l};
                end
            end
        end
    end
end

