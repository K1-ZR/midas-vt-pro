function GenerateInputFile
%%
GlobalVariables;
SetGlobal;
% -------------------------------------------------------------------------
InputFileID = fopen( 'INPUT.dat' , 'w'); 
% -------------------------------------------------------------------------
%   NDIM - DIMENSIONALITY OF PROBLEM TO BE SOLVED                                 
%   NN - NUMBER OF NODES                                                          
%   NEL - NUMBER OF ELEMENTS                                                      
%   NF - NUMBER OF NODES WITH EXTERNALLY APPLIED LOADS                            
%   NDBC - NUMBER OF DISPLACEMENT BOUNDARY CONDITIONS                             
%   NNPEREL - NUMBER OF NODES PER ELEMENT                                         
%   NLCUR - NUMBER OF LOAD CURVES - SHOULD BE UTILIZED WHEN                       
%           NF.GT.0                                                               
%   NSTE - NUMBER OF SOLUTION STEPS                                               
%   IINT - EQ. ZERO UNLESS USING INTERFACE ELEMENTS                               
%   ITYPE - TYPE OF ANALYSIS                                                      
%           EQ.1 FOR PLANE STRESS
%           EQ.2 FOR PLANE STRAIN                                                 
%   IVARI - NUMBER OF TIME BLOCKS TO BE INPUT                                     
%   NOMAT - NUMBER OF MATERIAL MODELS TO BE USED IN ANALYSIS                      
%   HERTZ - HERTZ SPECIFED WHEN CYCLIC BOUNDARY CONDITION USED
%   ICTYPE - FLAG FOR CYCLIC BOUNDARY CONDITION USED
%           0 - ZERO MEAN (KIM TYPE)
%           1 - ZERO MINIMUM (LEE TYPE)
%   NANIM - FLAG FOR ANIMATION OUTPUT
%  		1 - ACTIVATING ANIMATION OUTPUT                                                                       
%  		OTHERS - NOT ACTIVATING ANIMATION OUTPUT

%  RTOL - TOLERANCE USED TO MEASURE EQUILIBRIUM CONVERGENCE-I USUALLY USE 0.005                      
%  IPTYPE - OUTPUT TYPE FLAG
% 		 IF THIS IS 1, IT PRODUCE WHOLE OUTPUT, 
% 		 IF NOT, IT PRODUCE ONLY AVERAGE OUTPUT
%  IPRI - OUTPUT PRINTING INTERVAL                                               
%  ISREF - NUMBER OF ITERATIONS BETWEEN REFORMATION OF STIFFNESS MATRIX - I USUALLY USE 1                                              
%  IEQUIT - NUMBER OF STEPS BETWEEN EQUILIBRIUM ITERATIONS - USE 1                                                                
%  ITEMAX - MAXIMUM NUMBER OF EQUILIBRIUM ITERATIONS PERMITTED BEFORE STOPPING EXECUTION - USE 25                                           

% NDIM= DIMENSIONALITY OF PROBLEM   
% NN= NUMBER OF NODES
% NEL= NUMBER OF ELEMENTS   
% NF= NUMBER OF EXTERNAL FORCE COMPONENTS   
% NDBC= NUMBER OF DISP. BOUNDARY CONDITIONS
% NSTE= NUMBER OF SOLUTION STEPS   (?????)
% NNPEREL= NUMBER OF NODES PER ELEMENT  
% HERTZ=CYCLIC DISPLACEMENTS IN HERTZ
% ITYPE =
%         1 MEANS PLANE STRESS
%         2 MEANS PLANE STRAIN                                             
% RTOL= TOLERANCE FOR EQUILIBRIUM CONVERGENCE IS
% IPTYPE= OUTPUT PRINTING TYPE
%         1 MEANS WHOLE OUTPUT PRINTING
%         OTHER VALUES MEAN AVERAGE OUTPUT PRINTING              
% IPRI= OUTPUT PRINTING INTERVAL
% ISREF= NO. OF ITER. BEFORE REFORMING STIFFNESS MATRIX 
% IEQUIT= NUMBER OF STEPS BETWEEN EQUILIBRIUM ITERATIONS 
% ITEMAX= MAX NO. ITERATIONS BEFORE STOPPING EXECUTION 

