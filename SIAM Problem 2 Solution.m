format long
pos = [.5;.1];
vel = [1;0];
bool = zeros(2,1);
remTime = 10;

while remTime > 0
    lat = round(pos + 2*vel/3);
    syms s
    f = dot((pos + s*vel - lat),(pos + s*vel - lat));
    soln = double(solve( f == 1/9, s));
    if(isempty(soln))
        forTime = Inf;
    elseif(~any(soln > 0))
        forTime = Inf;
    else
        ind = soln > bool;
        forTime = min(soln(ind));
    end
    if forTime < remTime
        pos = pos + forTime*vel;
        z = pos - lat;
        newDir = dirChange(z(1),z(2));
        vel = newDir*vel;
    else
        forTime = min(remTime, 2/3);
        pos = pos + forTime*vel;
    end
    remTime = remTime - forTime;
end
norm(pos)
        