function ret = parameter()
    ret = struct;
    

    ret.radar.Ts = 1.0;

    ret.graph = struct;


    ret.kalman = struct;
    ret.kalman.type = '1dim-2state';
    switch ret.kalman.type
    case '1dim-2state'
        ret.kalman.dsigv  =  1; % [m/s]
        ret.kalman.sigpx0 = 10; % [m]
        ret.kalman.sigvx0 =  5; % [m/s] 
        ret.kalman.sig0   =  5; % [m]
        ret.kalman.P0 = [ret.kalman.sigpx0^2, 0.0;
                         0.0, ret.kalman.sigvx0^2];
        ret.kalman.Phi= [1.0, ret.radar.Ts;
                         0.0, 1.0];
        ret.kalman.H  = [1.0, 0.0];
        ret.kalman.Q  = [0.0, 0.0;
                         0.0, ret.kalman.dsigv^2];
        ret.kalman.R  = ret.kalman.sig0^2;

    otherwise
        assert(false)
    end
end