function LoadResult
GlobalVariables;
%%
% this program will read the data from MIDAS OUTPUT.OUT
% =========================================================================
TIMESTEP = TimeIncr;
NumTimeStep = TotalTime/TimeIncr;
NumNodes = size(Coo,1);
NumRegEl = size(Con,1);
NumIntEl= size(IntEl,1);
% -------------------------------------------------------------------------
Bar = waitbar(0,'Loading ...','Name','MIDAS',...
                'CreateCancelBtn',...
                'setappdata(gcbf,''canceling'',1)');
setappdata(Bar,'canceling',0)
% =========================================================================
% THE MAIN WHILE, READ THE TEXT FILE LINE BY LINE
FileID_OUTPUT = fopen( 'OUTPUT.OUT' , 'r'); 
OUTPUT = textscan(FileID_OUTPUT, '%s','delimiter', '\n');
OUTPUT  = OUTPUT{1,1};

LL = 1;
% =========================================================================
% READING THE RESULT
TB = 1;
% Disp_Cum=[ [1:NumNodes]' zeros(NumNodes,2)];
while TB < round(NumTimeStep)+1
    Disp=[];
    Stress=[];
    Strain=[];
    IntTraDisp=[];
    if ~isempty( strfind(OUTPUT{LL,1} , [num2str(TB) ' OBTAINED AFTER'] ))
        % Disp : NODE NO.             A1             A2
        for LLL=LL+10 : LL+10+NumNodes-1
            NodeDisp = textscan(OUTPUT{LLL,1}, '%f','delimiter', '\t');
            Disp   = vertcat(Disp,NodeDisp{1,1}');
        end
        LL = LLL;
        % Disp(:,:,TB)=Disp_0;
        % Stress : ELEMENT NO.         SIGMA11         SIGMA22         SIGMA12         SIGMA33
        for LLL=LL+7 : LL+7+NumRegEl-1
            ElStress = textscan(OUTPUT{LLL,1}, '%f','delimiter', '\t');
            Stress = vertcat(Stress,ElStress{1,1}');
        end
        LL=LLL;
        % Stress(:,:,TB)=Stress_0;
        % Strain : ELEMENT NO.       EPSILON11       EPSILON22       EPSILON12       EPSILON33
        for LLL=LL+4 : LL+4+NumRegEl-1
            ElStrain = textscan(OUTPUT{LLL,1}, '%f','delimiter', '\t');
            Strain = vertcat(Strain,ElStrain{1,1}');
        end
        LL = LLL;
        % Strain(:,:,TB)=Strain_0;
        % IntTraDisp: NODE 1  NODE 2              DAMAGE     NORMAL TRACTION        NORMAL DISP.  TANGENTIAL TRACTION     TANGENTIAL DISP.
        for LLL=LL+5 : LL+5+NumIntEl-1
            ElIntTraDisp = textscan(OUTPUT{LLL,1}, '%f','delimiter', '\t');
            IntTraDisp = vertcat(IntTraDisp,ElIntTraDisp{1,1}');
        end
        LL = LLL;
        % IntTraDisp(:,:,TB)=IntTraDisp_0;
        %==================================================================
        % saving data
        eval(sprintf('Disp%d = Disp;', TB));
        eval(sprintf('Stress%d = Stress;', TB));
        eval(sprintf('Strain%d = Strain;', TB));
        eval(sprintf('IntTraDisp%d = IntTraDisp;', TB));
        
        save('OUTPUT.mat',sprintf('Disp%d', TB),...
                          sprintf('Stress%d', TB),...
                          sprintf('Strain%d', TB),...
                          sprintf('IntTraDisp%d', TB),'-append');
        
       eval(sprintf('clear Disp%d Stress%d IntTraDisp%d', TB, TB, TB, TB));
                      
        TB=TB+1;
    end
LL=LL+1;
% -------------------------------------------------------------------------
waitbar( TB/NumTimeStep, Bar, 'Reading OUTPUTFILE ...' ); 
% Check for Cancel button press
if getappdata(Bar,'canceling')
    delete(Bar)
    break
end
end   
delete(Bar);
fclose('all'); 
end






















