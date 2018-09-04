function obj = target()
    obj = struct();
    addpath('../')
    obj.coord = coord();
    obj.motion_type = 'straight';
    obj.lt = 0.0; % last time
    obj.ht = [];
    obj.covmat = [];
    obj = class(obj, 'target');
end