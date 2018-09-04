function ret = set (obj, varargin)

    if (numel (varargin) < 2 || rem (numel (varargin), 2) != 0)
    error ('@coord/set: expecting PROPERTY/VALUE pairs');
    end

    ret = obj;
    while (numel (varargin) > 1)
        prop = varargin{1};
        val  = varargin{2};
        varargin(1:2) = [];
        assert( ischar(prop) )
        switch prop
        case 'coord'
            obj.coord = val;
            obj = plot_target(obj);
        otherwise
            assert(false)
        end
    end
    ret = obj;
end