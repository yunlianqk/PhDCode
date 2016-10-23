function [beta2]=L1gpsr(X,y,lambda,Winit);

TailleDic=size(X,2);
tau=lambda;
debias = 0;
stopCri = 5;
tolA = 0.01;
Z=[X -X];
if nargin < 4
    Winit=1;
else
    if isempty(Winit)
        Winit=1;
    else
        Winit=[Winit.*(Winit>0);-Winit.*(Winit<0)]; 
    end;
end;
[beta2,theta_debias_QP_BB_mono,obj_QP_BB_mono,...
    times_QP_BB_mono,debias_start,mses]= ...
    GPSR_BB(y,Z,tau,...
    'Debias',debias,...
    'Monotone',1,...
    'Initialization',Winit,...
    'StopCriterion',stopCri,...
    'ToleranceA',tolA,...
    'ToleranceD',0.00001,...
    'Verbose',0);
beta2=beta2(1:TailleDic) - beta2(TailleDic+1:2*TailleDic);