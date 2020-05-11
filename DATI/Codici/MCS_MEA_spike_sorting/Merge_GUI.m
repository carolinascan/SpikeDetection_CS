function varargout = Merge_GUI(varargin)
% MERGE_GUI MATLAB code for Merge_GUI.fig
%      MERGE_GUI, by itself, creates a new MERGE_GUI or raises the existing
%      singleton*.
%
%      H = MERGE_GUI returns the handle to a new MERGE_GUI or the handle to
%      the existing singleton*.
%
%      MERGE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MERGE_GUI.M with the given input arguments.
%
%      MERGE_GUI('Property','Value',...) creates a new MERGE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Merge_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Merge_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Merge_GUI

% Last Modified by GUIDE v2.5 31-Jul-2013 12:45:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;



gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Merge_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Merge_GUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Merge_GUI is made visible.
function Merge_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Merge_GUI (see VARARGIN)

% Choose default command line output for Merge_GUI
handles.output = hObject;
handles.startFolder = [];
handles.selectedFolders = [];

% -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
% startFolder = uigetdir(pwd,'Select the RawData_MAT folder (Filt or NotFilt) to process:');
% if strcmp(num2str(startFolder),'0')          % halting case
%     return
% end
% [expFolder,startFolderName] = fileparts(startFolder);
% [~,~,FoldersToMerge]=dirr(startFolder,'name','isdir','0');
% -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Merge_GUI wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Merge_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.startFolder;
varargout{3} = handles.selectedFolders;


% --- Executes on selection change in MergeListbox.
function MergeListbox_Callback(hObject, eventdata, handles)
% hObject    handle to MergeListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MergeListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MergeListbox


% --- Executes during object creation, after setting all properties.
function MergeListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MergeListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbuttonBrowse.
function pushbuttonBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.startFolder = uigetdir(pwd,'Select the PeakDetectionMAT folder (Filt or NotFilt) that contains the folders to merge:');

[~,handles.startFolderName] = fileparts(handles.startFolder);
[~,~,handles.FoldersToMerge] = dirr(handles.startFolder,'name','isdir','0');
handles.FoldersToMerge = handles.FoldersToMerge(cellfun(@isdir,handles.FoldersToMerge));
set(handles.editBrowse,'String',handles.startFolder);
set(handles.MergeListbox,'String',handles.FoldersToMerge);

% Update handles structure
guidata(hObject,handles);

function editBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to editBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBrowse as text
%        str2double(get(hObject,'String')) returns contents of editBrowse as a double


% --- Executes during object creation, after setting all properties.
function editBrowse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDo.
function pushbuttonDo_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedFolders=handles.FoldersToMerge(get(handles.MergeListbox,'Value'));
guidata(hObject,handles);
uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(handles.figure1);
delete(hObject);
