% Define equipment and its properties
equipment(1, 'Pump', [temperature, vibration, oil_quality, pressure]).
equipment(2, 'Motor', [temperature, current, oil_quality, speed]).
equipment(3, 'Compressor', [temperature, vibration, oil_quality, pressure, flow_rate]).
% Add more equipment as needed...

% Define threshold values for sensor readings
threshold(temperature, 80).
threshold(vibration, 100).
threshold(current, 50).
threshold(oil_quality, poor).
threshold(pressure, 70).
threshold(speed, 500).
threshold(flow_rate, 1000).

% Simulate sensor readings
simulate_sensor_readings(EquipmentID, SensorReadings) :-
    equipment(EquipmentID, _),
    generate_sensor_readings(EquipmentID, SensorReadings).

generate_sensor_readings(_, []).
generate_sensor_readings(EquipmentID, [Reading|Readings]) :-
    random_sensor_reading(EquipmentID, Reading),
    generate_sensor_readings(EquipmentID, Readings).

random_sensor_reading(_, []).
random_sensor_reading(EquipmentID, [Sensor-Value|Rest]) :-
    equipment(EquipmentID, Sensors),
    member(Sensor, Sensors),
    random_sensor_value(Sensor, Value),
    random_sensor_reading(EquipmentID, Rest).

random_sensor_value(temperature, Value) :-
    threshold(temperature, MaxTemp),
    random_between(50, MaxTemp, Value).
random_sensor_value(vibration, Value) :-
    random_between(20, 200, Value).
random_sensor_value(current, Value) :-
    random_between(0, 100, Value).
random_sensor_value(oil_quality, Value) :-
    random_member(Value, [good, fair, poor]).
random_sensor_value(pressure, Value) :-
    random_between(50, 100, Value).
random_sensor_value(speed, Value) :-
    random_between(200, 1000, Value).
random_sensor_value(flow_rate, Value) :-
    random_between(500, 1500, Value).

% Rule-based predictive maintenance logic
predictive_maintenance(EquipmentID) :-
    simulate_sensor_readings(EquipmentID, SensorReadings),
    check_sensor_readings(EquipmentID, SensorReadings).

check_sensor_readings(EquipmentID, SensorReadings) :-
    analyze_temperature(SensorReadings),
    analyze_vibration(SensorReadings),
    analyze_current(SensorReadings),
    analyze_oil_quality(SensorReadings),
    analyze_pressure(SensorReadings),
    analyze_speed(SensorReadings),
    analyze_flow_rate(SensorReadings).

analyze_temperature(SensorReadings) :-
    memberchk(temperature-Temp, SensorReadings),
    threshold(temperature, MaxTemp),
    (Temp > MaxTemp ->
        format('Warning: High temperature detected for equipment ~w. Possible equipment failure risk!~n', [EquipmentID])
    ;
        true
    ).

analyze_vibration(SensorReadings) :-
    memberchk(vibration-Vibration, SensorReadings),
    (Vibration > 100 ->
        format('Maintenance scheduled: Abnormal vibration detected for equipment ~w. Equipment may need attention.~n', [EquipmentID])
    ;
        true
    ).

analyze_current(SensorReadings) :-
    memberchk(current-Current, SensorReadings),
    (Current > 50 ->
        format('Maintenance scheduled: Abnormal current detected for equipment ~w. Equipment may need attention.~n', [EquipmentID])
    ;
        true
    ).

analyze_oil_quality(SensorReadings) :-
    memberchk(oil_quality-OilQuality, SensorReadings),
    (OilQuality == poor ->
        format('Recommendation: Oil quality is poor for equipment ~w. Consider inspecting the equipment.~n', [EquipmentID])
    ;
        true
    ).

analyze_pressure(SensorReadings) :-
    memberchk(pressure-Pressure, SensorReadings),
    (Pressure > 70 ->
        format('Maintenance scheduled: Abnormal pressure detected for equipment ~w. Equipment may need attention.~n', [EquipmentID])
    ;
        true
    ).

analyze_speed(SensorReadings) :-
    memberchk(speed-Speed, SensorReadings),
    (Speed > 500 ->
        format('Maintenance scheduled: Abnormal speed detected for equipment ~w. Equipment may need attention.~n', [EquipmentID])
    ;
        true
    ).

analyze_flow_rate(SensorReadings) :-
    memberchk(flow_rate-FlowRate, SensorReadings),
    (FlowRate > 1000 ->
        format('Maintenance scheduled: Abnormal flow rate detected for equipment ~w. Equipment may need attention.~n', [EquipmentID])
    ;
        true
    ).

% Main entry point
main :-
    predictive_maintenance(1), % Perform predictive maintenance analysis for equipment 1
    predictive_maintenance(2), % Perform predictive maintenance analysis for equipment 2
    predictive_maintenance(3). % Perform predictive maintenance analysis for equipment 3

% Sample execution
:- main.
