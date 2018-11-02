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

function varargout = GUI_VECohesive(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_VECohesive_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_VECohesive_OutputFcn, ...
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

function GUI_VECohesive_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
% =========================================================================
% Initialization
function varargout = GUI_VECohesive_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

A=cell(11,2);
A(1,1)={'1400'};      A(1,2)={'              -       '};
A(2,1)={'56058696'};  A(2,2)={'0.0014'};
A(3,1)={'11814777'};  A(3,2)={'0.014'};
A(4,1)={'2314771 '};  A(4,2)={'0.14'};
A(5,1)={'269841  '};  A(5,2)={'1.4'};
A(6,1)={'33929   '};  A(6,2)={'14'};

set(handles.uitable2,'Data', A);

set(handles.edit15, 'Enable', 'off');
set(handles.edit16, 'Enable', 'off');
set(handles.edit17, 'Enable', 'off');

set(handles.text18, 'Enable', 'off');
set(handles.text19, 'Enable', 'off');
set(handles.text20, 'Enable', 'off');

set(handles.edit18, 'Enable', 'off');
set(handles.edit19, 'Enable', 'off');
set(handles.edit20, 'Enable', 'off');
set(handles.edit21, 'Enable', 'off');

set(handles.text21, 'Enable', 'off');
set(handles.text22, 'Enable', 'off');
set(handles.text23, 'Enable', 'off');
set(handles.text24, 'Enable', 'off');
% =========================================================================
% Damage evolution
function popupmenu2_Callback(hObject, eventdata, handles)
GlobalVariables;
DamageModel(VECNo) = get(handles.popupmenu2,'Value')-1;
if DamageModel(VECNo)==1 % Power 
    set(handles.edit15, 'Enable', 'on');
    set(handles.edit16, 'Enable', 'on');
    set(handles.edit17, 'Enable', 'on');
    
    set(handles.text18, 'Enable', 'on');
    set(handles.text19, 'Enable', 'on');
    set(handles.text20, 'Enable', 'on');
    
    set(handles.edit18, 'Enable', 'off');
    set(handles.edit19, 'Enable', 'off');
    set(handles.edit20, 'Enable', 'off');
    set(handles.edit21, 'Enable', 'off');
    
    set(handles.text21, 'Enable', 'off');
    set(handles.text22, 'Enable', 'off');
    set(handles.text23, 'Enable', 'off');
    set(handles.text24, 'Enable', 'off');
    
elseif DamageModel(VECNo)==2 % Gaussian
    set(handles.edit15, 'Enable', 'off');
    set(handles.edit16, 'Enable', 'off');
    set(handles.edit17, 'Enable', 'off');
    
    set(handles.text18, 'Enable', 'off');
    set(handles.text19, 'Enable', 'off');
    set(handles.text20, 'Enable', 'off');
    
    set(handles.edit18, 'Enable', 'on');
    set(handles.edit19, 'Enable', 'on');
    set(handles.edit20, 'Enable', 'on');
    set(handles.edit21, 'Enable', 'on');
    
    set(handles.text21, 'Enable', 'on');
    set(handles.text22, 'Enable', 'on');
    set(handles.text23, 'Enable', 'on');
    set(handles.text24, 'Enable', 'on');
end

% =========================================================================
% =========================================================================
function pushbutton2_Callback(hObject, eventdata, handles)
    GlobalVariables;
    
    VECZNumPronySeries(VECNo) = str2num( get(handles.edit10,'string') );

    VECZPronySeriesTable    = get(handles.uitable2,'data');
    VECZPronySeriesInf(VECNo) = str2num( VECZPronySeriesTable{ 1,1 } );
    VECZPronySeries{VECNo}    = cellfun(@str2num, VECZPronySeriesTable( 2:VECZNumPronySeries(VECNo)+1 ,: ) );

    SigmaN(VECNo) = str2num( get(handles.edit11,'string') );
    SigmaT(VECNo) = str2num( get(handles.edit12,'string') );
    DeltaN(VECNo) = str2num( get(handles.edit13,'string') );
    DeltaT(VECNo) = str2num( get(handles.edit14,'string') );
    
    DamageModel(VECNo) = get(handles.popupmenu2,'Value')-1;
    
    if DamageModel(VECNo)==1 % Power
        PLc(VECNo) = str2num( get(handles.edit15,'string') );
        PLm(VECNo) = str2num( get(handles.edit16,'string') );
        PLn(VECNo) = str2num( get(handles.edit17,'string') );
    elseif DamageModel(VECNo)==2  % Gaussian   
        ConA(VECNo)         = str2num( get(handles.edit18,'string') );
        ConM(VECNo)         = str2num( get(handles.edit19,'string') );
        ConLambdabar(VECNo) = str2num( get(handles.edit20,'string') );
        ConDelta(VECNo)     = str2num( get(handles.edit21,'string') );
    end

    close(GUI_VECohesive);

function pushbutton3_Callback(hObject, eventdata, handles)
    close(GUI_VECohesive);
