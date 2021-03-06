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

function varargout = GUI_PostProcessing(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_PostProcessing_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_PostProcessing_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function GUI_PostProcessing_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% =========================================================================
% Initializing
function varargout = GUI_PostProcessing_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% -------------------------------------------------------------------------
GlobalVariables;

set( handles.edit1, 'Enable', 'off');
set( handles.edit2, 'Enable', 'off');
set( handles.edit3, 'Enable', 'off');

set( handles.edit15, 'Enable', 'off');
set( handles.edit16, 'Enable', 'off');
set( handles.edit17, 'Enable', 'off');

[LimXY, LimStress] = FindMaxMin;
RecomLim = zeros(3,2);
Keyvan=2;

% =========================================================================
% Graph
function pushbutton4_Callback(hObject, eventdata, handles)
GlobalVariables;

plotGraph_XAxisIndex = get(handles.popupmenu2,'Value')-1;
plotGraph_YAxisIndex = get(handles.popupmenu3,'Value')-1;

if ( get( handles.popupmenu2, 'Value') == 1 || ...
     get( handles.popupmenu3, 'Value') == 1)
 
  msgbox({'Please select X and Y axis values.'});
  
else
    PlotAve;
end

% =========================================================================
% Contour - Video
function popupmenu1_Callback(hObject, eventdata, handles)
GlobalVariables;
set( handles.edit1, 'Enable', 'on');
StressContourIndex = get( handles.popupmenu1, 'Value'); % 1:11  2:22  3:12


function edit1_Callback(hObject, eventdata, handles)
GlobalVariables;
NumSpec  = str2num( get(handles.edit1,'string') );

RecomLim = StressDistribution(StressContourIndex-1, LimStress(StressContourIndex-1,:), NumSpec, 10);

set( handles.edit2, 'Enable', 'on');    set(handles.edit2,'String',num2str(RecomLim(1)));
set( handles.edit3, 'Enable', 'on');    set(handles.edit3,'String',num2str(RecomLim(2)));

function pushbutton2_Callback(hObject, eventdata, handles)
GlobalVariables;

FrameDim(1)  = str2num( get(handles.edit5,'string') );
FrameDim(2)  = str2num( get(handles.edit6,'string') );
StepJump    = str2num( get(handles.edit4,'string') );
FramePerSec = str2num( get(handles.edit14,'string') );

if StressContourIndex >= 2
    MakeVideo;
end
% =========================================================================
% Contour - Plot
% select the stress
function popupmenu4_Callback(hObject, eventdata, handles)
GlobalVariables;
set( handles.edit15, 'Enable', 'on');
plotContourIndex = get( handles.popupmenu4, 'Value') - 1; % 1:11  2:22  3:12
% give number of levels in contour
function edit15_Callback(hObject, eventdata, handles)
GlobalVariables;
NumSpec  = str2num( get(handles.edit15,'string') );

RecomLim = StressDistribution(plotContourIndex, LimStress(plotContourIndex,:), NumSpec, 10);

set( handles.edit16, 'Enable', 'on');    set(handles.edit16,'String',num2str(RecomLim(1)));
set( handles.edit17, 'Enable', 'on');    set(handles.edit17,'String',num2str(RecomLim(2)));
% plot
function pushbutton5_Callback(hObject, eventdata, handles)
GlobalVariables;

plotTargetStep = str2num( get(handles.edit18,'string') );

if plotContourIndex >= 1
    PlotContour;
end

% =========================================================================
function pushbutton3_Callback(hObject, eventdata, handles)
close(GUI_PostProcessing);


