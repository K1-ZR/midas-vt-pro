%    MIDAS-VT-Pre Copyright (C) 2018  Keyvan Zare-Rami
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
