function [X, Y] = calc_ellipse(a,b,theta)
    t=0:pi/18:2*pi;
    R=[cos(theta), -sin(theta); sin(theta), cos(theta)]
    M=R*[a*cos(t); b*sin(t)];
    X=M(1,:);
    Y=M(2,:);
end