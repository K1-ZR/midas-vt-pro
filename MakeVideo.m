function MakeVideo
GlobalVariables;
load('OUTPUT.mat');

% MAIN
Bar = waitbar(0,'Loading ...','Name','MIDAS',...
                'CreateCancelBtn',...
                'setappdata(gcbf,''canceling'',1)');
setappdata(Bar,'canceling',0)
%
% =========================================================================
% PLOTING AFTER EACH TIME BLOCK

% making video file
if StressContourIndex == 2
    VideoNmae = 'SigXX field.avi';
    HeaderName = 'SigXX field';
elseif StressContourIndex == 3
    VideoNmae = 'SigYY field.avi';
    HeaderName = 'SigYY field';
elseif StressContourIndex == 4
    VideoNmae = 'SigXY field.avi';
    HeaderName = 'SigXY field';
end

if StressContourIndex >= 2
        % video
        VidObj = VideoWriter(VideoNmae);
        VidObj.Quality = 100;
        VidObj.FrameRate = FramePerSec;
        open(VidObj)
        % figure
        
        figure(2);
        set(figure(2), 'Position', [10 10 FrameDim(1) FrameDim(1)]);
end
% -------------------------------------------------------------------------
% making colorbar
jet(NumSpec);% Setting the values on colorbar
colormap(jet);
caxis(RecomLim);

kssv = linspace(RecomLim(1), RecomLim(2), NumSpec);
set(colorbar,'YtickMode','manual','YTick',kssv); % Set the tickmode to manual
for i = 1:NumSpec
    imep = num2str(kssv(i),'%+3.3E');
    vasu(i) = {imep} ;
end
set(colorbar,'YTickLabel',vasu(1:NumSpec),'fontsize',9);

% =========================================================================
for TB=1:StepJump:NumTimeStep
    
    % Check for Cancel button press
    if getappdata(Bar,'canceling')
        delete(Bar)
        break
    end
    
    eval(sprintf('Disp = Disp%d;',TB)); 
    eval(sprintf('Stress = Stress%d;',TB));
    eval(sprintf('IntTraDisp = IntTraDisp%d;',TB));
    
    New_Coo(:,2) = Coo(:,2)+ Disp(:,2);
    New_Coo(:,3) = Coo(:,3)+ Disp(:,3);
    Component = Stress(:,StressContourIndex-1+1);
    % ---------------------------------------------------------------------
    % Plot after each iteration    
    PlotFieldonMesh(New_Coo,Con,Component, IntTraDisp);
    title({HeaderName; sprintf('Time = %8.4f s',TB * TIMESTEP)}) ;
    
    Frame = getframe(figure(2));
    writeVideo(VidObj,Frame);
    cla(figure(2));
    % ---------------------------------------------------------------------
    waitbar( TB/NumTimeStep, Bar, sprintf('Creating Movie ...') ); 
    % ---------------------------------------------------------------------
    clear( sprintf('Disp = Disp%d;',TB) );
    clear( sprintf('Stress = Stress%d;',TB) );
    clear( sprintf('IntTraDisp = IntTraDisp%d;',TB) );
end

close(figure(2));
delete(Bar);
msgbox('Operation Completed','Success');
end


% =========================================================================
% =========================================================================
% =========================================================================
function PlotFieldonMesh(New_Coo, Con, Component, IntTraDisp)
GlobalVariables;
hold off
axis equal
axis manual
axis([LimXY(1,:) LimXY(2,:)]);

X1=[];Y1=[];X2=[];Y2=[];
Profile1=[];Profile2=[];
EE1=1;EE2=1;
for EE=1:size(Con,1)
    
    if Con(EE,5)==1 % AGG
        X1(1:3,EE1)=[New_Coo(Con(EE,2),2); New_Coo(Con(EE,3),2); New_Coo(Con(EE,4),2)];
        Y1(1:3,EE1)=[New_Coo(Con(EE,2),3); New_Coo(Con(EE,3),3); New_Coo(Con(EE,4),3)];
        Profile1(1:3,EE1) = [Component(EE); Component(EE); Component(EE)];
        EE1 = EE1+1;
    else           % MATRIX
        X2(1:3,EE2)=[New_Coo(Con(EE,2),2); New_Coo(Con(EE,3),2);  New_Coo(Con(EE,4),2)];
        Y2(1:3,EE2)=[New_Coo(Con(EE,2),3); New_Coo(Con(EE,3),3);  New_Coo(Con(EE,4),3)];
        Profile2(1:3,EE2) = [Component(EE);  Component(EE);  Component(EE)];
        EE2 = EE2+1;
    end
end
hold on
fill(X1,Y1,Profile1,'EdgeColor','none');
fill(X2,Y2,Profile2);

% =========================================================================
% COH ELEMENTS
X1=[];Y1=[];
X2=[];Y2=[];
EE1=1;EE2=1;
for EE = 1 : 2 : size(IntTraDisp,1)-1
    
    if IntTraDisp(EE,3) ~= 1 % UNDAMAGED
        X1(1:4,EE1)=[New_Coo(IntTraDisp(EE  ,2),2); New_Coo(IntTraDisp(EE+1,2),2); New_Coo(IntTraDisp(EE+1,1),2); New_Coo(IntTraDisp(EE  ,1),2)];
        Y1(1:4,EE1)=[New_Coo(IntTraDisp(EE  ,2),3); New_Coo(IntTraDisp(EE+1,2),3); New_Coo(IntTraDisp(EE+1,1),3); New_Coo(IntTraDisp(EE  ,1),3)];
        EE1 = EE1+1;
    elseif IntTraDisp(EE,3) == 1  % DAMAGED          
        X2(1:4,EE2)=[New_Coo(IntTraDisp(EE  ,2),2); New_Coo(IntTraDisp(EE+1,2),2); New_Coo(IntTraDisp(EE+1,1),2); New_Coo(IntTraDisp(EE  ,1),2)];
        Y2(1:4,EE2)=[New_Coo(IntTraDisp(EE  ,2),3); New_Coo(IntTraDisp(EE+1,2),3); New_Coo(IntTraDisp(EE+1,1),3); New_Coo(IntTraDisp(EE  ,1),3)];
        EE2 = EE2+1;
    end
end
fill(X1,Y1,'g','EdgeColor','none');   
fill(X2,Y2,'w','EdgeColor','none');

end
