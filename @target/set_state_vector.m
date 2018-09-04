function ret = set_state_vector(obj, val)
    addpath('../')
    prm = parameter();
    switch prm.kalman.type
    case '1dim-2state'
        cart = get_cart(obj);
        cart.px = val(1);
        cart.vx = val(2);
        cart.ax = 0.0;
        cart.py = 0.0;
        cart.vy = 0.0;
        cart.ay = 0.0;
        obj = set_cart(obj, cart);
    otherwise
        assert(false)
    end
    ret = obj;
end