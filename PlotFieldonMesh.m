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

function PlotFieldonMesh(New_Coo, Con, Component, IntTraDisp)
GlobalVariables;
hold off
axis equal
axis manual
axis([LimXY(1,:) LimXY(2,:)]);

X1=[];Y1=[];X2=[];Y2=[];
Profile1=[];Profile2=[];
EE1=1;EE2=1;
for EE=1:size(Con,1)
    
    if Con(EE,5)==1 % AGG
        X1(1:3,EE1)=[New_Coo(Con(EE,2),2); New_Coo(Con(EE,3),2); New_Coo(Con(EE,4),2)];
        Y1(1:3,EE1)=[New_Coo(Con(EE,2),3); New_Coo(Con(EE,3),3); New_Coo(Con(EE,4),3)];
        Profile1(1:3,EE1) = [Component(EE); Component(EE); Component(EE)];
        EE1 = EE1+1;
    else           % MATRIX
        X2(1:3,EE2)=[New_Coo(Con(EE,2),2); New_Coo(Con(EE,3),2);  New_Coo(Con(EE,4),2)];
        Y2(1:3,EE2)=[New_Coo(Con(EE,2),3); New_Coo(Con(EE,3),3);  New_Coo(Con(EE,4),3)];
        Profile2(1:3,EE2) = [Component(EE);  Component(EE);  Component(EE)];
        EE2 = EE2+1;
    end
end
hold on
fill(X1,Y1,Profile1,'EdgeColor','none');
fill(X2,Y2,Profile2);

% =========================================================================
% COH ELEMENTS
X1=[];Y1=[];
X2=[];Y2=[];
EE1=1;EE2=1;
for EE = 1 : 2 : size(IntTraDisp,1)-1
    
    if IntTraDisp(EE,3) ~= 1 % UNDAMAGED
        X1(1:4,EE1)=[New_Coo(IntTraDisp(EE  ,2),2); New_Coo(IntTraDisp(EE+1,2),2); New_Coo(IntTraDisp(EE+1,1),2); New_Coo(IntTraDisp(EE  ,1),2)];
        Y1(1:4,EE1)=[New_Coo(IntTraDisp(EE  ,2),3); New_Coo(IntTraDisp(EE+1,2),3); New_Coo(IntTraDisp(EE+1,1),3); New_Coo(IntTraDisp(EE  ,1),3)];
        EE1 = EE1+1;
    elseif IntTraDisp(EE,3) == 1  % DAMAGED          
        X2(1:4,EE2)=[New_Coo(IntTraDisp(EE  ,2),2); New_Coo(IntTraDisp(EE+1,2),2); New_Coo(IntTraDisp(EE+1,1),2); New_Coo(IntTraDisp(EE  ,1),2)];
        Y2(1:4,EE2)=[New_Coo(IntTraDisp(EE  ,2),3); New_Coo(IntTraDisp(EE+1,2),3); New_Coo(IntTraDisp(EE+1,1),3); New_Coo(IntTraDisp(EE  ,1),3)];
        EE2 = EE2+1;
    end
end
fill(X1,Y1,'g','EdgeColor','none');   
fill(X2,Y2,'w','EdgeColor','none');

end
