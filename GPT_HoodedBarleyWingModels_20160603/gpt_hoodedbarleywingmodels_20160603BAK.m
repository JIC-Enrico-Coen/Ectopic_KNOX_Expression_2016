function m = gpt_hoodedbarleywingmodels_20160603( m )
%m = gpt_hoodedbarleywingmodels_20160603( m )
%   Morphogen interaction function.
%   Written at 2016-06-14 11:11:19.
%   GFtbox revision 5427, 2016-04-26 11:10.

% The user may edit any part of this function between delimiters
% of the form "USER CODE..." and "END OF USER CODE...".  The
% delimiters themselves must not be moved, edited, deleted, or added.

    if isempty(m), return; end

    fprintf( 1, '%s found in %s\n', mfilename(), which(mfilename()) );

    try
        m = local_setproperties( m );
    catch
    end

    setGlobals();
    realtime = m.globalDynamicProps.currenttime;
    dt = m.globalProps.timestep;

%%% USER CODE: INITIALISATION

% In this section you may modify the mesh in any way whatsoever.
    if (Steps(m)==0) && m.globalDynamicProps.doinit % First iteration
        % Zero out a lot of stuff to create a blank slate.  
        % If no morphogens are set in the GUI it may be useful to
        % zero some arrays by uncommenting the following.
        % m.morphogens(:) = 0;
        % m.morphogenclamp(:) = 0;
        % m.mgen_production(:) = 0;
        % m.mgen_absorption(:) = 0;
        % m.seams(:) = false;
        % m.mgen_dilution(:) = false;

        % Set up names for variant models.  Useful for running multiple models on a cluster.
        m.userdata.ranges.modelname.range = { 'FINAL', 'WT' , 'POLARITY', 'GROWTH', 'WING', 'BKN3'};  % CLUSTER
        m.userdata.ranges.modelname.index = 6;                       % CLUSTER
    end
    modelname = m.userdata.ranges.modelname.range{m.userdata.ranges.modelname.index};  % CLUSTER
    disp(sprintf('\nRunning %s model %s\n',mfilename, modelname));
    switch modelname
        case 'MODEL1'
            % Set up the parameters (e.g. mutations) for this model here.
        case 'MODEL2'
            % Set up the parameters (e.g. mutations) for this model here.
        otherwise
            % If you reach here, you probably forgot a case.
    end
    	
    % More examples of code for all iterations.

    % Set priorities for simultaneous plotting of multiple morphogens, if desired.
    % m = leaf_mgen_plotpriority( m, {'MGEN1', 'MGEN2'}, [1,2], [0.5,0.75] );

    % Set colour of polariser gradient arrows.
    % m = leaf_plotoptions(m,'highgradcolor',[0,0,0],'lowgradcolor',[1,0,0]);

    % setup a multiplot of the following morphogens
    % m = leaf_plotoptions( m, 'morphogen', {'V_PROFILE1','V_PROFILE2','KAPAR','S_LEFTRIGHT'});

    % to plot polariser on the A side and resultant areal growth rate on the B side:
    % m = leaf_plotoptions( m, 'morphogenA', 'POLARISER', ...
    %                      'outputquantityB', 'resultantgrowthrate', ...
    %                      'outputaxesB', 'areal' );

    % monitor properties of vertices must be done here - so that it reports newly equilibrated levels
    % m=leaf_profile_monitor(m,... % essential
    %         'REGIONLABELS',{'V_PROFILE1','V_PROFILE2'},... % essential
    %         'MORPHOGENS',{'S_LEFTRIGHT','S_CENTRE'},... % optional  (one element per REGIONLABEL)
    %         'VERTLABELS',false,'FigNum',1,'EXCEL',true,'MODELNAME',modelname); % optional (file in snapshots directory')
%%% END OF USER CODE: INITIALISATION

%%% SECTION 1: ACCESSING MORPHOGENS AND TIME.
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.

    polariser_i = FindMorphogenRole( m, 'POLARISER' );
    P = m.morphogens(:,polariser_i);
    [kapar_i,kapar_p,kapar_a,kapar_l] = getMgenLevels( m, 'KAPAR' );
    [kaper_i,kaper_p,kaper_a,kaper_l] = getMgenLevels( m, 'KAPER' );
    [kbpar_i,kbpar_p,kbpar_a,kbpar_l] = getMgenLevels( m, 'KBPAR' );
    [kbper_i,kbper_p,kbper_a,kbper_l] = getMgenLevels( m, 'KBPER' );
    [knor_i,knor_p,knor_a,knor_l] = getMgenLevels( m, 'KNOR' );
    [strainret_i,strainret_p,strainret_a,strainret_l] = getMgenLevels( m, 'STRAINRET' );
    [arrest_i,arrest_p,arrest_a,arrest_l] = getMgenLevels( m, 'ARREST' );
    [id_minus_i,id_minus_p,id_minus_a,id_minus_l] = getMgenLevels( m, 'ID_MINUS' );
    [id_plus_i,id_plus_p,id_plus_a,id_plus_l] = getMgenLevels( m, 'ID_PLUS' );
    [id_base_i,id_base_p,id_base_a,id_base_l] = getMgenLevels( m, 'ID_BASE' );
    [id_edge_i,id_edge_p,id_edge_a,id_edge_l] = getMgenLevels( m, 'ID_EDGE' );
    [id_tip_i,id_tip_p,id_tip_a,id_tip_l] = getMgenLevels( m, 'ID_TIP' );
    [id_dissect_i,id_dissect_p,id_dissect_a,id_dissect_l] = getMgenLevels( m, 'ID_DISSECT' );
    [id_wingtip_i,id_wingtip_p,id_wingtip_a,id_wingtip_l] = getMgenLevels( m, 'ID_WINGTIP' );
    [id_centre_i,id_centre_p,id_centre_a,id_centre_l] = getMgenLevels( m, 'ID_CENTRE' );
    [s_dissect_i,s_dissect_p,s_dissect_a,s_dissect_l] = getMgenLevels( m, 'S_DISSECT' );
    [s_wing_i,s_wing_p,s_wing_a,s_wing_l] = getMgenLevels( m, 'S_WING' );
    [s_tip_i,s_tip_p,s_tip_a,s_tip_l] = getMgenLevels( m, 'S_TIP' );
    [s_bkn3_i,s_bkn3_p,s_bkn3_a,s_bkn3_l] = getMgenLevels( m, 'S_BKN3' );
    [id_boundary_i,id_boundary_p,id_boundary_a,id_boundary_l] = getMgenLevels( m, 'ID_BOUNDARY' );
    [id_wing_i,id_wing_p,id_wing_a,id_wing_l] = getMgenLevels( m, 'ID_WING' );
    [s_promote_i,s_promote_p,s_promote_a,s_promote_l] = getMgenLevels( m, 'S_PROMOTE' );
    [id_plusorg_i,id_plusorg_p,id_plusorg_a,id_plusorg_l] = getMgenLevels( m, 'ID_PLUSORG' );
    [id_minusorg_i,id_minusorg_p,id_minusorg_a,id_minusorg_l] = getMgenLevels( m, 'ID_MINUSORG' );
    [s_pgrad_i,s_pgrad_p,s_pgrad_a,s_pgrad_l] = getMgenLevels( m, 'S_PGRAD' );
    [id_stripe_i,id_stripe_p,id_stripe_a,id_stripe_l] = getMgenLevels( m, 'ID_STRIPE' );

% Mesh type: semicircle
%            asym: 0
%       circumpts: 0
%         dealign: 0
%          height: 0
%        innerpts: 0
%      randomness: 0
%           rings: 10
%         version: 1
%          xwidth: 0.15
%          ywidth: 0.1

%            Morphogen    Diffusion   Decay   Dilution   Mutant
%            --------------------------------------------------
%                KAPAR         ----    ----       ----     ----
%                KAPER         ----    ----       ----     ----
%                KBPAR         ----    ----       ----     ----
%                KBPER         ----    ----       ----     ----
%                 KNOR         ----    ----       ----     ----
%            POLARISER        0.001     0.1       ----     ----
%            STRAINRET         ----    ----       ----     ----
%               ARREST         ----    ----       ----     ----
%             ID_MINUS         ----    ----       ----     ----
%              ID_PLUS         ----    ----       ----     ----
%              ID_BASE         ----    ----       ----     ----
%              ID_EDGE         ----    ----       ----     ----
%               ID_TIP         ----    ----       ----     ----
%           ID_DISSECT         ----    ----       ----     ----
%           ID_WINGTIP         ----    ----       ----     ----
%            ID_CENTRE         ----    ----       ----     ----
%            S_DISSECT        1e-05     0.1       ----     ----
%               S_WING        0.001     0.1       ----     ----
%                S_TIP        1e-06     0.1       ----     ----
%               S_BKN3        0.001     0.1       ----     ----
%          ID_BOUNDARY         ----    ----       ----     ----
%              ID_WING         ----    ----       ----     ----
%            S_PROMOTE        0.001     0.1       ----     ----
%           ID_PLUSORG         ----    ----       ----     ----
%          ID_MINUSORG         ----    ----       ----     ----
%              S_PGRAD        0.001     0.1       ----     ----
%            ID_STRIPE         ----    ----       ----     ----


%%% USER CODE: MORPHOGEN INTERACTIONS

% In this section you may modify the mesh in any way that does not
% alter the set of nodes.

%% 


    if (Steps(m)==0) && m.globalDynamicProps.doinit  % Initialisation code.
        
%Set up location of id factors

%Set up iEDGE, which defines the outer edge of the lemma
        
        m= leaf_mgen_edge (m,'ID_EDGE', 1);
        id_edge_p = m.morphogens (:, id_edge_i);
        
%Set up iPLUSORG, used to set up the poalrity field
        id_plusorg_p =  (m.nodes (:,2) < 0.001).* id_edge_p;
        
%Set up iBASE, used to define the base of the lemma
        id_base_p =  (m.nodes (:,2) < 0.001).* id_edge_p;

%Set up iTIP, used to define the distal tip of the lemma, used to set up
%the location of iMINUSORG
        id_tip_p =   (m.nodes (:,1) > -0.005).*(m.nodes (:,1)<0.005).*(m.nodes (:,2)> 0.049) .* id_edge_p;  

% Set up iCENTRE, used to produce sBKN3, circular region in the middle of
% the distal end of the lemma
               CENTRE_RADIUS = 0.003;
               CENTRE_POSITION = [ 0, 0.03 ]; % the x, y co-ordinates of the position of the centre (due to its displacement from 0,0).
               radii = sqrt( (m.nodes(:,1) - CENTRE_POSITION(1)).^2 + ...  % the x and y co-ordinates of the new centre point are subtracted from the x and y co-ordinates of the m.nodes positions used in the radii calculation  
                      (m.nodes(:,2) - CENTRE_POSITION(2)).^2 );
               id_centre_p(radii <= CENTRE_RADIUS) = 1;
               id_centre_l = id_centre_p * id_centre_a;
        
% Set up iWING, used to define sDISSECT        
         id_wing_p = ((m.nodes (:,1)<= -0.055).*(m.nodes (:,2) >= 0.015).*(m.nodes (:,2) <= 0.022).*id_edge_p)|...
                    ((m.nodes (:,1)>= 0.055).*(m.nodes (:,2) >= 0.015).*(m.nodes (:,2) <= 0.022).*id_edge_p);
                
        
%Fix the base to simulate the attachment to the base of the flower
   m = leaf_fix_vertex( m, 'vertex', find(id_base_p==1), 'dfs', 'yz' );     
    

    end
    
   
 % Define the gradient of sDISSECT, used to introduce more finite elements
 % in specific areas

if (realtime >= -50.0) &&(realtime <-50.0+dt); 
         s_dissect_p = id_wing_p + id_centre_p + id_base_p; % sDISSECT is produced at iWING, iCENTRE and iBASE
         m = leaf_mgen_conductivity( m, s_dissect_i, 0.00001 );  %specifies the diffusion rate of sDISSECT
         m = leaf_mgen_absorption( m, s_dissect_i, 0.1 ); %specifies the degradation rate of sDISSECT
         m.morphogenclamp( ((id_wing_p==1)|(id_centre_p==1)| id_base_p), s_dissect_i ) = 1; % fixes the level of sDISSECT at iWING, iCENTRE, iBASE
 
%Define sTIP gradient, used to define the distrbution of iMINUSORG

         s_tip_p = id_tip_p; % sTIP is produced at iTIP
         m = leaf_mgen_conductivity( m, s_tip_i, 0.000001 ); % specifies the diffusion rate of sTIP  
         m = leaf_mgen_absorption( m, s_tip_i, 0.1 );    % specifies the degradation rate of sTIP
         m.morphogenclamp( ((id_tip_p==1)), s_tip_i ) = 1;   %fixes the level of sTIP at iTIP   

%Define sPGRAD gradient, used to promote growth in the base of the lemma

         s_pgrad_p = id_base_p - s_tip_l; % sPGRAD is produced at iBASE and removed by sTIP
         m = leaf_mgen_conductivity( m, s_pgrad_i, 0.001 );  %specifies the diffusion rate of sPGRAD 
         m = leaf_mgen_absorption( m, s_pgrad_i, 0.1 );    %specifies the degradation rate of sPGRAD
         m.morphogenclamp( ((id_base_p==1)| (id_tip_p==1)), s_pgrad_i ) = 1;   % fixes the level of sGRAD at iBASE and iTIP  
end

%Define the location of iMINUSORG and the production of sDISSECT

if (realtime >= -30.0) &&(realtime <-30.0+dt);
   id_dissect_p = (s_dissect_l >= 0.3);% sDISSECT is produced where iDISSECT is
   id_minusorg_p = s_tip_p;% iMINUSORG is defined by the gradient of sTIP
end
 
%Define gradient of POLARISER (POL) used to define the polarity field form
%which kper and kpar are oriented

 if (realtime >= -10.0) && (realtime < -10.0+dt);
         P=id_plusorg_p; % POL is produced at iPLUSORG
         m = leaf_mgen_conductivity( m, 'POLARISER', 0.0001 );  %specifies the diffusion rate of POL    
         m = leaf_mgen_absorption( m, 'POLARISER', 0.1 ); %specifies the degradation rate of POL
         m.morphogenclamp( ((id_plusorg_p==1)), polariser_i ) = 1;% fixes the level of POL at iPLUSORG
 end  

 %% 
 
 
% Code for specific models.
    switch modelname
        case 'FINAL'  % Full hooded lemma model
% Initial growth rates 
if realtime >= 0;
                 kapar_p(:) = 0.011.*pro(0.6, s_pgrad_l)...
                                   .* inh(1.2, id_minusorg_l);  % Kpar is promoted by sPGRAD and inhibited by iMINUSORG
                 kaper_p(:) = 0.005;   % uniform kper
                 kbpar_p(:) = kapar_p;  
                 kbper_p(:) = kaper_p;  % 
                 knor_p(:)  = 0.01;  % uniform Knor
end

% Activate sBKN3 in the middle of the lemma
 
  if (realtime >= 110) && (realtime < 110+dt);
          s_bkn3_p = id_centre_p;  % sBKN3 is produced where iCENTRE is
          m = leaf_mgen_conductivity( m, s_bkn3_i, 0.001 );  % defines conductivity of sBKN3
          m = leaf_mgen_absorption( m, s_bkn3_i, 0.1 );    % defines degradartion rate of sBKN3
          m.morphogenclamp( ((id_centre_p==1)), s_bkn3_i ) = 1; %fixes the value of sBKN3 where iCENTRE is
  end
  
% Freeze gradient of sBKN3 
  if realtime >= 116;
         m = leaf_mgen_conductivity( m, s_bkn3_p, 0 );     
         m = leaf_mgen_absorption( m, s_bkn3_p, 0 );  
  end
  
% Reorganise polarity, making the middle of the sBKN3 region a new minus
% organiser (centre of the new meristem)
            
 if (realtime >= 120)&& (realtime < 120+dt);
          
           P= id_plusorg_p - 0.001*(s_bkn3_l > 0.4);% POL is produced at iPLUSORG and removed at sBKN3
           m = leaf_mgen_conductivity( m, 'POLARISER', 0.001 );      
           m = leaf_mgen_absorption( m, 'POLARISER', 0.1 );
           m.morphogenclamp( ((id_plusorg_p==1)), polariser_i ) = 0;
           m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 1; % fixes the value of POL at iPLUSORG, iMINUSORG and where sBKN3 is high              
 end

% Introduce effect of sBKN3 on growth rates, promote growth in region of
% meristem
          
if realtime >=125 ;         
     
                  kapar_p(:) = 0.012.*pro(0.01, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l)...
                                    .* pro(0.01,(s_bkn3_l>=0.2));  % Kpar is promoted by sPGRAD and by high levels of sBKN3, inhibited by iMINUSORG
                  kaper_p(:) = 0.006.*pro(1, (s_bkn3_l>=0.2))....
                                    .*pro(1.5,s_pgrad_l);  %  Kper is promoted by sPGRAD and by high levels of sBKN3
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.01;  % Knor is constant
end

% Introduce iBOUNDARY proximally to the sBKN3 region

if (realtime >= 150) &&(realtime <150+dt);
   id_boundary_p = ((s_bkn3_l <0.3) & (s_bkn3_l >0.2)) .* (m.nodes (:,2) <= 0.3); %location of iBOUNDARY 
end        

% Activate iBOUNDARY as a plus organiser and reorganise polarity

if (realtime >= 164) && (realtime < 164+dt);
     P= id_plusorg_p + id_boundary_p ; % POL is produced at iPLUSORG and iBOUNDARY
     m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 0; % ends old clamp
     m.morphogenclamp (((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4) | (id_boundary_p ==1)), polariser_i ) =1;% new clamp fixes POL levels a iPLUSORG, iMINUSORG, iBOUNDARY and where sBKN3 is high
    
end

% Remove the effect of sBKN3 on growth
if realtime >=170 ;
     
                  kapar_p(:) = 0.011.*pro(1.3, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l);%
                  kaper_p(:) = 0.002.*pro(5,s_pgrad_l);  % 
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

% Introduce iWINGTIP which produces sWING at the WING tip (convergence
% point of polarity)
if (realtime >= 238) && (realtime < 238+dt);
    id_wingtip_p = ((m.nodes (:,2) >= 0.47).*(m.nodes (:,2) <= 0.52).*id_edge_p); %location of iWINGTIP
    s_wing_p = id_wingtip_p; % sWING is produced at iWINGTIP
    m = leaf_mgen_conductivity( m, s_wing_p, 0.008 );  %specifies the diffusion rate of sWING    
    m = leaf_mgen_absorption( m, s_wing_p, 0.00001 );  %specified the degradation rate of sWING
    m.morphogenclamp( (id_wingtip_p==1), s_wing_i ) = 1; % fixes the level of sWING at iWINGTIP
    
end

% The effect of sWING on growth 
if realtime >=240 ;
     
                  kapar_p(:) = 0.0019.*pro(1, s_pgrad_l)...
                                     .* inh(1, id_minusorg_l)...
                                     .*pro(30, (s_wing_l )) ...
                                     .* inh(10, s_wing_l > 0.65);% Kpar is promoted by sGRAD, sWING and inhibited by iMINUSORG and where sWING is high (at the wing tip).This stops the wings becoming sharp
                  kaper_p(:) = 0.0006 .*pro(5,s_pgrad_l);  % Kper is promoted by sPGRAD 
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end
%Fix the gradient of sWING
if realtime >= 242;
           m = leaf_mgen_conductivity( m, s_wing_p, 0 );
           m = leaf_mgen_absorption( m, s_wing_p, 0 );
end

%% 



        case 'WT'  % wild-type lemma model, the same model as for Hooded with effects of sBKN3 and sWING removed
            
if realtime >= 0;

                 kapar_p(:) = 0.011.*pro(0.6, s_pgrad_l)...
                                   .* inh(1.2, id_minusorg_l);  % Kpar is promoted by sPGRAD and inhibited bu iMINUSORG
                 kaper_p(:) = 0.005;  % Kper is constant
                 kbpar_p(:) = kapar_p;  % 
                 kbper_p(:) = kaper_p;  % 
                 knor_p(:)  = 0.01;  % Knor is constant
 end           
            
if realtime >=125 ;         
     
                  kapar_p(:) = 0.012.*pro(0.01, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l);  % 
                  kaper_p(:) = 0.006.*pro(1.5,s_pgrad_l);  % Kper is promoted by sPGRAD
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.01;  % 
end

if realtime >=170 ;
     
                  kapar_p(:) = 0.011.*pro(1.3, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l);%
                  kaper_p(:) = 0.002.*pro(5,s_pgrad_l);  %
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

if realtime >=240 ;
     
                  kapar_p(:) = 0.0019.*pro(1, s_pgrad_l)...
                                     .* inh(1, id_minusorg_l);%
                  kaper_p(:) = 0.0006 .*pro(5,s_pgrad_l);  % 
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

% 
%% 

        case 'POLARITY'  % hooded lemma model with just a polarity inversion, no change in growth rates in the margins

if realtime >= 0;
                 
                 kapar_p(:) = 0.011.*pro(0.6, s_pgrad_l)...
                                    .* inh(1.2, id_minus_l);  % Kper is promoted by sPGRAD and inhibited by iMINUSORG
                 kaper_p(:) = 0.005;  % Kper is constant
                 kbpar_p(:) = kapar_p;  % 
                 kbper_p(:) = kaper_p;  % 
                 knor_p(:)  = 0.01;  % Knor is constant
end

% Activate sBKN3 in the middle of the lemma
 
if (realtime >= 110) && (realtime < 110+dt);
          s_bkn3_p = id_centre_p; % sBKN3 is produced at iCENTRE
          m = leaf_mgen_conductivity( m, s_bkn3_i, 0.001 );  %specifies the diffusion rate of sBKN3
          m = leaf_mgen_absorption( m, s_bkn3_i, 0.1 );  %specifies the degradation rate of sBKN3
          m.morphogenclamp( ((id_centre_p==1)), s_bkn3_i ) = 1; %fixes the level of sBKN3 at iCENTRE
end

% Freeze the gradient of sBKN3
  if realtime >= 116;
         m = leaf_mgen_conductivity( m, s_bkn3_p, 0 );     
         m = leaf_mgen_absorption( m, s_bkn3_p, 0 );  
  end

% Reorganise polarity, making the middle of the sBKN3 region a new minus
% organiser (centre of the new meristem)
            
 if (realtime >= 120)&& (realtime < 120+dt);
          
           P= id_plusorg_p - 0.001*(s_bkn3_l > 0.4);% POL is produced by iPLUSORG and removed where sBKN3 is high
           m = leaf_mgen_conductivity( m, 'POLARISER', 0.001 );  %specifies the diffusion rate of POL    
           m = leaf_mgen_absorption( m, 'POLARISER', 0.1 ); %specifies the degradation rate of POL
           m.morphogenclamp( ((id_plusorg_p==1)), polariser_i ) = 0; %cancels the old POL clamp
           m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 1;%fixes the level of POL at iPLUSORG, iMINUSORG and where sBKN3 is high            
 end

% Introduce the effect of sBKN3 on growth rates, promote growth in region of
% meristem
          
 if realtime >=125 ;         
     
                  kapar_p(:) = 0.012.*pro(0.01, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l)...
                                    .* pro(0.01,(s_bkn3_l>=0.2));  % Kpar is promoted by sPGRAD and where sBKN3 is high, and inhibted by iMINUSORG
                  kaper_p(:) = 0.006.*pro(1, (s_bkn3_l>=0.2))...
                                    .*pro(1.5,s_pgrad_l);  % Kper is promoted by sPGRAD and where sBKN3 is high
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.01;  % Knor is constant
end

% Introduce iBOUNDARY  proximally to the sBKN3 region

if (realtime >= 150) &&(realtime <150+dt);
   id_boundary_p = ((s_bkn3_l <0.3) & (s_bkn3_l >0.2)) .* (m.nodes (:,2) <= 0.3); % 
   
 end        

% Activate iBOUNDARY as a plus organiser and reorganise polarity

if (realtime >= 164) && (realtime < 164+dt);
     P= id_plusorg_p + id_boundary_p ;% POL is produced at iPLUSORG and iBOUNDARY
     m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 0; %cancels the old clamp
     m.morphogenclamp (((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4) | (id_boundary_p ==1)), polariser_i ) =1; %fixes the level pf POL at iPLUSORG, iMINUSORG, iBOUNDARY and where sBKN3 is high
    
end

% Remove the effect of sBKN3 on growth rates
if realtime >=170 ;
     
                  kapar_p(:) = 0.011.*pro(1.3, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l);%
                  kaper_p(:) = 0.002.*pro(5,s_pgrad_l);  % 
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end


if realtime >=240 ;
     
                  kapar_p(:) = 0.0019.*pro(1, s_pgrad_l)...
                                     .* inh(1, id_minusorg_l);%
                  kaper_p(:) = 0.0008 .*pro(5,s_pgrad_l);  % 
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

%% 


 case 'GROWTH' % The effect of enhancing growth rates in the lemma margin without a change in polarity orientation.

if realtime >= 0;
                 kapar_p(:) = 0.011.*pro(0.6, s_pgrad_l)...
                                   .* inh(1.2, id_minusorg_l);  % Kpar is promoted by sPGRAD and inhibiited by iMINUSORG
                 kaper_p(:) = 0.005;  % Kper is constant
                 kbpar_p(:) = kapar_p;  % 
                 kbper_p(:) = kaper_p;  % 
                 knor_p(:)  = 0.01;  % Knor is constant
end

% Activate sBKN3 in the middle of the lemma
 
  if (realtime >= 110) && (realtime < 110+dt);
          s_bkn3_p = id_centre_p; %sBKN3 is produced at iCENTRE
          m = leaf_mgen_conductivity( m, s_bkn3_i, 0.001 );  %specifies the diffusion rate of sBKN3
          m = leaf_mgen_absorption( m, s_bkn3_i, 0.1 ); %specifies the degradation rate of sBKN3
          m.morphogenclamp( ((id_centre_p==1)), s_bkn3_i ) = 1; % fixes the level of sBKN3 at iCENTRE
  end
  
% Freeze the gradient of sBKN3 
  if realtime >= 116;
         m = leaf_mgen_conductivity( m, s_bkn3_p, 0 );     
         m = leaf_mgen_absorption( m, s_bkn3_p, 0 );  
  end
  
% Reorganise polarity, making the middle of the BKn3 region a new minus
% organiser (centre of the new meristem)
            
 if (realtime >= 120)&& (realtime < 120+dt);
          
           P= id_plusorg_p - 0.001*(s_bkn3_l > 0.4);% POL is produced at iPLUSORG and removed weher sBKN3 is high
           m = leaf_mgen_conductivity( m, 'POLARISER', 0.001 );  %specifies the diffusion rate of POL    
           m = leaf_mgen_absorption( m, 'POLARISER', 0.1 );  %specifies the degradation rate of POL
           m.morphogenclamp( ((id_plusorg_p==1)), polariser_i ) = 0; %cancels the old clamp
           m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 1; %fixes the level of POL at iPLUSORG and iMINUSORG              
 end

% Introduce the effect of sBKN3 on growth rates, promotes growth in the region of
% meristem
          
if realtime >=125 ;         
     
                  kapar_p(:) = 0.012.*pro(0.01, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l)...
                                    .* pro(0.01,(s_bkn3_l>=0.2));  % Kpar is promoted by sPGRAD and weher sBKN3 is high, and inhibited by iMINUSORG
                  kaper_p(:) = 0.006.*pro(1, (s_bkn3_l>=0.2))...
                                    .*pro(1.5,s_pgrad_l);  % Kper is promoted by sPGRAD and where sBKN3 is high
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.01;  % 
end



% Remove the effect of sBKN3 on growth
if realtime >=170 ;
     
                  kapar_p(:) = 0.011.*pro(1.3, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l);% 
                  kaper_p(:) = 0.002.*pro(5,s_pgrad_l);  % 
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

% Introduce iWINGTIP which produces sWING at the tip of the wings (convergence
% point of the polarity field) This is defined independent of the polarity
% field (the position of iWINGTIP is approximately where the convergence
% point is)
if (realtime >= 238) && (realtime < 238+dt);
    id_wingtip_p = ((m.nodes (:,2) >= 0.47).*(m.nodes (:,2) <= 0.52).*id_edge_p);% defines where iWINGTIP is (convergence point of poalrity field)
    s_wing_p = id_wingtip_p; % sWING is produced by iWINGTIP
    m = leaf_mgen_conductivity( m, s_wing_p, 0.008 );  %specifies the diffusion rate of sWING    
    m = leaf_mgen_absorption( m, s_wing_p, 0.00001 ); %specifies the degradation rate of sWING
    m.morphogenclamp( (id_wingtip_p==1), s_wing_i ) = 1; %fixes the level of sWING at iWINGTIP
    
end

% The effect of sWING on growth (roughly isotropic effect- equally increase
% kper and kpar)
if realtime >=240 ;
     
                  kapar_p(:) = 0.0019.*pro(1, s_pgrad_l)...
                                     .* inh(1, id_minusorg_l)...
                                     .*pro(9.5, s_wing_l);% Kpar is promoted by sPGRAD and sWING and inhibited by iMINUSORG
                  kaper_p(:) = 0.0006 .*pro(5,s_pgrad_l)...
                                      .*pro(30, s_wing_l);  % Kper is promoted by sPGRAD and sWING
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

%Fix the gradient of sWING
if realtime >= 242;
           m = leaf_mgen_conductivity( m, s_wing_p, 0 );
           m = leaf_mgen_absorption( m, s_wing_p, 0 );
end

%% 

        case 'WING' % The final hooded lemma model with no inhibition of growth at the wing tip


if realtime >= 0;
                 kapar_p(:) = 0.011.*pro(0.6, s_pgrad_l)...
                                   .* inh(1.2, id_minusorg_l);  % Kpar is promoted by sPGRAD and inhibited by iMINUSORG
                 kaper_p(:) = 0.005;  % Kper is constant
                 kbpar_p(:) = kapar_p;  % 
                 kbper_p(:) = kaper_p;  % 
                 knor_p(:)  = 0.01;  % Knor is constant
end

% Activate sBKN3 in the middle of the lemma
 
  if (realtime >= 110) && (realtime < 110+dt);
          s_bkn3_p = id_centre_p; % sBKN3 is produced at iCENTRE
          m = leaf_mgen_conductivity( m, s_bkn3_i, 0.001 );  % specifies the diffusion rate of sBKN3
          m = leaf_mgen_absorption( m, s_bkn3_i, 0.1 );  % specifies the degradation rate of sBKN3
          m.morphogenclamp( ((id_centre_p==1)), s_bkn3_i ) = 1; %fixes the level of sBKN3 at iCENTRE
  end
  
% Freeze gradient of sBKN3 
  if realtime >= 116;
         m = leaf_mgen_conductivity( m, s_bkn3_p, 0 );     
         m = leaf_mgen_absorption( m, s_bkn3_p, 0 );  
  end
  
% Reorganise polarity, making the middle of the sBKN3 region a new minus
% organiser (centre of the new meristem)
            
 if (realtime >= 120)&& (realtime < 120+dt);
          
           P= id_plusorg_p - 0.001*(s_bkn3_l > 0.4);% POL is produced at iPLUSORG and removed where sBKN3 is high 
           m = leaf_mgen_conductivity( m, 'POLARISER', 0.001 );  %specifies the diffusion rate of POL    
           m = leaf_mgen_absorption( m, 'POLARISER', 0.1 );  %specifies the degradation rate of POL
           m.morphogenclamp( ((id_plusorg_p==1)), polariser_i ) = 0; %cancels the old clamp
           m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 1;  % fixes the level of POL at iPLUSORG, iMINUSORG and where sBKN3 is high              
 end

% Introduce effect of sBKN3 on growth rates, promoting growth in region of
% meristem
          
if realtime >=125 ;         
     
                  kapar_p(:) = 0.012.*pro(0.01, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l)...
                                    .* pro(0.01,(s_bkn3_l>=0.2));  % kpar is promoted by sPGRAD and where SBKN3 is high and is inhibited by iMINUSORG
                  kaper_p(:) = 0.006.*pro(1, (s_bkn3_l>=0.2))...
                                    .*pro(1.5,s_pgrad_l);  % Kper is promoted by sBKN3 and sPGRAD
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.01;  % 
end

% Introduce iBOUNDARY proximally to the sBKN3 region

if (realtime >= 150) &&(realtime <150+dt);
   id_boundary_p = ((s_bkn3_l <0.3) & (s_bkn3_l >0.2)) .* (m.nodes (:,2) <= 0.3); 
end        

% Activate iBOUNDARY region as a plus organiser and reorganise polarity

if (realtime >= 164) && (realtime < 164+dt);
     P= id_plusorg_p + id_boundary_p ; % POL is produced at iPLUSORG and iBOUNDARY
     m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 0; %cancels old clamp
     m.morphogenclamp (((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4) | (id_boundary_p ==1)), polariser_i ) =1; %fixes the level of POL at iPLUSORG, iMINUSORG, iBOUNDARY and where sBKN3 is high
    
end

% Remove the effect of sBKN3 on growth
if realtime >=170 ;
     
                  kapar_p(:) = 0.011.*pro(1.3, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l);%
                  kaper_p(:) = 0.002.*pro(5,s_pgrad_l);  % 
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

% Introduce iWINGTIP which produces sWING at the tip of the wings (where
% polarity converges (this is indpendent of the poalrity field, and is
% based on an approximation of where the convergence point is)
if (realtime >= 238) && (realtime < 238+dt);
    id_wingtip_p = ((m.nodes (:,2) >= 0.47).*(m.nodes (:,2) <= 0.52).*id_edge_p);%
    s_wing_p = id_wingtip_p; %sWING is produced at iWINGTIP
    m = leaf_mgen_conductivity( m, s_wing_p, 0.008 );  %specifies the diffusion rate of sWING   
    m = leaf_mgen_absorption( m, s_wing_p, 0.00001 ); % specifies the degradation rate of sWING
    m.morphogenclamp( (id_wingtip_p==1), s_wing_i ) = 1; %fixes the values of sWING at iWINGTIP
    
end

% The effect of sWING on growth 
if realtime >=240 ;
     
                  kapar_p(:) = 0.0019.*pro(1, s_pgrad_l)...
                                     .* inh(1, id_minusorg_l)...
                                     .*pro(30, s_wing_l);% Kpar is promoted by sPGRAD and sWING and inhibited by iMINUSORG
                  kaper_p(:) = 0.0006 .*pro(5,s_pgrad_l);  %  Kper is prmoted by sPGRAD
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end
%fix the gradient of sWING
if realtime >= 242;
           m = leaf_mgen_conductivity( m, s_wing_p, 0 );
           m = leaf_mgen_absorption( m, s_wing_p, 0 );
end

%% 
            case 'BKN3' % Testing possible effects of the stripes of proximal BKn3 on wing development
 
if realtime >= 0;
                 kapar_p(:) = 0.011.*pro(0.6, s_pgrad_l)...
                                    .* inh(1.2, id_minusorg_l);  % Kpar is promoted by sPGRAD and inhbited by iMINUSORG
                 kaper_p(:) = 0.005;  % Kper is constant
                 kbpar_p(:) = kapar_p;  % 
                 kbper_p(:) = kaper_p;  % 
                 knor_p(:)  = 0.01;  % Knor is constant
end

% Activate sBKN3 in the middle of the lemma
 
  if (realtime >= 110) && (realtime < 110+dt);
          s_bkn3_p = id_centre_p; %sBKN3 is produced at iCENTRE
          m = leaf_mgen_conductivity( m, s_bkn3_i, 0.001 );  %specifies the diffusion rate of sBKN3
          m = leaf_mgen_absorption( m, s_bkn3_i, 0.1 ); %specifies the degradation rate of sBKN3
          m.morphogenclamp( ((id_centre_p==1)), s_bkn3_i ) = 1; %fixes the level of sBKN3 at iCENTRE
  end
  
% Freeze gradient of sBKN3 
  if realtime >= 116;
         m = leaf_mgen_conductivity( m, s_bkn3_p, 0 );     
         m = leaf_mgen_absorption( m, s_bkn3_p, 0 );  
  end
  
% Reorganise polarity, making the middle of the sBKN3 region a new minus
% organiser (centre of the new meristem)
            
 if (realtime >= 120)&& (realtime < 120+dt);
          
           P= id_plusorg_p - 0.001*(s_bkn3_l > 0.4);% POL is produced at iPLUSORG and removed weher sBKN3 is high
           m = leaf_mgen_conductivity( m, 'POLARISER', 0.001 );  %specifies the diffusion rate of POL   
           m = leaf_mgen_absorption( m, 'POLARISER', 0.1 ); %specifies the degradation rate of POL
           m.morphogenclamp( ((id_plusorg_p==1)), polariser_i ) = 0; %cancels the old clamp
           m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 1; % fixes the level of POL at iPLUSORG, iMINUSORg and where sBKN3 is high              
 end

% Introduce effect of sBKN3 on growth rates, promote growth in region of
% meristem
          
if realtime >=125 ;         
     
                  kapar_p(:) = 0.012.*pro(0.01, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l)...
                                    .* pro(0.01,(s_bkn3_l>=0.2));  % Kpar is promoted by sPGRAD and where sBKN3 is high anf inhibited by iMINUSORG
                  kaper_p(:) = 0.006.*pro(1, (s_bkn3_l>=0.2))...
                                    .*pro(1.5,s_pgrad_l);  % Kper is promoted by sPGRAD and where sBKN3 is high
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.01;  % 
end

% Introduce iBOUNDARY proximally to the sBKN3 region

if (realtime >= 150) &&(realtime <150+dt);
   id_boundary_p = ((s_bkn3_l <0.3) & (s_bkn3_l >0.2)) .* (m.nodes (:,2) <= 0.3); 
end        

% Activate the iBOUNDARY as a plus organiser and reorganise polarity

if (realtime >= 164) && (realtime < 164+dt);
     P= id_plusorg_p + id_boundary_p ; % POL is produced at iPLUSORG and iBOUNDARY
     m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 0; %cancels the old clamp
     m.morphogenclamp (((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4) | (id_boundary_p ==1)), polariser_i ) =1;% fixes the level of POL at iPLUSORG, iBOUNDARY, iMINUSORG and where sBKN3 is high
    
end

% Remove the effect of sBKN3 on growth rates
if realtime >=170 ;
     
                  kapar_p(:) = 0.011.*pro(1.3, s_pgrad_l)...
                                    .* inh(1, id_minusorg_l);% Kpar is promoted by sPGRAD and inhibited by sMINUSORG
                  kaper_p(:) = 0.002.*pro(5,s_pgrad_l);  % Kper is promoted by sPGRAD
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end

% Introduce iWINGTIP which produces sWING at the wing tips (approximately where the convergence point is) and iSTRIPE which
% replicates the proximal extension of the BKn3 expression domain
if (realtime >= 238) && (realtime < 238+dt);
    id_wingtip_p = ((m.nodes (:,2) >= 0.47).*(m.nodes (:,2) <= 0.52).*id_edge_p);% iWINGTIP is in the apprixmate position where the poalrity convergence point forms
    s_wing_p = id_wingtip_p; %sWING is produced at iWINGTIP
    m = leaf_mgen_conductivity( m, s_wing_p, 0.008 );  %specifies the diffusion rate of sWING   
    m = leaf_mgen_absorption( m, s_wing_p, 0.00001 );  %specifies the degradation rate of sWING
    m.morphogenclamp( (id_wingtip_p==1), s_wing_i ) = 1; %fixes the level of sWING at iWINGTIP
    id_stripe_p =((m.nodes (:,1)>=0.2).*(m.nodes (:,1)<= 0.27).*(m.nodes (:,2) >= 0.5).*(m.nodes (:,2) <= 0.6))| ...
                ((m.nodes (:,1)>=-0.27).*(m.nodes (:,1)<= -0.2).*(m.nodes (:,2) >= 0.5).*(m.nodes (:,2) <= 0.6)); %the position of the two stripes of BKn3 expression
            
  %Change Polarity with iSTRIPE 
     P= id_plusorg_p + id_boundary_p + 0.05*id_stripe_p; % POL is produced by iPLUSORG, iBOUNDARY and weakly by iSTRIPE
     m.morphogenclamp( ((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4)), polariser_i ) = 0;
     m.morphogenclamp (((id_plusorg_p==1)| (id_minusorg_p >= 0.8 )| (s_bkn3_l > 0.4) | (id_boundary_p ==1) | (id_stripe_p ==1)), polariser_i ) =1;
           
end

  
% the effect of s_wing and id_stripe on growth to make the wings
if realtime >=240 ;
     
                  kapar_p(:) = 0.0019.*pro(1, s_pgrad_l)...
                                .* inh(1, id_minusorg_l)...
                                .*pro(30, (s_wing_l )) ...
                                .* inh(10, s_wing_l > 0.65);%...
                               % .* pro (10, id_stripe_l) use this to
                               % modulate growth rates with iSTRIPE
                  kaper_p(:) = 0.0006 .*pro(5,s_pgrad_l);%...
                                %.* pro(6, id_stripe_l) use this to
                               % modulate growth rates with iSTRIPE  
                  kbpar_p(:) = kapar_p;  % 
                  kbper_p(:) = kaper_p;  % 
                  knor_p(:)  = 0.001;  % 
end
%fix the gradient of s_wing
if realtime >= 242;
           m = leaf_mgen_conductivity( m, s_wing_p, 0 );
           m = leaf_mgen_absorption( m, s_wing_p, 0 );
end

      %% 
      

        otherwise
            % If this happens, maybe you forgot a model.
    end
%%% END OF USER CODE: MORPHOGEN INTERACTIONS

%%% SECTION 3: INSTALLING MODIFIED VALUES BACK INTO MESH STRUCTURE
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.
    m.morphogens(:,polariser_i) = P;
    m.morphogens(:,kapar_i) = kapar_p;
    m.morphogens(:,kaper_i) = kaper_p;
    m.morphogens(:,kbpar_i) = kbpar_p;
    m.morphogens(:,kbper_i) = kbper_p;
    m.morphogens(:,knor_i) = knor_p;
    m.morphogens(:,strainret_i) = strainret_p;
    m.morphogens(:,arrest_i) = arrest_p;
    m.morphogens(:,id_minus_i) = id_minus_p;
    m.morphogens(:,id_plus_i) = id_plus_p;
    m.morphogens(:,id_base_i) = id_base_p;
    m.morphogens(:,id_edge_i) = id_edge_p;
    m.morphogens(:,id_tip_i) = id_tip_p;
    m.morphogens(:,id_dissect_i) = id_dissect_p;
    m.morphogens(:,id_wingtip_i) = id_wingtip_p;
    m.morphogens(:,id_centre_i) = id_centre_p;
    m.morphogens(:,s_dissect_i) = s_dissect_p;
    m.morphogens(:,s_wing_i) = s_wing_p;
    m.morphogens(:,s_tip_i) = s_tip_p;
    m.morphogens(:,s_bkn3_i) = s_bkn3_p;
    m.morphogens(:,id_boundary_i) = id_boundary_p;
    m.morphogens(:,id_wing_i) = id_wing_p;
    m.morphogens(:,s_promote_i) = s_promote_p;
    m.morphogens(:,id_plusorg_i) = id_plusorg_p;
    m.morphogens(:,id_minusorg_i) = id_minusorg_p;
    m.morphogens(:,s_pgrad_i) = s_pgrad_p;
    m.morphogens(:,id_stripe_i) = id_stripe_p;

%%% USER CODE: FINALISATION

% In this section you may modify the mesh in any way whatsoever.

 if (realtime >= -30.0) &&(realtime < -30.0+dt);
          m = leaf_subdivide( m, 'morphogen','id_dissect',...
                'min',0.5,'max',1,...
                'mode','mid','levels','all');
 end
 if (realtime >= 340.0) &&(realtime < 340.0+dt);
          m = leaf_subdivide( m, 'morphogen','s_wing',...
                'min',0.1,'max',1,...
                'mode','mid','levels','all');
 end
 % If needed force FE to subdivide (increase number FE's) here
    % if realtime==280+dt
         % m = leaf_subdivide( m, 'morphogen','id_vent',...
         %       'min',0.5,'max',1,...
         %       'mode','mid','levels','all');
    % end
% Cut the mesh along the seams (see above)
    % if m.userdata.CutOpen==1
    %    m=leaf_dissect(m);
    %    m.userdata.CutOpen=2;        
    %    Relax accumulated stresses slowly i.e. 0.95 to 0.999
    %    m = leaf_setproperty( m, 'freezing', 0.999 );
    % end
%%% END OF USER CODE: FINALISATION

end


%%% USER CODE: SUBFUNCTIONS

function m = local_setproperties( m )
% This function is called at time zero in the INITIALISATION section of the
% interaction function.  It provides commands to set each of the properties
% that are contained in m.globalProps.  Uncomment whichever ones you would
% like to set yourself, and put in whatever value you want.
%
% Some of these properties are for internal use only and should never be
% set by the user.  At some point these will be moved into a different
% component of m, but for the present, just don't change anything unless
% you know what it is you're changing.

%    m = leaf_setproperty( m, 'trinodesvalid', true );
%    m = leaf_setproperty( m, 'prismnodesvalid', true );
%    m = leaf_setproperty( m, 'hybrid3d', true );
%    m = leaf_setproperty( m, 'thicknessRelative', 0.015000 );
%    m = leaf_setproperty( m, 'thicknessArea', 0.000000 );
%    m = leaf_setproperty( m, 'thicknessMode', 'physical' );
%    m = leaf_setproperty( m, 'activeGrowth', 1.000000 );
%    m = leaf_setproperty( m, 'displayedGrowth', 1.000000 );
%    m = leaf_setproperty( m, 'displayedMulti', [] );
%    m = leaf_setproperty( m, 'allowNegativeGrowth', true );
%    m = leaf_setproperty( m, 'usePrevDispAsEstimate', true );
%    m = leaf_setproperty( m, 'perturbInitGrowthEstimate', 0.000010 );
%    m = leaf_setproperty( m, 'perturbRelGrowthEstimate', 0.010000 );
%    m = leaf_setproperty( m, 'perturbDiffusionEstimate', 0.000100 );
%    m = leaf_setproperty( m, 'resetRand', false );
%    m = leaf_setproperty( m, 'mingradient', 0.000000 );
%    m = leaf_setproperty( m, 'relativepolgrad', false );
%    m = leaf_setproperty( m, 'usefrozengradient', true );
%    m = leaf_setproperty( m, 'userpolarisation', false );
%    m = leaf_setproperty( m, 'thresholdsq', 0.000059 );
%    m = leaf_setproperty( m, 'splitmargin', 1.400000 );
%    m = leaf_setproperty( m, 'splitmorphogen', '' );
%    m = leaf_setproperty( m, 'thresholdmgen', 0.500000 );
%    m = leaf_setproperty( m, 'bulkmodulus', 1.000000 );
%    m = leaf_setproperty( m, 'unitbulkmodulus', true );
%    m = leaf_setproperty( m, 'poissonsRatio', 0.300000 );
%    m = leaf_setproperty( m, 'starttime', 0.000000 );
%    m = leaf_setproperty( m, 'timestep', 0.010000 );
%    m = leaf_setproperty( m, 'timeunitname', '' );
%    m = leaf_setproperty( m, 'distunitname', 'mm' );
%    m = leaf_setproperty( m, 'scalebarvalue', 0.000000 );
%    m = leaf_setproperty( m, 'validateMesh', true );
%    m = leaf_setproperty( m, 'rectifyverticals', false );
%    m = leaf_setproperty( m, 'allowSplitLongFEM', false );
%    m = leaf_setproperty( m, 'longSplitThresholdPower', 0.000000 );
%    m = leaf_setproperty( m, 'allowSplitBentFEM', false );
%    m = leaf_setproperty( m, 'allowSplitBio', false );
%    m = leaf_setproperty( m, 'allowFlipEdges', false );
%    m = leaf_setproperty( m, 'allowElideEdges', false );
%    m = leaf_setproperty( m, 'mincellangle', 0.200000 );
%    m = leaf_setproperty( m, 'alwaysFlat', 0.000000 );
%    m = leaf_setproperty( m, 'flattenforceconvex', true );
%    m = leaf_setproperty( m, 'flatten', false );
%    m = leaf_setproperty( m, 'flattenratio', 1.000000 );
%    m = leaf_setproperty( m, 'useGrowthTensors', false );
%    m = leaf_setproperty( m, 'plasticGrowth', false );
%    m = leaf_setproperty( m, 'totalinternalrotation', 0.000000 );
%    m = leaf_setproperty( m, 'stepinternalrotation', 2.000000 );
%    m = leaf_setproperty( m, 'showinternalrotation', false );
%    m = leaf_setproperty( m, 'performinternalrotation', false );
%    m = leaf_setproperty( m, 'internallyrotated', false );
%    m = leaf_setproperty( m, 'maxFEcells', 0 );
%    m = leaf_setproperty( m, 'inittotalcells', 0 );
%    m = leaf_setproperty( m, 'bioApresplitproc', '' );
%    m = leaf_setproperty( m, 'bioApostsplitproc', '' );
%    m = leaf_setproperty( m, 'maxBioAcells', 0 );
%    m = leaf_setproperty( m, 'biosplitarea', 0.000000 );
%    m = leaf_setproperty( m, 'biosplitarrestmgen', 'ARREST' );
%    m = leaf_setproperty( m, 'biosplitarrestmgenthreshold', 0.990000 );
%    m = leaf_setproperty( m, 'colors', (6 values) );
%    m = leaf_setproperty( m, 'colorvariation', 0.050000 );
%    m = leaf_setproperty( m, 'colorparams', (12 values) );
%    m = leaf_setproperty( m, 'biocolormode', 'auto' );
%    m = leaf_setproperty( m, 'freezing', 0.000000 );
%    m = leaf_setproperty( m, 'canceldrift', false );
%    m = leaf_setproperty( m, 'mgen_interaction', '' );
%    m = leaf_setproperty( m, 'mgen_interactionName', 'gpt_wingsmodelversion2_20151111' );
%    m = leaf_setproperty( m, 'allowInteraction', true );
%    m = leaf_setproperty( m, 'interactionValid', true );
%    m = leaf_setproperty( m, 'gaussInfo', (unknown type ''struct'') );
%    m = leaf_setproperty( m, 'D', (36 values) );
%    m = leaf_setproperty( m, 'C', (36 values) );
%    m = leaf_setproperty( m, 'G', (6 values) );
%    m = leaf_setproperty( m, 'solver', 'cgs' );
%    m = leaf_setproperty( m, 'solverprecision', 'double' );
%    m = leaf_setproperty( m, 'solvertolerance', 0.001000 );
%    m = leaf_setproperty( m, 'solvertolerancemethod', 'max' );
%    m = leaf_setproperty( m, 'diffusiontolerance', 0.000010 );
%    m = leaf_setproperty( m, 'allowsparse', true );
%    m = leaf_setproperty( m, 'maxIters', 0 );
%    m = leaf_setproperty( m, 'maxsolvetime', 1000.000000 );
%    m = leaf_setproperty( m, 'cgiters', 0 );
%    m = leaf_setproperty( m, 'simsteps', 0 );
%    m = leaf_setproperty( m, 'stepsperrender', 0 );
%    m = leaf_setproperty( m, 'growthEnabled', true );
%    m = leaf_setproperty( m, 'diffusionEnabled', true );
%    m = leaf_setproperty( m, 'flashmovie', false );
%    m = leaf_setproperty( m, 'makemovie', false );
%    m = leaf_setproperty( m, 'moviefile', '' );
%    m = leaf_setproperty( m, 'codec', 'None' );
%    m = leaf_setproperty( m, 'autonamemovie', true );
%    m = leaf_setproperty( m, 'overwritemovie', false );
%    m = leaf_setproperty( m, 'framesize', [] );
%    m = leaf_setproperty( m, 'mov', [] );
%    m = leaf_setproperty( m, 'boingNeeded', false );
%    m = leaf_setproperty( m, 'initialArea', 0.011759 );
%    m = leaf_setproperty( m, 'bendunitlength', 0.108441 );
%    m = leaf_setproperty( m, 'targetRelArea', 1.000000 );
%    m = leaf_setproperty( m, 'defaultinterp', 'min' );
%    m = leaf_setproperty( m, 'readonly', false );
%    m = leaf_setproperty( m, 'projectdir', 'W:\COENGROUP\current lab members\Annis\BARLEY PROJECT\New folder' );
%    m = leaf_setproperty( m, 'modelname', 'GPT_WINGSMODELversion2_20151111' );
%    m = leaf_setproperty( m, 'allowsave', true );
%    m = leaf_setproperty( m, 'addedToPath', false );
%    m = leaf_setproperty( m, 'bendsplit', 0.300000 );
%    m = leaf_setproperty( m, 'usepolfreezebc', false );
%    m = leaf_setproperty( m, 'dorsaltop', true );
%    m = leaf_setproperty( m, 'defaultazimuth', -45.000000 );
%    m = leaf_setproperty( m, 'defaultelevation', 33.750000 );
%    m = leaf_setproperty( m, 'defaultroll', 0.000000 );
%    m = leaf_setproperty( m, 'defaultViewParams', (unknown type ''struct'') );
%    m = leaf_setproperty( m, 'comment', '' );
%    m = leaf_setproperty( m, 'legendTemplate', '%T: %q\n%m' );
%    m = leaf_setproperty( m, 'bioAsplitcells', true );
%    m = leaf_setproperty( m, 'bioApullin', 0.142857 );
%    m = leaf_setproperty( m, 'bioAfakepull', 0.202073 );
%    m = leaf_setproperty( m, 'viewrotationstart', -45.000000 );
%    m = leaf_setproperty( m, 'viewrotationperiod', 0.000000 );
%    m = leaf_setproperty( m, 'interactive', false );
%    m = leaf_setproperty( m, 'coderevision', 0 );
%    m = leaf_setproperty( m, 'coderevisiondate', '' );
%    m = leaf_setproperty( m, 'modelrevision', 0 );
%    m = leaf_setproperty( m, 'modelrevisiondate', '' );
%    m = leaf_setproperty( m, 'savedrunname', '' );
%    m = leaf_setproperty( m, 'savedrundesc', '' );
%    m = leaf_setproperty( m, 'vxgrad', (108 values) );
%    m = leaf_setproperty( m, 'lengthscale', 0.150000 );
end

% Here you may write any functions of your own, that you want to call from
% the interaction function, but never need to call from outside it.
% Remember that they do not have access to any variables except those
% that you pass as parameters, and cannot change anything except by
% returning new values as results.
% Whichever section they are called from, they must respect the same
% restrictions on what modifications they are allowed to make to the mesh.

% For example:

% function m = do_something( m )
%   % Change m in some way.
% end

% Call it from the main body of the interaction function like this:
%       m = do_something( m );
