
function [R,Rs,Rp,phaseS,phaseP] =new_fresnel(n1,k1,n2,k2,theta)

MATH_DEG_TO_RAD = 3.141592631/180;

 p = sqrt(1/2*(sqrt((n2.^2-k2.^2-n1^2*sin(theta).^2).^2+4*n2.^2.*k2.^2)+(n2.^2-k2.^2-n1^2*sin(theta).^2)));
 q = sqrt(1/2*(sqrt((n2.^2-k2.^2-n1^2*sin(theta).^2).^2+4*n2.^2.*k2.^2)-(n2.^2-k2.^2-n1^2*sin(theta).^2)));
% 
 Rs = ((n1*cos(theta)-p).^2+q.^2)./((n1*cos(theta)+p).^2+q.^2);
 Rp = ((p-n1*sin(theta).*tan(theta)).^2+q.^2)./((p+n1*sin(theta).*tan(theta)).^2+q.^2).*Rs;
 
 rs=sqrt(Rs);
 rp=sqrt(Rp);
 
 R = (Rs+Rp)./2;

 
 
% for dielectric
brewsterAngle = atan( n2 / n1 );

phaseS = 180 * MATH_DEG_TO_RAD;

if theta < brewsterAngle
    phaseP = 0;
else
    phaseP = phaseS;
end


%a2=sqrt((n2*n2-k2*k2-sin(theta)*sin(theta))^2+4*n2^2*k2^2)+n2*n2-k2*k2-sin(theta)*sin(theta);
%a2=a2/2;
%b2=sqrt((n2*n2-k2*k2-sin(theta)*sin(theta))^2+4*n2^2*k2^2)-n2*n2+k2*k2+sin(theta)*sin(theta);
%b2=b2/2;

%a=sqrt(a2);
%b=sqrt(b2);

%rs=(a2+b2-2*a*cos(theta)+cos(theta)^2)/(a2+b2+2*a*cos(theta)+cos(theta)^2);
%rp=rs*(a2+b2-2*a*sin(theta)*tan(theta)+sin(theta)^2*tan(theta)^2)/(a2+b2+2*a*sin(theta)*tan(theta)+sin(theta)^2*tan(theta)^2);

%R=(rs^2+rp^2)/2;

end

