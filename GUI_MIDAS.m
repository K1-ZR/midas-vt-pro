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

function varargout = GUI_MIDAS(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_MIDAS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_MIDAS_OutputFcn, ...
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

function GUI_MIDAS_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% =========================================================================
% =========================================================================
% Initializing
function varargout = GUI_MIDAS_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

GlobalVariables;

set(handles.edit6, 'Enable', 'off');
set(handles.edit7, 'Enable', 'off');

set(handles.popupmenu6, 'Enable', 'off');
set(handles.popupmenu7, 'Enable', 'off');
set(handles.pushbutton2, 'Enable', 'off');

% =========================================================================
% =========================================================================
% Model Data
function pushbutton6_Callback(hObject, eventdata, handles)
GlobalVariables;
SetGlobal;

[FileName, FilePath] = uigetfile({'*.mat'},...
                                  'Select mesh data library');
load([FilePath, FileName]);
% .........................................................................
% if TestType == 2 || TestType == 3
%      msgbox( 'This test is not available currently' , 'Error' )
% end
% .........................................................................
DispMesh(Coo, Con, size(Con,1));
% .........................................................................
Con = Con(1:NumRegEl,:);
% .........................................................................
NumOfPhase = HeteroIndex + 1;
set(handles.edit6,'string',num2str(NumOfPhase));
TypeOfPhase = zeros(NumOfPhase,1);

if     NumOfPhase == 1
    set(handles.popupmenu3, 'String', {'               -','Matrix'});
elseif NumOfPhase == 2
    set(handles.popupmenu3, 'String', {'               -','Matrix','Particle'});
end
% =========================================================================
if isempty(IntEl)
    NumOfInterphase = 0;
else
    NumOfInterphase = max(IntEl(:, 3)); % 3, column shows itn el type
end
set(handles.edit7,'string',num2str(NumOfInterphase));
    
if NumOfInterphase == 1
    set(handles.popupmenu6, 'Enable', 'on');
    set(handles.popupmenu7, 'Enable', 'on');
    set(handles.pushbutton2, 'Enable', 'on');
    set(handles.popupmenu6, 'String', {'               -','Matrix-Matrix & Matrix-Particle'});
elseif NumOfInterphase == 2
    set(handles.popupmenu6, 'Enable', 'on');
    set(handles.popupmenu7, 'Enable', 'on');
    set(handles.pushbutton2, 'Enable', 'on');
    set(handles.popupmenu6, 'String', {'               -','Matrix-Matrix','Matrix-Particle'});
end
% =========================================================================
% =========================================================================
% Constitutive Behavior
function pushbutton1_Callback(hObject, eventdata, handles)
GlobalVariables;

MatIndex = get(handles.popupmenu3,'Value')-1;
BehIndex = get(handles.popupmenu4,'Value')-1;

MatType(MatIndex) = BehIndex; % 1:E 2:VE

if     BehIndex == 1
    MatSet(MatIndex) = sum(ismember(MatType,1));
    GUI_LinearElastic;
elseif BehIndex == 2
    MatSet(MatIndex) = sum(ismember(MatType,2));
    GUI_LinearViscoelastic;
end

% =========================================================================
% =========================================================================
% Fracture Properties
function pushbutton2_Callback(hObject, eventdata, handles)
GlobalVariables;
if NumOfInterphase ~= 0
    
    MatIndex = get(handles.popupmenu6,'Value')-1;
    BehIndex = get(handles.popupmenu7,'Value')-1;
    
    VECNo = MatIndex;
    
    if     BehIndex==1
        GUI_VECohesive;
    end
end
% =========================================================================
% =========================================================================
% RUN
function pushbutton3_Callback(hObject, eventdata, handles)
GlobalVariables;

TotalDisp   = str2num( get(handles.edit3,'string') );
TotalTime   = str2num( get(handles.edit4,'string') );
TimeIncr    = str2num( get(handles.edit5,'string') );
IncrDisp    = TotalDisp/(TotalTime/TimeIncr);

PlaneStress = get(handles.radiobutton1,'Value');
PlaneStrain = get(handles.radiobutton2,'Value');

ECount  = sum(ismember(MatType,1));
VECount = sum(ismember(MatType,2));
% -------------------------------------------------------------------------
GenerateInputFile;
%--------------------------------------------------------------------------
system(['cd ', '"', FilePath, '"']);
system('FESolver.exe');

% =========================================================================
% =========================================================================
% Post Processing
function pushbutton5_Callback(hObject, eventdata, handles)
LoadResult;
GUI_PostProcessing;
