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

% MAIN
Bar = waitbar(0,'Loading ...','Name','MIDAS',...
                'CreateCancelBtn',...
                'setappdata(gcbf,''canceling'',1)');
setappdata(Bar,'canceling',0)
%
% =========================================================================
% PLOTING AFTER EACH TIME BLOCK

% making video file
if StressContourIndex == 2
    VideoNmae = 'SigXX field.avi';
    HeaderName = 'SigXX field';
elseif StressContourIndex == 3
    VideoNmae = 'SigYY field.avi';
    HeaderName = 'SigYY field';
elseif StressContourIndex == 4
    VideoNmae = 'SigXY field.avi';
    HeaderName = 'SigXY field';
end

if StressContourIndex >= 2
        % video
        VidObj = VideoWriter(VideoNmae);
        VidObj.Quality = 100;
        VidObj.FrameRate = FramePerSec;
        open(VidObj)
        % figure
        
        figure(2);
        set(figure(2), 'Position', [10 10 FrameDim(1) FrameDim(1)]);
end
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
for TB=1:StepJump:NumberOfValidSteps
    
    % Check for Cancel button press
    if getappdata(Bar,'canceling')
        delete(Bar)
        break
    end
    
    eval(sprintf('Disp = Disp%d;',TB)); 
    eval(sprintf('Stress = Stress%d;',TB));
    eval(sprintf('IntTraDisp = IntTraDisp%d;',TB));
    
    New_Coo(:,2) = Coo(:,2)+ Disp(:,2);
    New_Coo(:,3) = Coo(:,3)+ Disp(:,3);
    Component = Stress(:,StressContourIndex-1+1);
    % ---------------------------------------------------------------------
    % Plot after each iteration    
    PlotFieldonMesh(New_Coo,Con,Component, IntTraDisp);
    title({HeaderName; sprintf('Time = %8.4f s',TB * TIMESTEP)}) ;
    
    Frame = getframe(figure(2));
    writeVideo(VidObj,Frame);
    cla(figure(2));
    % ---------------------------------------------------------------------
    waitbar( TB/NumTimeStep, Bar, sprintf('Creating Movie ...') ); 
    % ---------------------------------------------------------------------
    clear( sprintf('Disp = Disp%d;',TB) );
    clear( sprintf('Stress = Stress%d;',TB) );
    clear( sprintf('IntTraDisp = IntTraDisp%d;',TB) );
end

close(figure(2));
delete(Bar);
msgbox('Operation Completed','Success');
end