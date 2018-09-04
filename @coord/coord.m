function obj = coord()
    obj = struct;

    cart = struct;
    cart.px = 0.0;
    cart.py = 0.0;
    cart.vx = 0.0;
    cart.vy = 0.0;
    cart.ax = 0.0;
    cart.ay = 0.0;

    pol = struct;
    pol.pr = 0.0;
    pol.pt = 0.0;
    pol.vr = 0.0;
    pol.vt = 0.0;
    pol.ar = 0.0;
    pol.at = 0.0;

    obj.cart = cart;
    obj.pol  = pol;
    
    obj = class(obj, 'coord');

end