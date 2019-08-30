% Load S1_EEG.set
% Filename is S1_EEG.set
% Note that you will need to replace the path with the actual location in your file system
% Make sure that your file names and folder names do not contain spaces or other special characters
% Note that the dataset will not appear in the Datasets menu in the EEGLAB GUI
EEG = pop_loadset('filename', 'S1_EEG.set', 'filepath',  '../Test_Data/S1/');

%The following version will look for the file in Matlab's Current Folder
EEG = pop_loadset('filename', 'S1_EEG.set');

% To view the EEG data enter the following command:
pop_eegplot(EEG);