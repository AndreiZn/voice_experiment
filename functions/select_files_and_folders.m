function CFG = select_files_and_folders(CFG)

if CFG.load_existing_datasets % eeglab-type datasets were already created before
    %% Select a folder with existing datasets       
    CFG.eeglab_type_datasets_folder = uigetdir('./','Select a folder with eeglab-type datasets...');
    files = dir(CFG.eeglab_type_datasets_folder);
    dirflag = ~[files.isdir] & ~strcmp({files.name},'..') & ~strcmp({files.name},'.');
    for idx = 1:size(files,1)
        filename = files(idx).name;
        if size(filename,2) > 4 % *.set or *.fdt
            if strcmp(filename(end-2:end), 'fdt')
                dirflag(idx) = 0;
            end
        end
    end
    CFG.eeglab_type_data_files = files(dirflag);
    CFG.num_sessions = size(CFG.eeglab_type_data_files,1);
    fprintf('Number of data files found is: %d \n', CFG.num_sessions);
else
    %% Select a folder with data files
    CFG.root_dir = uigetdir('./','Select a root folder with data files...');

    files = dir(CFG.root_dir);
    dirflag = ~[files.isdir] & ~strcmp({files.name},'..') & ~strcmp({files.name},'.');
    CFG.data_files = files(dirflag);
    CFG.num_sessions = size(CFG.data_files,1);
    fprintf('Number of data files found is: %d \n', CFG.num_sessions);
    %% Select a folder for output files
    CFG.output_folder = uigetdir('./','Select an output folder...');

    %% Select a channel location file
    [name,path] = uigetfile({'*.ced;*.locs'},'Pick channel location file ...');
    CFG.channel_location_file = fullfile(path,name);
end