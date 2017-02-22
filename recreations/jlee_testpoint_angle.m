function angle = jlee_testpoint_angle(test_point, roots_var, poles_var)

[num_roots, ~] = size(roots_var);
[num_poles, ~] = size(poles_var);

angle = 0;

for k = 1:num_roots
    
    current_root = squeeze(roots_var(k, :));
    angle = angle + atan2((test_point(2) - current_root(2)), (test_point(1) - current_root(1)))*180/pi;
 
end

for k = 1:num_poles
    
    current_pole = squeeze(poles_var(k, :));
    angle = angle - atan2((test_point(2) - current_pole(2)), (test_point(1) - current_pole(1)))*180/pi;
        
end

end