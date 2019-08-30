function plot_EEG_data(EEG, CFG)
    srate = EEG.srate;
    eegplot('noui', EEG.data, 'winlength', size(EEG.data,2)/srate, 'srate', srate, 'spacing', max(mean(EEG.data,2) + 3*std(EEG.data,[],2)), 'eloc_file', CFG.channel_location_file);
    fig = gcf;
    chldrn = fig.Children; 
    ax = chldrn(3);
    xticks(ax, 0:srate*CFG.time_step_to_plot:size(EEG.data,2));
    xticklabels(ax, 0:CFG.time_step_to_plot:size(EEG.data,2)/srate);
    grid on;
    %saveas(fig,[conf.output_dir, '\', conf.subject,'_',conf.curr_dev,'_', conf.exp_num, '_plot','.png'])
    %close(gcf)