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
             
             
     


















             
             