% TIMEB(I)= ENDING TIME OF ITH TIME BLOCK - TIMEBLOCK                                    
% TFAC(I)= MULTIPLICATIVE FACTOR FOR ALL INPUTS DURING ITH TIMEBLOCK - FACTOR                      
% DTIM(I)= TIME INCREMENT DURING ITH TIME BLOCK - TIME STEP 

% A1(IEL) - X COORDINATE OF NODE IEL                                            
% A2(IEL) - Y COORDINATE OF NODE IEL 

% IEL - GLOBAL ELEMENT NUMBER                                                   
% NODE(IEL,J) - JTH GLOBAL NODE NUMBER FOR IELTH ELEMENT                        
%               MUST BE READ IN COUNTERCLOCKWISE                                
%               NOTE THAT J RANGES FROM 1 TO 3 FOR CST'S                        
%               AND 1 TO 6 FOR LST'S   
%               NODE 1, NODE 2, NODE 3
% MATSET(IEL) - YOU NEED TO ASSIGN AN INTEGER NUMBER TO EACH MATERIAL MODEL USED                              
% MTYPE(IEL) - MATERIAL MODEL TYPE NUMBER FOR IELTH ELEMENT                     
%              EQ.1 IS ISOTROPIC LINEAR ELASTIC                                 
%  	           EQ.2 IS ORTHOTROPIC LINEAR VISCOELASTIC                                
% THETA(IEL) - ANGLE OF FIBER MEASURED WITH RESPECT TO X3 AXIS (RADIANS)                 
%              USED ONLY FOR ORTHOTROPIC MEDIA                                  
%              NOTE: THIS IS NOT THE VALUE OF THETA NORMALLY USED IN LAMINATION THEORY

% THE THICKNESS OF ALL ELEMENTS IS AUTOMATICALLY SET TO UNITY  THE VALUE OF 
% THICKNESS DONE NOT MATTER WITH TESTING RESULTS WHEN YOU DO PLANE ANALYSIS 
% DO I=1,NEL                                                             
% 	T(I)=1.0                                                                  
% ENDDO 

% NDBC MUST BE GT.0                                     
% NDOF(I) - GLOBAL DEGREE OF FREEDOM OF ITH DEGREE OF FREEDOM TO BE INPUT.  
%           2X THE NODE NUMBER MINUS 1 FOR THE X COORDINATE 
%           2X THE NODE NUMBER         FOR THE Y DIRECTION
% 1 -------------------------------------------------------------------------XXXXXXXXXXXXXXXXXXXXXXXXXX
% JNDOF   = GLOBAL NUMBER OF DEGREES OF FREEDOM                          
% JBANDW  = BANDWIDTH OF GLOBAL STIFFNESS MATRIX                        
% JNINT   = NUMBER OF INTERFACE ELEMENTS                                
% JNIPNT  = NUMBER OF INTEGRATION POINTS PER ELEMENT                    
% JNIMOD  = NUMBER OF INTERFACE MODELS                                  
% JPRONY  = NUMBER OF TERMS IN PRONY SERIES IN                          
%            VISCOELASTICITY MODEL                                      
% JNUMVIS = NUMBER OF VISCOELASTICITY MODELS                            
% JTBLK   = NUMBER OF TIME BLOCKS                                       
%                                                           
%       In the Param file, JTBLK has to be specified with   
%       equal or higher number than NF because currently    
%      INODE(I) and ICURVE(I) are controlled by JTBLK.   	 
%                                                            
% NELNODE = NUMBER OF NODES PER ELEMENT                                  
% JDIM    = 4 FOR 2-D ANALYSES                                          
% JDINC   = NUMBER OF DISPLACEMENT BOUNDARY CONDITIONS       

