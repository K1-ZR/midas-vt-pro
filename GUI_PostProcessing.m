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

set( handles.pushbutton4 , 'Enable', 'off');

set( handles.edit1, 'Enable', 'off');
set( handles.edit2, 'Enable', 'off');
set( handles.edit3, 'Enable', 'off');

[LimXY, LimStress] = FindMaxMin;
RecomLim = zeros(3,2);
Keyvan=2;

% =========================================================================
% Graph
function popupmenu2_Callback(hObject, eventdata, handles)
set( handles.pushbutton4 , 'Enable', 'on');

function pushbutton4_Callback(hObject, eventdata, handles)
if get( handles.popupmenu2, 'Value')== 2
    PlotAve;
end

% =========================================================================
% Contour
function popupmenu1_Callback(hObject, eventdata, handles)
GlobalVariables;
set( handles.edit1, 'Enable', 'on');
StressContourIndex = get( handles.popupmenu1, 'Value'); % 1:11  2:22  3:12


function edit1_Callback(hObject, eventdata, handles)
GlobalVariables;
NumSpec  = str2num( get(handles.edit1,'string') );

RecomLim = StressDistribution(StressContourIndex-1, LimStress(StressContourIndex-1,:), NumSpec, 20);

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

function pushbutton3_Callback(hObject, eventdata, handles)
close(GUI_PostProcessing);