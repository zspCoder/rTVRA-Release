function f = RTfuntwist_DualCamera(y,C,cameraResponseCurve)

n1 = size(C,1);
n2 = size(C,2);
m = size(C,3);

y1=y(1:n1,:,:);
y1 = repmat(y1,[1,1,m]);       
f1 = y1.*C;

for i=1:m
    f1(:,:,i)=circshift(f1(:,:,i),[i-1,0]);
end
f1 =f1(m:end,:,:);

% IntensityScale=2;

y2=y(n1+1:end,:,:);
f2=repmat(y2,[1,1,m]);

for i=1:m
   f2(:,:,i)=f2(:,:,i)*cameraResponseCurve(i); 
end

f=f1+f2;