JNEL    = NumRegEl+1;  % Max No of EL
JNNODE  = size(Coo,1)+1;  % Max No of Node
JNDOF   = 2*size(Coo,1) + 1;% Max No of DOF
JBANDW  = BandWidth + 1; % ???? Max No of BANDW
JNINT   = size(IntEl,1)+1; % ???? inter face
JNIPNT  =1;    % ????
JNIMOD  =3;    % ????
JPRONY  =10;   % Max No of Prony
JNUMVIS =3;    % ????
JTBLK   =3;    % ????
NELNODE =3;    % ????
JDIM    =4;    % ????
JDINC   =size(DINC,2)+1; % Max No of BC disp
fprintf(InputFileID,'%7d %7d %7d %7d %7d %7d %7d %7d %7d %7d %7d %7d %7d\r\n',...
                     JNEL,JNNODE,JNDOF,JBANDW,JNINT,JNIPNT,JNIMOD,JPRONY,JNUMVIS,JTBLK,NELNODE,JDIM,JDINC);
%FORMAT(13I7)   
% 2 -------------------------------------------------------------------------
NDIM=2;
NN = size(Coo,1);
NEL= NumRegEl; 
NNPEREL=3;
NLCUR=0; % NUMBER OF LOAD CURVES
NANIM=1; % Animation output
fprintf(InputFileID,'%5d %7d %7d %5d %5d %5d %5d %5d\r\n',...
                    NDIM,NN,NEL,NF,NDBC,NNPEREL,NLCUR,NANIM);
%FORMAT(I5,2I7,5I5)  
% 3 -------------------------------------------------------------------------
NSTE   = round(TotalTime/TimeIncr); % NSTE= NUMBER OF SOLUTION STEPS ???? 
IINT   = NumOfInterphase; % EQ. ZERO UNLESS USING INTERFACE ELEMENTS   
if PlaneStress==1;ITYPE  =1;end
if PlaneStrain==1;ITYPE  =2;end
IVARI  =1;% NUMBER OF TIME BLOCKS TO BE INPUT
NOMAT  =1;% NUMBER OF MATERIAL MODELS USED  ????
HERTZ  =0.0;
ICTYPE =0;% FLAG FOR CYCLIC BC
fprintf(InputFileID,'%5d    %5d %5d %5d %5d %10.6f  %5d\r\n',...
                    NSTE,IINT,ITYPE,IVARI,NOMAT,HERTZ,ICTYPE);               
%FORMAT(5I5,F10.6,I5)                                                         
% 4 -------------------------------------------------------------------------
RTOL   =0.005;
IPTYPE =1;
IPRI   =1;
ISREF  =1;
IEQUIT =1;
ITEMAX =25;

fprintf(InputFileID,'%10.6f %5d %5d %5d %5d %5d\r\n',...
                    RTOL,IPTYPE,IPRI,ISREF,IEQUIT,ITEMAX);                          
%FORMAT(F10.6,5I5)                                                                                    
% 5 -------------------------------------------------------------------------
if IVARI==0                                                   
	TFAC(1)=1.; % MULTIPLICATIVE FACTOR FOR ALL INPUTS DURING ITH TIMEBLOCK                                                       
	TIMEB(1)=1000000.; % ????
else
    TIMEB=TotalTime;
    TFAC=1;
    DTIM=TimeIncr;
    for I=1:IVARI
        fprintf(InputFileID,'%7d %7d %7d\r\n',...
                            TIMEB,TFAC,DTIM);
                            %TIMEB(I),TFAC(I),DTIM(I));    
    end
end
% 6 -------------------------------------------------------------------------
for II=1:NN                                         
    fprintf(InputFileID,'%7d %15.7f %15.7f\r\n',...
                        Coo(II,:));                                                                                 
                        % II,A1(II),A2(II));                                 
                        % 1003 FORMAT(I7,2D15.7) 
end
% #########################################################################
% THIS SECTION READS IN NODAL CONNECTIVITY DATA AND MATERIAL MODEL NUMBER FOR EACH ELEMENT                                                 
% .........................................................................
% edit Con
for EE = 1: size(Con,1)
        Con(EE,6) = MatType(Con(EE, 5));
        Con(EE,5) = MatSet(Con(EE,5));
end
% 7 .........................................................................
if NNPEREL==3
    NINTPT=1;                                                                  
    for ii=1:NEL
        fprintf(InputFileID,'%7d %7d %7d %7d %7d %7d %15.7f\r\n',...
                            Con(ii,:) );
                          % II, NODE(II,1:3), MATSET(II), MTYPE(II), THETA(II));                                             
    end
