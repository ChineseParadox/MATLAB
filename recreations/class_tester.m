classdef class_tester < handle

    properties
        a;
    end
    
    methods
        function obj = class_tester(a)
            obj.a = a;
        end
        
        function obj = change_a(obj, a_new)
            obj.a = a_new;
        end
        
        function obj = change_a_auto(obj)
            obj.a = rand(1);
        end
    end
end