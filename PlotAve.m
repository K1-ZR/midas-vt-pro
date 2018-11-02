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
Average=load('AVERAGE.OUT');

%--------------------------------------------------------------------------
AverageX = Average(:,1:2);
figure(10);
hold on
plot(AverageX(:,1),AverageX(:,2));
% title('')
ylabel('Average Stress');
xlabel('Time');
axis([min(AverageX(:,1)) max(AverageX(:,1))...
      min(AverageX(:,2)) max(AverageX(:,2))]);
hold off
end
