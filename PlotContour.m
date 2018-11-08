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

function MakeVideo
GlobalVariables;
load('OUTPUT.mat');


%
% =========================================================================
% PLOTING AFTER EACH TIME BLOCK

% making video file
if plotContourIndex == 1
    HeaderName = 'SigXX field';
elseif plotContourIndex == 2
    HeaderName = 'SigYY field';
elseif plotContourIndex == 3
    HeaderName = 'SigXY field';
end

figure(1000);
% -------------------------------------------------------------------------
% making colorbar
jet(NumSpec);% Setting the values on colorbar
colormap(jet);
caxis(RecomLim);

kssv = linspace(RecomLim(1), RecomLim(2), NumSpec);
set(colorbar,'YtickMode','manual','YTick',kssv); % Set the tickmode to manual
for i = 1:NumSpec
    imep = num2str(kssv(i),'%+3.3E');
    vasu(i) = {imep} ;
end
set(colorbar,'YTickLabel',vasu(1:NumSpec),'fontsize',9);

% =========================================================================
TB = plotTargetStep;

eval(sprintf('Disp = Disp%d;',TB));
eval(sprintf('Stress = Stress%d;',TB));
eval(sprintf('IntTraDisp = IntTraDisp%d;',TB));

New_Coo(:,2) = Coo(:,2)+ Disp(:,2);
New_Coo(:,3) = Coo(:,3)+ Disp(:,3);
Component = Stress(:,plotContourIndex+1);
% .........................................................................
PlotFieldonMesh(New_Coo,Con,Component, IntTraDisp);
% below countourf would be a great alternative for the above function
% contourf(XCoor, YCoor, Component);
title({HeaderName; sprintf('Time = %8.4f s',TB * TIMESTEP)}) ;
% .........................................................................
clear( sprintf('Disp = Disp%d;',TB) );
clear( sprintf('Stress = Stress%d;',TB) );
clear( sprintf('IntTraDisp = IntTraDisp%d;',TB) );

end
