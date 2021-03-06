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

function [LimXY, LimStr] = FindMaxMin
%%
GlobalVariables;
load('OUTPUT.mat');
%%
MaxDispX = 0;
MinDispX = 0;
MaxDispY = 0;
MinDispY = 0;

MaxStrXX = 0;
MinStrXX = 0;
MaxStrYY = 0;
MinStrYY = 0;
MaxStrXY = 0;
MinStrXY = 0;

for TB=1:NumberOfValidSteps

    eval(sprintf('Disp = Disp%d;',TB));
    eval(sprintf('Stress = Stress%d;',TB));
    eval(sprintf('Strain = Strain%d;',TB));
    eval(sprintf('IntTraDisp = IntTraDisp%d;',TB));
    %----------------------------------------------------------------------
    MaxDispX_0 = max(Disp(:,2));
    MinDispX_0 = min(Disp(:,2));
    MaxDispY_0 = max(Disp(:,3));
    MinDispY_0 = min(Disp(:,3));

    MaxStrXX_0 = max(Stress(:,2));
    MinStrXX_0 = min(Stress(:,2));
    MaxStrYY_0 = max(Stress(:,3));
    MinStrYY_0 = min(Stress(:,3));
    MaxStrXY_0 = max(Stress(:,4));
    MinStrXY_0 = min(Stress(:,4));

    if MaxDispX < MaxDispX_0;   MaxDispX = MaxDispX_0; end
    if MinDispX > MinDispX_0;   MinDispX = MinDispX_0; end
    if MaxDispY < MaxDispY_0;   MaxDispY = MaxDispY_0; end
    if MinDispY > MinDispY_0;   MinDispY = MinDispY_0; end

    if MaxStrXX < MaxStrXX_0;   MaxStrXX = MaxStrXX_0; end
    if MinStrXX > MinStrXX_0;   MinStrXX = MinStrXX_0; end
    if MaxStrYY < MaxStrYY_0;   MaxStrYY = MaxStrYY_0; end
    if MinStrYY > MinStrYY_0;   MinStrYY = MinStrYY_0; end
    if MaxStrXY < MaxStrXY_0;   MaxStrXY = MaxStrXY_0; end
    if MinStrXY > MinStrXY_0;   MinStrXY = MinStrXY_0; end  
    
end

MaxDefoX = max(Coo(:,2)) + MaxDispX;
MinDefoX = min(Coo(:,2)) + MinDispX;
MaxDefoY = max(Coo(:,3)) + MaxDispY;
MinDefoY = min(Coo(:,3)) + MinDispY;

%--------------------------------------------------------------------------
LimXY =[MinDefoX, MaxDefoX;
        MinDefoY, MaxDefoY];
    
LimStr=[MinStrXX, MaxStrXX;
        MinStrYY, MaxStrYY;
        MinStrXY, MaxStrXY]; 

end
