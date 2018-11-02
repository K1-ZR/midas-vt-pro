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

function Start_MIDAS

clc
clear
clear global
close all

if exist('OUTPUT.mat','file')
    delete('OUTPUT.mat')
    Keyvan='Keyvan';
    save('OUTPUT.mat','Keyvan')
else
    Keyvan='Keyvan';
    save('OUTPUT.mat','Keyvan')
end

% File = fullfile(cd, 'fp_database.mat');
% save(File,'data');
% delete(File);
% disp(exist(File, 'file'))
% ===============================================
GUI_MIDAS;
end
