function ret = move_straight(obj, dt)
    cart  = get_cart(obj);
    cart.px = cart.px + cart.vx*dt + 0.5*cart.ax*dt^2;
    cart.py = cart.py + cart.vy*dt + 0.5*cart.ay*dt^2;
    cart.vx = cart.vx + cart.ax*dt;
    cart.vy = cart.vy + cart.ay*dt;
    obj   = set_cart(obj, cart);
    ret   = obj;
end