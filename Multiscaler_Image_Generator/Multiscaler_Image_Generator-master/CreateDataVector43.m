%% Script info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File name: "CreateDataVector43.m"                            %
% Purpose: Reads the hex_data vector that was created          %
% by LSTDataRead.m and creates a photon table of that          %
% measurement. Only reads the time_patch == 43 data.           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

function [Final_Dataset] = CreateDataVector43(Raw_Data, Data_Channel_Num, Range)
%% Check input
if ((Data_Channel_Num ~= 1) && (Data_Channel_Num ~= 2) && (Data_Channel_Num ~= 6)) % Wrong input
    error('Data channel is incorrect. Can be only 1, 2 or 6 (START)');
end

%% Photon data allocation
switch Data_Channel_Num
    case 1
        helpstr = repmat('001', size(Raw_Data, 1), 1) == Raw_Data(:,62:64); % helpstr locates the rows in which the wanted data channel was read
        Data_Readings = Raw_Data((sum(helpstr, 2) == 3),1:60); % creates a vector only containing wanted data
        TAG_Bits = bin2dec(Data_Readings(:,2:16)); % reads TAG bits data and converts it to decimal
        Time_of_Arrival = bin2dec(Data_Readings(:,17:60)); % reads timestamp data and converts it to decimal
    case 2
        helpstr = repmat('010', size(Raw_Data, 1), 1) == Raw_Data(:,62:64); % helpstr locates the rows in which the wanted data channel was read
        Data_Readings = Raw_Data((sum(helpstr, 2) == 3),1:60); % creates a vector only containing wanted data
        TAG_Bits = bin2dec(Data_Readings(:,2:16)); % reads TAG bits data and converts it to decimal
        Time_of_Arrival = bin2dec(Data_Readings(:,17:60)); % reads timestamp data and converts it to decimal
    case 6
        helpstr = repmat('110', size(Raw_Data, 1), 1) == Raw_Data(:,62:64); % helpstr locates the rows in which the wanted data channel was read
        Data_Readings = Raw_Data((sum(helpstr, 2) == 3),1:60); % creates a vector only containing wanted data
        TAG_Bits = bin2dec(Data_Readings(:,2:16)); % reads TAG bits data and converts it to decimal
        Time_of_Arrival = bin2dec(Data_Readings(:,17:60)); % reads timestamp data and converts it to decimal      
end

%% Send out the data table
Data_Lost = Data_Readings(:,1);
Final_Dataset = table(Time_of_Arrival, TAG_Bits, Data_Lost);

end