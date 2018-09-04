function ret = get_covar_matrix(obj)
    addpath('../')
    prm = parameter();
    if isempty(obj.covmat)
        switch prm.kalman.type
        case '1dim-2state'
            obj.covmat = prm.kalman.P0;
        otherwise
            assert(false)
        end
    end
    ret = obj.covmat;
end