% elseif NNPEREL==6
%     NINTPT=3;                                                                  
%     for II=1:NEL
%         fprintf(InputFileID,'%7d %7d %7d %7d %7d %7d %15.7f\r\n',...
%                             Con(NN,:) );
%                            % II, NODE(II,1:6), MATSET(II), MTYPE(II));                                                                
%     end
end
                                                    
% #########################################################################
% THE NEXT SECTION INPUTS THE DISPLACEMENT BOUNDARY CONDITIONS 

% 	J - INPUT DISPLACEMENT DATA FOR TIMEBLOCK NUMBER
% 	NDISP(J) - THE NUMBER OF DISPLACEMENT BC 

%   NDOF(1,NDISP(J),J)
% 	THE DISP. BOUNDARY CONDITIONS ARE APPLIED AT' these 'DEGREES OF FREEDOM'             

% DINC: THE INCREMENTS OF THE DISPLACEMENTS TO BE APPLIED AT 
% THE GLOBAL DEGREES OF FREEDOM INPUT IN NDOF(I).  
% NOTE THAT THESE WILL BE DIVIDED BY TFAC(I) IF IVARI.NE.0      
% -------------------------------------------------------------------------
NVARI=IVARI;
if IVARI==0; NVARI=1; end 
% -------------------------------------------------------------------------
fprintf(InputFileID,'%7d %7d %7d %7d %7d %7d %7d %7d %7d %7d %7d %7d\r\n',...
                    NDISP);
                    %NDISP(1:NVARI));
if rem(length(NDISP),12)~=0;    fprintf(InputFileID,'\r\n');  end
% ------------------------------------------------------------------------- 
if NVARI==1
    fprintf(InputFileID,'%7d %7d %7d %7d %7d %7d %7d %7d %7d %7d\r\n',...
                        NDOF);
    %NDOF(1:NDISP(J)));  1005 FORMAT(10I8)
    if rem(length(NDOF),10)~=0;    fprintf(InputFileID,'\r\n');  end
    
    DINC = DINC * IncrDisp;% apply total disp to DOF
    fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n',...
                        DINC);
    %DINC(1:NDISP(J),J)); 7005 FORMAT(4E15.7)
    if rem(length(DINC),4)~=0;    fprintf(InputFileID,'\r\n');  end
else
    for J=1:NVARI
        
        fprintf(InputFileID,'%7d %7d %7d %7d %7d %7d %7d %7d %7d %7d\r\n',...
            NDOF);
        %NDOF(1:NDISP(J)));  1005 FORMAT(10I8)
        if rem(length(NDOF(J)),10)~=0;    fprintf(InputFileID,'\r\n');  end
        
        DINC = DINC * IncrDisp;% apply total disp to DOF
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n',...
                             DINC);
        %DINC(1:NDISP(J),J)); 7005 FORMAT(4E15.7)
        if rem(length(DINC(J)),4)~=0;    fprintf(InputFileID,'\r\n');  end
    end
end
% -------------------------------------------------------------------------
NTOT=NDIM*NN; 
for I=1:NTOT                                                           
	FGL(I)=0.;                                                                 
end
% #########################################################################
% THE NEXT SECTION INPUTS EXTERNALLY APPLIED LOADS IF NF.NE.0                                                                       
%                                                                                
% INPUT IS PERFORMED BY USING LOAD CURVES AND THEN ASSIGNING                    
% THESE CURVES TO THE INTENDED GLOBAL DEGREES OF FREEDOM                        
%                                                                               
% INODE(I) - GLOBAL NODE NUMBER FOR ITH LOAD                                    
% ICURVE(I) - CURVE NUMBER TO BE ASSIGNED TO INODE(I)                           
% FA1 - FORCE COMPONENT IN X COORDINATE DIRECTION
% FA2 - FORCE COMPONENT IN Y COORDINATE DIRECTION
% INODE(I) - NODE NO.
% ICURVE(I) - LOAD CURVE NO.

