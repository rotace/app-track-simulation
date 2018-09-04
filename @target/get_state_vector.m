function ret = get_state_vector(obj)
    addpath('../')
    prm = parameter();
    switch prm.kalman.type
    case '1dim-2state'
        cart = get_cart(obj);
        x = [cart.px;
             cart.vx];
    otherwise
        assert(false)
    end
    ret = x;
end