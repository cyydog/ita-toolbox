function res = ita_preferences_sfc(varargin)

% <ITA-Toolbox>
% This file is part of the application SoundFieldClassification for the ITA-Toolbox. All rights reserved.
% You can find the license for this m-file in the application folder.
% </ITA-Toolbox>


if nargin < 1
    if nargout == 0 % Show GUI
        ita_preferences_gui_tabs(eval(mfilename), {mfilename}, true);
    else
        res = { 'SFC_Settings','ita_preferences_sfc','simple_button','App: Sound Field Classification','',4;...
            'SFC_AudioFolder','','path','Folder to AudioFiles','Path to Examples',0;...
            'SFC_MediaDBFolder','','path','MediaDB Folder','Path to your MediaDB Folder',0;...
            'SFC_sensorspacing',0.012,'double','Default sensor distance','',0;...
            'SFC_blocksize',1024,'int','Blocksize for SFC','',0;...
            'SFC_overlap',0.5,'double','Overlap for SFC','',0;...
            'SFC_window', 'hann', 'char','Window for SFC','',0;...
            'SFC_freqrange',[100 10000],'int','Frequency Range','Use this frequency range for evaluation of bandfilters, etc.',0;...
            'SFC_bandsperoctave',3,'popup_double','Bands per Octave','Bandwidth for fractional octave band filters.[1|3|12|24]',0;...
            'SFC_channels',[1 2],'int','Channels to evaluate (must be 2)','',0;...
            'SFC_audiobuffersize',3,'int','Audio Buffer size in #pages','',0;...
            'SFC_tc',1,'double','Time Constant for exponential average','',0;...
            'SFC_freqdependentsfc',true,'bool','Frequency dependent definition of basic sound fields','',0; ...
            };
    end
else
    res = ita_preferences(varargin{:});
end