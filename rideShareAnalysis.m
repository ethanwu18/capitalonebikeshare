%% Load Data
[~, ~, raw] = xlsread("metro-bike-share-trip-data.csv");
%% Data Analysis
%Most Common Stations
startStations = cell2mat(raw(2:end, 5));
endStations = cell2mat(raw(2:end, 8));
mostStart = mode(startStations);
mostEnd = mode(endStations);
fprintf("Most Common Starting Station: %d\nMost Common Ending Station: %d\n", mostStart, mostEnd);

%Average Distance Travelled Calcualations

tripType = raw(2:end, 13);
timeVec = cell2mat(raw(2:end, 2))./3600; %in hours
positionVec = [cell2mat(raw(2:end, 6)),cell2mat(raw(2:end, 7)),cell2mat(raw(2:end, 9)),cell2mat(raw(2:end, 10))];
roundTripIndex = ismember(tripType,'Round Trip');
oneWayIndex = abs(roundTripIndex - 1);
oneWayTimeVec = timeVec(oneWayIndex == 1, :);
oneWayVec = positionVec(oneWayIndex == 1, :);
oneWayDistanceVec = latLongtoDistance(oneWayVec(:, 1), oneWayVec(:, 3), oneWayVec(:, 2), oneWayVec(:, 4));
oneWayRateVec = uint32(oneWayDistanceVec ./ oneWayTimeVec);
oneWayAvgRate = mean(oneWayRateVec);
roundTripDistanceVec = timeVec(roundTripIndex == 1) * oneWayAvgRate;
avgDistance = mean([uint32(roundTripDistanceVec); uint32(oneWayDistanceVec)]);
fprintf("Average Distance Travelled: %f\n", avgDistance);

%Number of People Who Use Bike Sharing for Regular Commute

% Narrow down to those who have Monthly/Yearly Passes
% Find all one way riders from 6-9 AM
% Average commuters for all weekdays in the data set.

