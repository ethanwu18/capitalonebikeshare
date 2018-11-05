function [distance] = latLongtoDistance(lat1, lat2, lon1, lon2)
%latLongtoDistance: calculates the distance given a starting and ending
%latitudes and longitudes
%Haversine formula source: https://www.mathworks.com/matlabcentral/fileexchange/38812-latlon-distance
%   Input: vectors for starting and ending latitudes and longitudes
%   Output: distance between start and end
radius=6371;
lat1=lat1*pi/180;
lat2=lat2*pi/180;
lon1=lon1*pi/180;
lon2=lon2*pi/180;
deltaLat=lat2-lat1;
deltaLon=lon2-lon1;
a=sin((deltaLat)./2).^2 + cos(lat1).*cos(lat2) .* sin(deltaLon./2).^2;
c=2.*atan2(sqrt(a),sqrt(1-a));
distance = radius.*c;    %Haversine distance
end

