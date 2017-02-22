classdef jlee_pcn < handle
    
    properties (Access = 'protected')
        nInputs;
        nOutputs;
    end
    
    properties(GetAccess = 'public', SetAccess = 'protected')
        nData;
        weights;
        mu;
        sigma;
        gate_enum = 'threshold';
    end
    
    methods
        
        function obj = jlee_pcn(iData, oData, gate_enum)
            if (nargin > 0)
                try
                    
                    [obj.nData, obj.nInputs] = size(iData);
                    [~, obj.nOutputs] = size(oData);
                    obj.weights = (2*rand(obj.nInputs + 1, obj.nOutputs) - 1)/sqrt(obj.nInputs);
                    obj.mu = mean(iData, 1);
                    obj.sigma = std(iData, 1, 1);

                    obj.gate_enum = gate_enum;
                    
                catch ME
                end
            else
            end
        end
        
        function gate_output = gatingtype(obj, oData, outtype)
            switch outtype
                case 'linear'
                    gate_output = oData;
                case 'threshold'
                    gate_output = double(oData > 0);
                case 'logistic'
                    gate_output = sigmf(oData,[1 0]);
                case 'softmax'
                    gate_output = softmax(oData);
                otherwise
            end
        end
        
        function [C, percent_correct] = confmat(obj, y, y_hat)
            
            y_new = zeros(size(y, 1), 1);
            y_hat_new = zeros(size(y_hat, 1), 1);
            num_values = size(y_hat, 2);
            for k = 1:num_values
                y_new(y(:, k) == 1) = k;
                y_hat_new(y_hat(:, k) == 1) = k;
            end
            
            C = confusionmat(y_new, y_hat_new);
            percent_correct = trace(C)/sum(C(:));
            disp(C);
            disp(percent_correct);
        end
        
        function [iData_mdf] = meandev(obj, iData, exclusion)
            try
                switch nargin
                    case 2
                        iData_mean = bsxfun(@minus, iData, obj.mu);
                        iData_mdf = bsxfun(@rdivide, iData_mean, obj.sigma);
                    case 3
                        included_columns = logical(ones(obj.nInputs, 1));
                        included_columns(exclusion) = logical(0);
                        iData_initialized = iData(:, included_columns);
                        iData_mean = bsxfun(@minus, iData_initialized, obj.mu(included_columns));
                        iData_mdf2 = bsxfun(@rdivide, iData_mean, obj.sigma(included_columns));
                        iData_mdf = iData;
                        iData_mdf(:, included_columns) = iData_mdf2;
                    otherwise
                end
            catch ME
            end
        end
        
        function current_outputs = pcnfwd(obj, iData)
            
            if (iData(:, 1) == 1)
            else
                iData = [ones(size(iData, 1), 1) iData];
            end
            
            intermediate = iData*obj.weights;
            current_outputs = obj.gatingtype(intermediate, obj.gate_enum);
        end
        
        function [current_oData, C_instance, percent_correct_instance] = pcntrain(obj, iData, oData, eta, nIterations)
            iData_bias = [ones(obj.nData, 1) iData];
            
            for i = 1:nIterations
                current_oData = obj.pcnfwd(iData_bias);
                obj.weights = obj.weights - eta*iData_bias.'*(current_oData - oData);
            end
            
            [C_instance, percent_correct_instance] = obj.confmat(oData, current_oData);
        end
        
    end
    
end