if NF~=0                                                    
    for I=1:NF  
        fprintf(InputFileID,'%7d %5d %15.7f %15.7f\r\n',...
                            INODE(I),ICURVE(I),FA1,FA2);                                   
        %   1006 FORMAT(I7,I5,2F15.7) 
        NN1=2*INODE(I)-1;                                                          
        NN2=NN1+1;                                                                 
        FGL(NN1)=FGL(NN1)+FA1;                                                     
        FGL(NN2)=FGL(NN2)+FA2;                                                    
    end                
end

% #########################################################################
% READ IN MATERIAL PROPERTIES FOR 2-D ANALYSES 

% MODNUM1 - No of 2-D ISOTROPIC ELASTIC MATERIAL SET
% MSETI,EE(MSETI),VNU(MSETI),Y(MSETI),ALPHAT(MSETI)

% MODNUM2 - No Of ORTHOTROPIC LINEAR VISCOELASTIC
% -------------------------------------------------------------------------
MODNUM1 = ECount;
MODNUM2 = VECount;
fprintf(InputFileID,'%5d %5d\r\n',...
                    MODNUM1,MODNUM2);
%FORMAT(2I5)   
% -------------------------------------------------------------------------
IVIS=0;                                                                    
if MODNUM2~=0; IVIS=1; end 

% ISOTROPIC ELASTIC ELEMENTS
if MODNUM1~=0      
    for II=1:MODNUM1
        MSETI = II;
        EE    = ElasticModulus(II);
        VNU   = EPoissonRatio(II);
        Y     = 100d90;
        ALPHAT= 1d-4;
        fprintf(InputFileID,'%5d %e %e %e %e\r\n',...
                            MSETI,EE,VNU,Y,ALPHAT );
                            %MSETI,EE(MSETI),VNU(MSETI),Y(MSETI),ALPHAT(MSETI));                                                             
        %FORMAT(I5,4E15.7)                                                
    end  
end

