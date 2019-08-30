minmax = [min(min(y(2:33, 7000:end-3000))), max(max(y(2:33, 7000:end-3000)))];
topoplot(y(2:33,17000), locs, 'maplimits', minmax, 'electrodes', 'off')