function varargout = subsref (obj, idx)

    persistent __method__ method4field typeNotImplemented
    if isempty(__method__)

        __method__ = struct();

        __method__.get = @(o,varargin) get (o, varargin{:});
        __method__.set = @(o,varargin) set (o, varargin{:});

        % Error strings
        method4field = 'Class #s has no field #s. Use #s() for the method.';
        typeNotImplemented = '#s no implemented for class #s.';

    end

    if ( !strcmp (class (obj), 'coord') )
        error ('Object must be of the coord class but "#s" was used', class (obj) );
    elseif ( idx(1).type != '.' )
        error ('Invalid index for class #s', class (obj) );
    end

    method = idx(1).subs;
    if ~isfield(__method__, method)
        error('Unknown method #s.',method);
    else
        fhandle = __method__.(method);
    end

    if numel (idx) == 1 # can't access properties, only methods

        error (method4field, class (obj), method, method);

    end

    if strcmp (idx(2).type, '()')

        args = idx(2).subs;
        if isempty(args)
        out = fhandle (obj);
        else
        out = fhandle (obj, args{:});
        end

        varargout{1} = out;

    else

        error (typeNotImplemented,[method idx(2).type], class (obj));

    end

end
