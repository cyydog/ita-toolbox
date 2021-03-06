function ita_menucallback_Amplify(hObject, event)

% <ITA-Toolbox>
% This file is part of the ITA-Toolbox. Some rights reserved.
% You can find the license for this m-file in the license.txt file in the ITA-Toolbox folder.
% </ITA-Toolbox>

fgh        = ita_guisupport_getParentFigure(hObject);
audioObj = getappdata(fgh, 'audioObj');

ele = 1;
pList{ele}.description = 'itaAudio';
pList{ele}.helptext    = 'This is the itaAudio Object for amplification or attenuation';
pList{ele}.datatype    = 'itaAudioFix';
pList{ele}.default     = audioObj;

ele = 2;
pList{ele}.description = 'Factor';
pList{ele}.helptext    = 'Factor can be e.g. ''0dB'' or ''1+5j'' or ''20 Pa'' ' ;
pList{ele}.datatype    = 'char';
pList{ele}.default     = '0dB';


ele = 3;
pList{ele}.datatype    = 'line';

ele = 4;
pList{ele}.description = 'Result will be plotted and saved in current GUI figure'; %this text will be shown in the GUI
pList{ele}.helptext    = 'The result will be plotted and exported to your current GUI.';
pList{ele}.datatype    = 'text'; %based on this type a different row of elements has to drawn in the GUI

%call gui
pList = ita_parametric_GUI(pList,[mfilename ' - Amplify an itaAudio object']);
if ~isempty(pList)
    result = ita_amplify(pList{1},pList{2});
    setappdata(fgh, 'audioObj', result);
    ita_guisupport_updateGUI(fgh);
end
end