function ita_generate_documentation(varargin)
%ITA_GENERATE_DOCUMENTATION - Generate Toolbox Help
%  This function automatically generated the html help used for the Toolbox
%
%   See also help, doc, helpdesk, ita_toolbox_setup.
%
%   Reference page in Help browser
%        <a href="matlab:doc ita_generate_documentation">doc ita_generate_documentation</a>

% <ITA-Toolbox>
% This file is part of the application HTMLhelp for the ITA-Toolbox. All rights reserved.
% You can find the license for this m-file in the application folder.
% </ITA-Toolbox>

%
% Author: Pascal Dietrich -- Email: pdi@akustik.rwth-aachen.de
% Created:  17-Apr-2009
% Edited: 18-May-2012 Tumbr�gel


% pdi not for preferences
sArgs = struct('rootpath',ita_toolbox_path);
sArgs = ita_parse_arguments(sArgs,varargin);


%generate helpbrowser html files - Tumbr�gel 05/2012:
ita_generate_helpOverview(sArgs.rootpath); 

fullpath = sArgs.rootpath;
cd(fullpath)
disp(fullpath)
%% Get folders for m2html
ignoreList  = {'.svn','private','tmp','prop-base','props','text-base','template','doc','GuiCallbacks'};
pathStr = genpath(fullpath); %generates folderlist with ';' to seperate folders
prefixToolbox = fliplr(strtok(fliplr(fullpath),filesep)); %get Toolbox folder name

outpathStr  = [];
outpathList = [];
tokenIdx    = [0 findstr(pathStr,pathsep)];

if isunix
    separator = ':';
else
    separator = ';';
end

for idx=1:(length(tokenIdx)-1)
   tokenCell{idx} = pathStr(tokenIdx(idx)+1:tokenIdx(idx+1)-1); %get single folder name
   isIgnore = false;
   for ignIdx = 1:length(ignoreList)
       foundIdx     = findstr(tokenCell{idx},ignoreList{ignIdx}); %folder in ignore list?
       isIgnore     = ~isempty(foundIdx) || isIgnore;
    end
   if ~isIgnore %add string token
       outpathStr   = [outpathStr separator tokenCell{idx}]; %#ok<*AGROW>
       idxITA = findstr(tokenCell{idx},prefixToolbox); %pdi
       outpathList  = [outpathList; {tokenCell{idx}(idxITA:end)}]; %throw away 'C:\...' until ITA-TB path
   end  
end

% delete old one first
graphInst = ita_preferences('isGraphVizInstalled');
cd(fullpath)
cd ..

if ischar(graphInst), graphInst = str2double(graphInst); end;

%% ignorelist -- doc - guicallbacks - externalpackages

if graphInst
    graphState = 'on';
    disp('with GraphViz')
else
    graphState = 'off';
end
docFolder = [fullpath filesep 'HTML' filesep 'doc'];
tic
m2html('mfiles',outpathList, 'htmldir',docFolder, 'recursive','off', 'source','off', 'syntaxHighlighting','on', ...
    'global','on', 'globalHypertextLinks','on', 'todo','on', ...
    'verbose','on','template','blue', 'indexFile','index', 'graph',graphState);
toc

%% Build search database for helpdesk
if nargin == 0
    builddocsearchdb( [fullpath filesep 'HTML' ] ); %generate help search
    rehash toolboxcache
end
