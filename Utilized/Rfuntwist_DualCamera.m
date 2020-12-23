function y = Rfuntwist_DualCamera(f,C,cameraResponseCurve)

n1 = size(C,1);
n2 = size(C,2);
m = size(C,3);

zerom   =zeros(m-1,n2,m);
f1         = [zerom;f];
for i=1:m
    f1(:,:,i)=circshift(f1(:,:,i),[-(i-1),0]);
end

%captured in the calibration cube that is passed in to the function as C.
y1 = f1.*C;
y1=sum(y1,3);
% IntensityScale=2;

f2=zeros(size(f));
for i=1:m
    f2(:,:,i)=f(:,:,i)*cameraResponseCurve(i);%
end
y2=sum(f2,3);

%simulate 'smash' on the CCD
y = [y1;y2];