function    [RecomLim_i] = StressDistribution(TargetStress, LimitStress, NSpectrum, Threshold)
GlobalVariables;
load('OUTPUT.mat');
MessageHandle = msgbox('Wait until program finds the recommended contour values.','Wait'); 
NumTimeStep = round(NumTimeStep);
%%
NSpectrum = 4 * NSpectrum;

MinStr = LimitStress(1);
MaxStr = LimitStress(2);

Spec = MinStr : (MaxStr-MinStr)/NSpectrum : MaxStr;

N=zeros(NumTimeStep,NSpectrum);
for TB=1:NumTimeStep
    
    eval(sprintf('Stress = Stress%d;',TB));

    for EE=1:size(Stress,1)
        for SS=1:NSpectrum
            if (Spec(SS) <= Stress(EE,TargetStress+1)) &&  ...
                           (Stress(EE,TargetStress+1) < Spec(SS+1))
                N(TB,SS) = N(TB,SS)+1; 
            end
        end
    end
end
N = sum(N,1) / (NumTimeStep*size(Stress,1)) *100;

Index = [];
while isempty(Index)
Index = find( N >= Threshold );
Threshold = Threshold/2;
end
% RecomLim_i = [round(Spec(Index(1)),-1)      round(Spec(Index(end)+1),-1)];
RecomLim_i = [Spec(Index(1))     Spec(Index(end)+1)];
BoundValue= max(abs(Spec(Index(1))),abs(Spec(Index(end)+1)));
RecomLim_i =[-BoundValue, BoundValue];
delete(MessageHandle);
end