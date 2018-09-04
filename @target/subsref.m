function varargout = subsref (obj, idx)

    persistent __method__ method4field typeNotImplemented
    if isempty(__method__)

        __method__ = struct();

        __method__.plot_target = @(o,varargin) plot_target (o, varargin{:});
        __method__.get = @(o,varargin) get (o, varargin{:});
        __method__.set = @(o,varargin) set (o, varargin{:});
        __method__.get_cart = @(o)       get_cart (o);
        __method__.set_cart = @(o, cart) set_cart (o, cart);
        __method__.get_pol  = @(o)       get_pol  (o);
        __method__.set_pol  = @(o, pol ) set_pol  (o, pol );
        __method__.move     = @(o, t   ) move     (o, t);
        __method__.get_state_vector=@(o) get_state_vector(o);
        __method__.get_covar_matrix=@(o) get_covar_matrix(o);
        __method__.set_state_vector=@(o,v) set_state_vector(o,v);
        __method__.set_covar_matrix=@(o,v) set_covar_matrix(o,v);

        % Error strings
        method4field = 'Class #s has no field #s. Use #s() for the method.';
        typeNotImplemented = '#s no implemented for class #s.';

    end

    if ( !strcmp (class (obj), 'target') )
        error ('Object must be of the target class but "#s" was used', class (obj) );
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
