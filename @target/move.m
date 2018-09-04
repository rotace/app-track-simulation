function ret = move(obj, t)
    assert( t >= obj.lt )
    dt = t-obj.lt;
    switch obj.motion_type
    case 'straight'
        obj = move_straight(obj, dt);
    otherwise
        assert(false)
    end
    obj = plot_target(obj);
    obj.lt = t;
    ret = obj;
end