function ret = set_cart(obj, cart)
    coord = obj.coord.set('cart', cart);
    ret = set(obj, 'coord', coord);
end