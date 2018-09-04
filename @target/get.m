function ret = get (obj,varargin)

    accepted = fieldnames (obj);
  
    tf = ismember (tolower (accepted), tolower (varargin));
  
    retrieve = {accepted{tf}};
    n = numel (retrieve);
    if n == 1
      ret = obj.(retrieve{1});
    else
      for i=1:n
        ret.(retrieve{i}) = obj.(retrieve{i});
      end
    end
  
    unknown = {varargin{!ismember (varargin,accepted)}};
    cellfun (@(x) warning ('Unknown field %s\n', x) , unknown);
  
end