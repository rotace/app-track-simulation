function ret = plot_target(obj, varargin)
    global g_graph_update
    addpath('../')
    prm = parameter();

    if isempty(obj.ht)
        obj.ht = plot(0.0, 0.0, varargin{:});

    elseif g_graph_update
        cart = get_cart(obj);
        set(obj.ht, {'XData', 'YData'}, {cart.px, cart.py})
    end
    ret  = obj;
end