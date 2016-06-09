function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 21-Apr-2016 05:17:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I_crop
fid = fopen('output.txt','w');
fclose(fid);

[filename, pathname] = uigetfile({'*.png';'*.jpeg';'*.jpg';'*.fig';'*.gif'},'File Selector');
axes(handles.axes1);
cd(pathname); I = rgb2gray(imread(filename));
imshow(I);
h = imrect;
api = iptgetapi(h);
I_crop = (imcrop(I,floor(api.getPosition())-1));
%testI = imresize(I_crop,[10 NaN]);


% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testBinI I_crop re

testBWI = I_crop;
testBinI = im2bw(testBWI);
axes(handles.axes2);
imshow(I_crop);

Ifill = imfill(testBinI,'holes');
Ifill = Ifill & I_crop;
re = imcomplement(Ifill);

axes(handles.axes3);
imagesc(testBinI);
set(handles.extract,'Enable','on');

% --- Executes on button press in train.
function train_Callback(hObject, eventdata, handles)
% hObject    handle to train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Main_ImgRead
set(handles.load,'Enable','on');
set(handles.crop,'Enable','on');

% --- Executes on button press in extract.
function extract_Callback(hObject, eventdata, handles)
% hObject    handle to extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global re
while 1
    [fl, re]=lines(re);
    imgn = fl;
    [L, Ne] = bwlabel(imgn);
    set(handles.trn,'string',strcat(num2str(Ne),' Characters'));
    axes(handles.axes3);
    for n=1:Ne
        [r,c] = find(L==n);
        n1 = (imgn(min(r):max(r),min(c):max(c)));
        BW2 = imcomplement(bwmorph((n1),'thin',1));
        imshow(BW2);
        z=imresize(BW2,[50, 50]);
        z=feature_extract(z);
        featureout = z;
        save ('featureout.mat','featureout');
        load('option.mat')
        test(s)
        pause(0.5);
    end
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end
end
 
set(handles.Detect,'Enable','on');
% --- Executes on button press in Detect.
function Detect_Callback(hObject, eventdata, handles)
% hObject    handle to Detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fname = 'output.txt';
txt = textread(fname,'%s');
set(handles.edit1,'string',txt);



function trn_Callback(hObject, eventdata, handles)
% hObject    handle to trn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trn as text
%        str2double(get(hObject,'String')) returns contents of trn as a double


% --- Executes during object creation, after setting all properties.
function trn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
