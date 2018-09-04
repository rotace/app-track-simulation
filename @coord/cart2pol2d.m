function ret = cart2pol2d(obj, varargin)
    cart = obj.cart;
    px = cart.px; py = cart.py;
    vx = cart.vx; vy = cart.vy;
    ax = cart.ax; ay = cart.ay;

    [pt,pr] = cart2pol(px,py);
    R  = [ cos(pt), sin(pt) ; -sin(pt), cos(pt)];
    v  = R*[vx;vy];
    vr = v(1);
    vt = v(2)/pr;
    a  = R*[ax;ay];
    ar =  a(1) +  pr*vt^2;
    at = (a(2) -2*vr*vt)/pr;

    pol.pr = pr; pol.pt = pt;
    pol.vr = vr; pol.vt = vt;
    pol.ar = ar; pol.at = at;
    obj.pol = pol;
    ret = obj;
end