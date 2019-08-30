function EEG = produce_eeglab_type_dataset(CFG, data_file_idx)

file_folder = CFG.data_files(data_file_idx).folder;
file_name = CFG.data_files(data_file_idx).name;
filepath = fullfile(file_folder, file_name);
setname = [file_name(1:13), '_session', num2str(data_file_idx)];

EEG = pop_importdata('dataformat','matlab','nbchan',0,'data',filepath,'srate',CFG.sample_rate,'pnts',0,'xmin',0);
EEG.setname=setname;
EEG = eeg_checkset( EEG );
EEG = pop_chanevent(EEG, CFG.event_channel,'edge','leading','edgelen',0);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'channel',CFG.data_channels);
EEG = eeg_checkset( EEG );
EEG = pop_editset(EEG, 'chanlocs', CFG.channel_location_file);
EEG = eeg_checkset( EEG );
output_folder = [CFG.output_folder, '\eeglab_type_datasets\'];
if ~exist(output_folder, 'dir')
    mkdir(output_folder)
end
EEG = pop_saveset( EEG, 'filename',[setname,'.set'],'filepath',output_folder);
EEG = eeg_checkset( EEG );
