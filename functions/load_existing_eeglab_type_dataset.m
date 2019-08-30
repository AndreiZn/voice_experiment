function EEG = load_existing_eeglab_type_dataset(CFG, data_file_idx)

file_name = CFG.eeglab_type_data_files(data_file_idx).name;
% if strcmp(file_name(end-2:end), 'fdt')
%     file_name = CFG.eeglab_type_data_files(data_file_idx+1).name;
% end
file_folder = CFG.eeglab_type_data_files(data_file_idx).folder;
EEG = pop_loadset('filename',file_name,'filepath',file_folder);
EEG = eeg_checkset( EEG );
