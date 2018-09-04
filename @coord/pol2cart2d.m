function ret = pol2cart2d(obj, varargin)
    pol = obj.pol;
    pr = pol.pr; pt = pol.pt;
    vr = pol.vr; vt = pol.vt;
    ar = pol.ar; at = pol.at;

    [px,py] = pol2cart(pt,pr);
    R = [ cos(pt), -sin(pt) ; sin(pt), cos(pt)];
    v = R*[vr ; pr*vt];
    vx = v(1);
    vy = v(2);
    a = R*[ar-pr*vt^2 ; pr*at + 2*vr*vt];
    ax = a(1);
    ay = a(2);

    cart.px = px; cart.py = py;
    cart.vx = vx; cart.vy = vy;
    cart.ax = ax; cart.ay = ay;
    obj.cart = cart;
    ret = obj;
end