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

function PlotAve
GlobalVariables;

Average = load('AVERAGE.OUT');
% 1    2           2           3           3           4           5
% Time AveStrainXX AveStressXX AveStrainYY AveStressYY AveStrainXY AveStressXY
axis_tag = {'Time',
            'Average Strain-XX', 
            'Average Stress-XX', 
            'Average Strain-YY', 
            'Average Stress-YY', 
            'Average Strain-XY', 
            'Average Stress-XY'};

figure(10);
hold on
plot(Average(:,plotGraph_XAxisIndex), Average(:,plotGraph_YAxisIndex));
% title('')
xlabel(axis_tag{plotGraph_XAxisIndex});
ylabel(axis_tag{plotGraph_YAxisIndex});
axis([min(Average(:,plotGraph_XAxisIndex)) max(Average(:,plotGraph_XAxisIndex))...
      min(Average(:,plotGraph_YAxisIndex)) max(Average(:,plotGraph_YAxisIndex))]);
hold off
end
