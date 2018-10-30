function varargout = GUI_LinearElastic(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_LinearElastic_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_LinearElastic_OutputFcn, ...
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

function GUI_LinearElastic_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = GUI_LinearElastic_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% =========================================================================
function pushbutton2_Callback(hObject, eventdata, handles)
GlobalVariables;
% Read Linear Elastic Properties
ElasticModulus(MatSet(MatIndex),1) = str2num( get(handles.edit1,'string') );
EPoissonRatio(MatSet(MatIndex),1)  = str2num( get(handles.edit2,'string') );

close(GUI_LinearElastic);

function pushbutton1_Callback(hObject, eventdata, handles)
close(GUI_LinearElastic);
             
             
     


















             
             
