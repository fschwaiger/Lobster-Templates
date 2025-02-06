classdef LIncludeNode < LNode
    %LINCLUDENODE Includes a template from another file.
    %
    %    {% include "myfile.template" %}
    %    {% include dynamic_filename_expression %}
    %
    % See also LFileTemplate
    
    properties
        Expression (1,1) string
    end
    
    methods
        function self = LIncludeNode(fragment)
            self@LNode(fragment);
            self.Expression = fragment.Text;
        end
        
        function str = render(self, context)
            filename = string(evalin_struct(self.Expression, context));

            if not(endsWith(filename, ".template"))
                filename = filename + ".template";
            end
            
            try
                template = LFileTemplate(filename);
            catch
                str = "";
                return
            end
            
            str = template.render(context);
        end
    end
end
