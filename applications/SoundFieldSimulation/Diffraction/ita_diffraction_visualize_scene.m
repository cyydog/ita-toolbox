function ita_diffraction_visualize_scene( w, source_pos, target_pos )
%% ita_diffraction_visualize_scene Visualises a source-receiver-wedge scene
%
% Example: ita_diffraction_visualize_scene( wedge, source_pos, target_pos )
%

apx = w.get_aperture_point2( source_pos, target_pos );
d1 = norm( source_pos - apx );
d2 = norm( target_pos - apx );
d3 = norm( w.location - source_pos );
d4 = norm( w.location - target_pos );
face_scaling = max( [ d1 d2 d3 d4 ] );


%% Main wedge face

if isa( w, 'itaFiniteWedge' )
    
    p1 = w.aperture_start_point;
    p2 = w.aperture_end_point;
    
else

    p1 = w.location - face_scaling * w.aperture_direction;
    p2 = w.location + face_scaling * w.aperture_direction;
    v_aux = cross( w.main_face_normal, w.aperture_direction );
    p3 = v_aux * face_scaling + p2;
    p4 = v_aux * face_scaling + p1;

end

X = [ p1( 1 ); p2( 1 ); p3( 1 ); p4( 1 ) ];
Y = [ p1( 2 ); p2( 2 ); p3( 2 ); p4( 2 ) ];
Z = [ p1( 3 ); p2( 3 ); p3( 3 ); p4( 3 ) ];


%% Opposite wedge face

v_aux = -cross( w.opposite_face_normal, w.aperture_direction );
p3 = v_aux * face_scaling + p2;
p4 = v_aux * face_scaling + p1;

X2 = [ p1( 1 ); p2( 1 ); p3( 1 ); p4( 1 ) ];
Y2 = [ p1( 2 ); p2( 2 ); p3( 2 ); p4( 2 ) ];
Z2 = [ p1( 3 ); p2( 3 ); p3( 3 ); p4( 3 ) ];


%% Solid-part boundary

if strcmpi( w.edge_type, 'corner' ) || strcmpi( w.edge_type, 'inner_wedge' )
    
    v_aux = cross( w.main_face_normal, w.aperture_direction );
    p3 = v_aux * face_scaling / 2 + p1;
    v_aux = -cross( w.opposite_face_normal, w.aperture_direction );
    p4 = v_aux * face_scaling / 2 + p1;
    p5 = ( -1 ) * face_scaling * ( w.main_face_normal + w.opposite_face_normal ) / 2 + p1;

    X4 = [ p1( 1 ); p3( 1 ); p4( 1 ); p5( 1 ) ];
    Y4 = [ p1( 2 ); p3( 2 ); p4( 2 ); p5( 2 ) ];
    Z4 = [ p1( 3 ); p3( 3 ); p4( 3 ); p5( 3 ) ];

    v_aux = cross( w.main_face_normal, w.aperture_direction );
    p3 = v_aux * face_scaling / 2 + p2;
    v_aux = -cross( w.opposite_face_normal, w.aperture_direction );
    p4 = v_aux * face_scaling / 2 + p2;
    p5 = ( -1 ) * face_scaling * ( w.main_face_normal + w.opposite_face_normal ) / 2 + p2;

    X4 = [ X4, [ p2( 1 ); p3( 1 ); p4( 1 ); p5( 1 ) ] ];
    Y4 = [ Y4, [ p2( 2 ); p3( 2 ); p4( 2 ); p5( 2 ) ] ];
    Z4 = [ Z4, [ p2( 3 ); p3( 3 ); p4( 3 ); p5( 3 ) ] ];
    
else
    
    v_aux = cross( w.main_face_normal, w.aperture_direction );
    p3 = v_aux * face_scaling / 2 + p1;
    v_aux = -cross( w.opposite_face_normal, w.aperture_direction );
    p4 = v_aux * face_scaling / 2 + p1;

    X4 = [ p1( 1 ); p3( 1 ); p4( 1 ) ];
    Y4 = [ p1( 2 ); p3( 2 ); p4( 2 ) ];
    Z4 = [ p1( 3 ); p3( 3 ); p4( 3 ) ];

    v_aux = cross( w.main_face_normal, w.aperture_direction );
    p3 = v_aux * face_scaling / 2 + p2;
    v_aux = -cross( w.opposite_face_normal, w.aperture_direction );
    p4 = v_aux * face_scaling / 2 + p2;

    X4 = [ X4, [ p2( 1 ); p3( 1 ); p4( 1 ) ] ];
    Y4 = [ Y4, [ p2( 2 ); p3( 2 ); p4( 2 ) ] ];
    Z4 = [ Z4, [ p2( 3 ); p3( 3 ); p4( 3 ) ] ];
    
end

%% Aperture point

X3 = [ source_pos( 1 ); apx( 1 ); target_pos( 1 ) ];
Y3 = [ source_pos( 2 ); apx( 2 ); target_pos( 2 ) ];
Z3 = [ source_pos( 3 ); apx( 3 ); target_pos( 3 ) ];


%% Polygon 3D plot

fill3( X, Y, Z, 'red', X2, Y2, Z2, 'yellow', X3, Y3, Z3, 'green', X4, Y4, Z4, 'blue' )


end
