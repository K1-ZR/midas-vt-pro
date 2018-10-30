function varargout = GUI_LinearViscoelastic(varargin)
%%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_LinearViscoelastic_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_LinearViscoelastic_OutputFcn, ...
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

function GUI_LinearViscoelastic_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% =========================================================================
% Initialization
function varargout = GUI_LinearViscoelastic_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

A=cell(11,2);
A(1,1)={'7020000 '};    A(1,2)={'               -            '};
A(2,1)={'245648430'};    A(2,2)={'0.00003'};
A(3,1)={'422264070'};    A(3,2)={'0.0003'};
A(4,1)={'399318930'};    A(4,2)={'0.003'};
A(5,1)={'251827650'};    A(5,2)={'0.03'};
A(6,1)={'69096874 '};    A(6,2)={'0.3'};
A(7,1)={'22585797 '};    A(7,2)={'3'};
A(8,1)={'7816581  '};    A(8,2)={'30'};
A(9,1)={'3459600  '};    A(9,2)={'300'};
set(handles.uitable1,'Data', A);
% =========================================================================
function pushbutton2_Callback(hObject, eventdata, handles)
GlobalVariables;
VENo = MatSet(MatIndex);

VENumPronySeries(VENo) = str2num( get(handles.edit1,'string') );

VEPronySeriesTable  = get(handles.uitable1,'data');
VEPronySeriesInf(VENo) = str2num( VEPronySeriesTable{1,1} );
VEPronySeries{VENo}  = cellfun(@str2num, VEPronySeriesTable( 2:VENumPronySeries(VENo)+1,: ) );

VEPoissonRatio(VENo) = str2num( get(handles.edit2,'string') );

close(GUI_LinearViscoelastic);

function pushbutton1_Callback(hObject, eventdata, handles)
close(GUI_LinearViscoelastic);
