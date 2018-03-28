function [ data, samplerate, metadata ] = dfAKtools( alpha, beta, config )
%DFAKTOOLS Summary of this function goes here
%   Retrieves data from FABIAN via AKtools using AKhrirInterpolation
%   routine for azimuth, elevation and head-above-torso orientation

% First two channels are always neutral hato position (for backwards
% compatibility)
% Define range angle vector with neutral direction as first entry
assert( config.hatorange( 1 ) <= 0 && config.hatorange( 2 ) >= 0 )
hato_negative_range = config.hatorange( 1 ):config.hatores:-config.hatores;
hato_positive_range = config.hatores:config.hatores:config.hatorange( 2 );
hato = [ 0 hato_negative_range hato_positive_range ];

data = zeros( config.numchannels, config.numsamples );

for n = 1:(config.numchannels/2)
    
    [ l, r ] = AKhrirInterpolation( alpha + hato( n ), beta - 90, hato( n ) );
    
    % Interleave for DAFF (odd = left, even = right)
    data( 2*n-1, : ) = l';
    data( 2*n, : ) = r';
    
end

samplerate = config.samplerate;
metadata = daffv17_add_metadata( [], 'AKhrirInterpolation_hato_parameter', 'STRING', num2str( hato ) );

end

