function ret = set_pol(obj, pol)
    coord = obj.coord.set('pol', pol);
    ret = set(obj, 'coord', coord);
end