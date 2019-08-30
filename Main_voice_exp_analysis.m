CFG = [];
CFG.sample_rate = 250; % Hz
CFG.data_channels = 2:33;
CFG.event_channel = 36;
CFG.load_existing_datasets = 1;
%% Select a root folder, an analysis folder, a channel location file, and a folder with eeglab-type datasets (if available)
CFG = select_files_and_folders(CFG);
%% Define other variables
CFG.plot = 0; % plot flag
CFG.num_features = 3; % mental_concentration, visuospatial_attention, emotion_state
window_size = 40; % sec
window_step = 25; % sec

%% Analysis loop
for data_file_idx = 1:1%CFG.num_sessions
    
    if ~CFG.load_existing_datasets
        % Transform .mat files into the eeglab format .set
        EEG = produce_eeglab_type_dataset(CFG, data_file_idx);
    else
        EEG = load_existing_eeglab_type_dataset(CFG, data_file_idx);
    end
    
    % Define max_length (needed to create a large enough matrix neural_features)
    time_length = size(EEG.data,2)/EEG.srate; % sec
    max_length = round(time_length) + 1;
    
    % Plot
    if CFG.plot
        CFG.time_step_to_plot = 100; % seconds (controls xticks)
        plot_EEG_data(EEG, CFG)
    end
    
    % Create the neural_features matrix
    CFG.max_num_windows = floor((max_length - window_size)/window_step) + 1;
    neural_features = zeros(CFG.num_features, CFG.max_num_windows);
    
    length = EEG.xmax; % sec
    num_windows = floor((length - window_size)/window_step) + 1;
    
    for window_idx=1:num_windows
        time_start = (window_idx-1)*window_step * 1000; % ms
        time_end = ((window_idx-1)*window_step + window_size) * 1000; % ms
        epoch_boundary = [time_start, time_end]; 
        [mental_conc, visuospatial_att, emotion_state] = neural_correlates(EEG, epoch_boundary);
        neural_features(:, window_idx) = [mental_conc, visuospatial_att, emotion_state];
    end
    figure; plot(squeeze(neural_features(3, :)));
    grid on;
    hold on;
end