%LINEAR VISCOELASTIC MATRIX   
if MODNUM2~=0                         
    IVTYPE=0; % ????
    DTIME =0.0001; % ????
    fprintf(InputFileID,'%5d %15.7f\r\n',...
            IVTYPE,DTIME)
    %FORMAT(I5,D15.7) 
                  
    NMOD=MODNUM2;  
    for II=1:MODNUM2
        MSETII = II;
        NT11 = VENumPronySeries(II);
        NT12 = VENumPronySeries(II);
        NT22 = VENumPronySeries(II);
        NT23 = VENumPronySeries(II);
        NT44 = VENumPronySeries(II);
        NT66 = VENumPronySeries(II);
        
        % MSETI - 'VISCOELASTIC MODEL NUMBER = '                                              
        % NTii(MSETI) - 'NUMBER OF PRONY TERMS IN CLii = 
        fprintf(InputFileID,'%5d %5d %5d %5d %5d %5d %5d\r\n',...
                            MSETII,NT11,NT12,NT22,NT23,NT44,NT66 );
                            %MSETI,NT11(MSETI),NT12(MSETI),NT22(MSETI), NT23(MSETI),NT44(MSETI),NT66(MSETI));     
                            % FORMAT(7I5) 
        % .................................................................
        % CL Infinity
        NU = VEPoissonRatio(II);
        E  = VEPronySeriesInf(II);

        MIU      = E / (2*(1+NU));
        LAMBDA  = (E*NU) / ((1+NU)*(1-2*NU));

        CLINF11 = LAMBDA+2*MIU;
        CLINF12 = LAMBDA;
        CLINF22 = LAMBDA+2*MIU;
        CLINF23 = LAMBDA;
        CLINF44 = 2*MIU;
        CLINF66 = 2*MIU;
        
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n',...
                             CLINF11,CLINF12,CLINF22,CLINF23,CLINF44,CLINF66);
                             %CLINF11(MSETI),CLINF12(MSETI),CLINF22(MSETI),CLINF23(MSETI),CLINF44(MSETI),CLINF66(MSETI));
        fprintf(InputFileID,'\r\n'); % ????               
        % FORMAT(4D15.7)  
        % .................................................................
        for PP=1:VENumPronySeries(II)
            
            NU = VEPoissonRatio(II);  
            E  = VEPronySeries{II}(PP,1);

            MIU      = E / (2*(1+NU));
            LAMBDA  = (E*NU) / ((1+NU)*(1-2*NU));

            CL11(PP) = LAMBDA+2*MIU;
            CL12(PP) = LAMBDA;
            CL22(PP) = LAMBDA+2*MIU;
            CL23(PP) = LAMBDA;
            CL44(PP) = 2*MIU;
            CL66(PP) = 2*MIU;

            ETA11(PP) = CL11(PP) * VEPronySeries{II}(PP,2);
            ETA12(PP) = CL12(PP) * VEPronySeries{II}(PP,2);
            ETA22(PP) = CL22(PP) * VEPronySeries{II}(PP,2);
            ETA23(PP) = CL23(PP) * VEPronySeries{II}(PP,2);
            ETA44(PP) = CL44(PP) * VEPronySeries{II}(PP,2);
            ETA66(PP) = CL66(PP) * VEPronySeries{II}(PP,2); 

        end
        
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', CL11(:));  %CL11(MSETI,1:NT11(MSETI))); 
        if rem(NT11,4)~=0;    fprintf(InputFileID,'\r\n');  end
        %if rem(NT11(MSETI),4)~=0;
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', ETA11(:)); %ETA11(MSETI,1:NT11(MSETI)));                             
        if rem(NT11,4)~=0;    fprintf(InputFileID,'\r\n');  end
        
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', CL12(:)); %CL12(MSETI,1:NT12(MSETI))); 
        if rem(NT12,4)~=0;    fprintf(InputFileID,'\r\n');  end
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', ETA12(:)); %ETA12(MSETI,1:NT12(MSETI)));                             
        if rem(NT12,4)~=0;    fprintf(InputFileID,'\r\n');  end
        
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', CL22(:)); %CL22(MSETI,1:NT22(MSETI))); 
        if rem(NT22,4)~=0;    fprintf(InputFileID,'\r\n');  end
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', ETA22(:)); %ETA22(MSETI,1:NT22(MSETI)));                             
        if rem(NT22,4)~=0;    fprintf(InputFileID,'\r\n');  end
        
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', CL23(:)); %CL23(MSETI,1:NT23(MSETI))); 
        if rem(NT23,4)~=0;    fprintf(InputFileID,'\r\n');  end
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', ETA23(:)); %ETA23(MSETI,1:NT23(MSETI)));                             
        if rem(NT23,4)~=0;    fprintf(InputFileID,'\r\n');  end
        
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', CL44(:)); %CL44(MSETI,1:NT44(MSETI))); 
        if rem(NT44,4)~=0;    fprintf(InputFileID,'\r\n');  end
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', ETA44(:)); %ETA44(MSETI,1:NT44(MSETI)));                             
        if rem(NT44,4)~=0;    fprintf(InputFileID,'\r\n');  end
        
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', CL66(:)); %CL66(MSETI,1:NT66(MSETI))); 
        if rem(NT66,4)~=0;    fprintf(InputFileID,'\r\n');  end
        fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n', ETA66(:)); %ETA66(MSETI,1:NT66(MSETI)));                             
        if rem(NT66,4)~=0;    fprintf(InputFileID,'\r\n');  end
        % FORMAT(4D15.7)                                                                                             
    end
    
end
% #########################################################################
% READ IN PROPERTIES FOR 2-D INTERFACE ELEMENTS
%   'INTERFACE ELEMENTS IN EFFECT', ALLEN VISCOELASTIC COHESIVE ZONE MODEL
%     NINEL - NO. OF INTERFACE ELEMENTS 
%     NINTG - NO. OF INTERFACE MATERIAL GROUPS
%     NPRONY - NO. OF TERMS IN PRONY SERIES
%     IDAMAGE -  FLAG FOR DAMAGE EVOLUTION LAW = 
%               0 MEANS POWER LAW DAMAGE MODEL
%               1 MEANS PROBABILISTIC DAMAGE MODEL
%               2 Gaussian function 

