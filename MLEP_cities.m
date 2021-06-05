%% Preamble
% This script recursively calls the following nine scripts:
%     MLEP_test_off
%     MLEP_test_on
%     MLEP_test_cond_timed
%     MLEP_test_cond_timed_aft
%     MLEP_test_cond_isr
%     MLEP_test_random
%     MLEP_test_random_db
%     MLEP_test_cond
%     MLEP_test_cond_db
    
% Before running,:
    %-> Comment out 'Object' sections in subsidiary scripts
    %-> Comment out 'Plot' sections in subsidiary scripts
    
% t_computation_start = cputime;

%% Object
ep1 = mlep;
ep2 = mlep;

%% Month Selection - (manually uncomment desired file)
cd 'O:\Documents\ENGS88\EP_Models\ED_9.2_model'
    %% May
    ep1.idfFile = '040521_Single_NoSunspace_Rooftop_EPLUS_V920_NatVent_IdealLoads.idf';
    %% July
    %ep1.idfFile = '040521_Single_NoSunspace_Rooftop_EPLUS_V920_NatVent_IdealLoads_jul.idf';
    %% October
    %ep1.idfFile = '040521_Single_NoSunspace_Rooftop_EPLUS_V920_NatVent_IdealLoads_oct.idf';

ep2.idfFile = ep1.idfFile;

%% Location Selection Loop
    location_names = {
        'Phoenix, AZ'
        'San Diego, CA'
        'Broomfield (Denver), CO'
        'Chicago, IL'
        'New Orleans, LA'
        'Albany, NY'
        'Eugene, OR'
        };
    
    variable_names = {
        'No Shade [J]'
        'Full Shade [J]'
        'Timed Shade (10a-4p) [J]'
        'Timed Shade (2p-8p) [J]'
        'Perfect Shade (incident solar)'
        'Random Shade [J]'
        'Random Shade with 60min delay [J]'
        'Perfect Shade (heat flux) [J]'
        'Perfect Shade with 60min delay (heat flux) [J]'
        };
    
    locations = {
        'USA_AZ_Phoenix-Sky.Harbor.Intl.AP.722780_TMYx.2004-2018.epw'
        'USA_CA_San.Diego.Intl.AP-Lindbergh.Field.722900_TMYx.2004-2018.epw'
        'USA_CO_Broomfield-Rocky.Mountain.Metro.AP.724699_TMYx.2004-2018.epw'
        'USA_IL_Chicago.OHare.Intl.AP.725300_TMYx.2004-2018.epw'
        'USA_LA_New.Orleans-Lakefront.AP.722315_TMYx.2004-2018.epw'
        'USA_NY_Albany.Intl.AP.725180_TMYx.2004-2018.epw'
        'USA_OR_Eugene.AP-Sweet.Field.726930_TMYx.2004-2018.epw'
        };

%% Loop

    CLT = zeros(numel(locations),9);
    NHGR = zeros(numel(locations),9);
    
    for i = 1:numel(locations)
        cd 'O:\Documents\ENGS88\EP_Models\Weather Files'
        ep1.epwFile = locations{i};
        ep2.epwFile = ep1.epwFile;
        
        cd 'O:\Documents\ENGS88\MATLAB_Scripts'

        MLEP_test_off
        disp("*****")
        disp("1")
        disp("*****")
        MLEP_test_on
        disp("*****")
        disp("2")
        disp("*****")
        MLEP_test_cond_timed
        disp("*****")
        disp("3")
        disp("*****")
        MLEP_test_cond_timed_aft
        disp("*****")
        disp("4")
        disp("*****")
        MLEP_test_cond_isr
        disp("*****")
        disp("5")
        disp("*****")
        MLEP_test_random
        disp("*****")
        disp("6")
        disp("*****")
        MLEP_test_random_db
        disp("*****")
        disp("7")
        disp("*****")
        MLEP_test_cond
        disp("*****")
        disp("8")
        disp("*****")
        MLEP_test_cond_db
        disp("*****")
        disp("9")
        disp("*****")
        
        ep1.release;
        ep2.release;
        
        CLT(i,:) = [CLT_OFF]; %CLT_ON CLT_T CLT_TA CLT_I CLT_R CLT_R_db CLT_H CLT_H_db];
        NHGR(i,:) = [NHGR_OFF]; %NHGR_ON NHGR_T NHGR_TA NHGR_I NHGR_R NHGR_R_db NHGR_H NHGR_H_db];
        
        disp('*****************')
        disp('*****************')
        disp("LOCATION COMPLETE:")
        disp(location_names{i})
        disp('*****************')
        disp('*****************')
    end
    
CLT_table = array2table(CLT,'VariableNames',variable_names,...
    'RowNames',location_names);

NHGR_table = array2table(NHGR,'VariableNames',variable_names,...
    'RowNames',location_names);

cd 'O:\Documents\ENGS88'

%% Computation Time
%     t_computation_end = cputime;
%     t_computation = (t_computation_end-t_computation_start)/60; % [minutes]
