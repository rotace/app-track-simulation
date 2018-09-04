
clear; close all;
addpath('tool')
global g_graph_update
g_graph_update = true;
prm = parameter();

detect_list={};
undetct_list={};
track_list={};

% initialize graph
graph.draw_time = prm.radar.Ts;
graph.pause_time = 0.1;
hold on
grid on
pbaspect([1,1,1])
graph.xlim=[  900, 1100];
graph.ylim=[ -100,  100];
% graph.hrdlc=plot(graph.xlim.*1, graph.xlim.*0, 'k--'); % radar direct line center
% graph.hrdll=plot(graph.xlim.*1, graph.xlim.*0, 'r-' ); % radar direct line left
% graph.hrdlr=plot(graph.xlim.*1, graph.xlim.*0, 'r-' ); % radar direct line right
xlim(graph.xlim)
ylim(graph.ylim)

% parameter
radar.Ts = prm.radar.Ts;


% real target
rtgt1 = target();
rtgt2 = target();
rtgt1 = rtgt1.plot_target('r*');
rtgt2 = rtgt2.plot_target('b*');

cart = rtgt1.get_cart();
cart.px = 1050; % [m]
cart.py = 0;    % [m]
cart.vx = 0;  % [m/s]
cart.vy = 0;    % [m/s]
rtgt1 = rtgt1.set_cart(cart);

cart = rtgt2.get_cart();
cart.px = 950; % [m]
cart.py = 0;    % [m]
cart.vx = 0;  % [m/s]
cart.vy = 0;    % [m/s]
rtgt2 = rtgt2.set_cart(cart);

rtgts = {rtgt1, rtgt2};

for nowtime = 0:radar.Ts:10

    % initialize
    for k = 1:length(detect_list)
        delete(detect_list{1,k}.get('ht')) % delete graph marker
    end
    detect_list = {};
    undetect_list = {};


    % ### detection ###
    for rtgt = rtgts
        rtgt = rtgt{1};
        ocrd = rtgt.get('coord');
        opol = ocrd.get('pol');
        opol.pr = opol.pr + prm.kalman.sigpx0 * randn(1);
        opol.pt = opol.pt;
        opol.vr = opol.vr + prm.kalman.sigvx0 * randn(1);
        opol.vt = 0; % not sensed
        opol.ar = 0; % not sensed
        opol.at = 0; % not sensed
        ocrd = ocrd.set('pol', opol);

        otgt = target();
        otgt = otgt.plot_target('ko', ...
                                'MarkerSize', 10);
        otgt = otgt.set('coord', ocrd);
        flag = struct;
        flag.associated = false;
        detect_list = [detect_list, {otgt; flag}];
    end

    n_detect = columns(detect_list);
    n_track  = columns(track_list);

    for j_track = 1:n_track
        lstgt  = track_list{1, j_track}; % last smoothed target : x(k|k-1)
        ltime  = lstgt.get('lt');
        dt = nowtime - ltime;

        % ### assosiation ###
        i_detect = j_track;
        cotgt  = detect_list{1, i_detect}; % current observed target : y(k)
        flag   = detect_list{2, i_detect};

        % ### predicton and filtering ###
        Phi  = prm.kalman.Phi;
        H    = prm.kalman.H;
        Q    = prm.kalman.Q;
        R    = prm.kalman.R;
        x_ls = lstgt.get_state_vector();    % x(k-1|k-1) smoothed  vec.
        P_ls = lstgt.get_covar_matrix();    % P(k-1|k-1) smoothed  cov. mat.
        y_co = cotgt.get_state_vector();    % y(k)       obsereved vec.
        x_cp = Phi * x_ls;                  % x(k|k-1)   predicted vec.
        P_cp = Phi * P_ls * Phi' + Q;       % P(k|k-1)   predicted cov. mat.
        k_c  = P_cp*H' * inv(H*P_cp*H' + R);% K(k)       kalman gain
        x_cs = x_cp + k_c' *(y_co - H*x_cp);% x(k|k)     smoothed  vec.
        I    = eye(size(P_cp));
        P_cs = (I - k_c*H)*P_cp;            % P(k|k)     smoothed  cov. mat.

        cstgt = target();
        cstgt = cstgt.set_state_vector(x_cs);
        cstgt = cstgt.set_covar_matrix(P_cs);

        % ### track file mentainance ###
        flag.associated = true;
        track_list (:, j_track ) = {cstgt; flag};
        detect_list{2, i_detect} = flag;
    end

    % add new track
    unused_list = {};
    for i_detect = 1:n_detect
        [cotgt, flag] = detect_list{:, i_detect};
        if ~flag.associated
            unused_list = [unused_list, {cotgt; flag}];
        end
    end
    track_list = [track_list, unused_list];
    if isempty(track_list)
        track_list = {};
    end

    % plot and pause
    if g_graph_update
        drawnow
    end
    
    % target move
    for k = 1:length(rtgts)
        rtgts{k} = rtgts{k}.move(nowtime);
    end

    % plot
    if g_graph_update
        drawnow
        pause(graph.pause_time)
    end

    % set plot flag
    if mod( nowtime , graph.draw_time ) == 0.0
        g_graph_update = true;
    else
        g_graph_update = false;
    end

end