if IINT~=0
    NINEL= size(IntEl,1);
    NINTG= NumOfInterphase;
    
    fprintf(InputFileID,'%7d %5d\r\n',...
                        NINEL,NINTG);
    %     9108 FORMAT(I7,3I5)
    
    for II = 1:NINTG
        
        if DamageModel(II)==1; IDAMAGE=0; % Power law
        elseif DamageModel(II)==2; IDAMAGE=2; % Gaussian Function
        end
        fprintf(InputFileID,'%5d\r\n',...
            IDAMAGE);
        % ---------------------------------------------------------------------
        if IDAMAGE==0
            fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n',...
                SigmaN(II), DeltaN(II), SigmaT(II), DeltaT(II));
            %SIGMAN(I),DELTAN(I),SIGMAT(I),DELTAT(I));
            % 9104    FORMAT(4E15.7)
            fprintf(InputFileID,'%15.7f %15.7f %15.7f\r\n',...
                PLc(II), PLn(II), PLm(II));
            %ALPH(I),RM(I),   RMMM(I), ECINF(I));
            %9102    FORMAT(4E15.7)
            % .....................................................................
        elseif IDAMAGE==2
            fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n',...
                SigmaN(II), DeltaN(II), SigmaT(II), DeltaT(II));
            %SIGMAN(I), DELTAN(I), SIGMAT(I), DELTAT(I));
            fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n',...
                ConA(II), ConM(II), ConLambdabar(II), ConDelta(II));
            %ConA(I),ConM(I),ConLambdabar(I),ConDelta(I),ECINF(I));
            % .....................................................................
        elseif IDAMAGE==1
            %         % NUMBER - 'NUMBER OF TRAPEZOIDAL ELEMENTS',/)
            %         fprintf(InputFileID,'%5d\r\n',...
            %                             NUMBER);
            %         % FORMAT(I5)
            %
            %         % 'GROUP NO.',6X,'SIGMAN',6X,'DELTAN',6X,'SIGMAT',16X,'DELTAT',/)
            %         for I=1:NINTG
            %             fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f\r\n',...
            %                                 SIGMAN,DELTAN,SIGMAT,DELTAT);
            %                                 %SIGMAN(I),DELTAN(I),SIGMAT(I),DELTAT(I));
            %             %FORMAT(4E15.7)
            %         end
            %
            %         %'GROUP NO.',6X,'RADMEAN',6X,'STD',6X,'POISSON',6X,'RADCR',6X,'EINF',/)
            %         for I=1:NINTG
            %             fprintf(InputFileID,'%15.7f %15.7f %15.7f %15.7f %15.7f\r\n',...
            %                                 RADMEAN(I),STD(I),POISSON(I),RADCR(I),ECINF(I));
            %             %FORMAT(5E15.7)
            %         end
            
        end
        
        % ---------------------------------------------------------------------
        %'GROUP NO.'	'PRONY NO.'	 'E(I)'     'ETA(I)'
        NPRONY = VECZNumPronySeries(II);
        ECINF = VECZPronySeriesInf(II);
        fprintf(InputFileID,'%5d %15.7f\r\n',...
                            NPRONY,ECINF);
        % ....................................................................
        for PP=1:NPRONY
            EC(PP)   = VECZPronySeries{II}(PP,1);
            ETAC(PP) = EC(PP) * VECZPronySeries{II}(PP,2);
            
            fprintf(InputFileID,'%15.7f %15.7f\r\n',...
                EC(PP),ETAC(PP));
            %EC(I,PP),ETAC(I,PP));
            %FORMAT(2E15.7)
        end
    end
    % ---------------------------------------------------------------------
    %'INTERFACE CONNECTIVITY MATRIX'
    % 'NODE 1'  'NODE 2'	'MAT NO.'	'WIDTH'	'PHIAV'
    for I=1:NINEL
        fprintf(InputFileID,'%7d %7d %5d %15.7f %15.7f\r\n',...
            IntEl(I,:));
        %NINT1(I),NINT2(I),IGR(I),WIDTH(I),PHIAV(I));
        %FORMAT(2I7,I5,2E15.7)
    end
    
end

fclose(InputFileID);
end

