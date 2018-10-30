function Start_MIDAS

clc
clear
clear global
close all

if exist('OUTPUT.mat','file')
    delete('OUTPUT.mat')
    Keyvan='Keyvan';
    save('OUTPUT.mat','Keyvan')
else
    Keyvan='Keyvan';
    save('OUTPUT.mat','Keyvan')
end

% File = fullfile(cd, 'fp_database.mat');
% save(File,'data');
% delete(File);
% disp(exist(File, 'file'))
% ===============================================
GUI_MIDAS;
end