
% filename = fullfile(matlabroot,'examples','matlab','hard_traj.txt');
% 
% T = readtable(filename,...
%     'Delimiter',' ','ReadVariableNames',false);

T = readtable('hard_traj.xlsx');
T = T{:,:};
x = T(:,1);
y = T(:,2);
z = T(:,3);
position = [x y z]';
position = reshape(position,3,max(size(position)));
position = position';

xt = T(:,5);
yt = T(:,6);
zt= T(:,7);
wt = T(:,4);
quat = [xt yt zt wt];
attitude = quat2eul(quat);%theta_phi_psi
attitude = reshape(attitude,3,max(size(attitude)));
attitude = attitude';
u = T(:,8);
v = T(:,9);
w = T(:,10);
velocity = [u v w]';
velocity = reshape(velocity,3,max(size(velocity)));
% velocity = velocity';

p = T(:,11);
q = T(:,12);
r = T(:,13);
attitudedot = [p q r]';                                                                      
attitudedot = reshape(attitudedot,3,max(size(attitudedot)));
attitudedot = attitudedot';

for ii = 1:2307
ti(ii,1) = 0.00 + (ii-1)*3; 
end 
% ti = ti';
% 

State = [ti position attitude velocity' attitudedot];

All_STATE_VARIABLE;
% time = All_STATE_VARIABLE.ATTITUDE.Time;	
phi_theta_psi = All_STATE_VARIABLE.ATTITUDE.Data;
u_v_w = All_STATE_VARIABLE.V_BODY.Data;
u_v_w_NEW = reshape(u_v_w,3,max(size(u_v_w)));
u_v_w = u_v_w_NEW;
p_q_r = All_STATE_VARIABLE.OMEGA_BODY.Data;
x_y_z = All_STATE_VARIABLE.POS.Data;
x_y_z_NEW = reshape(x_y_z,3,max(size(x_y_z)));
% x_y_z = x_y_z_NEW;


NAME = {'\phi','\theta','\psi'};
for ii = 1:3
    figure(ii)
    plot(ti,attitude(:,ii), 'g-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('deg [\circ]')
    hold on
    plot(ti,phi_theta_psi(:,ii), 'r-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('deg [\circ]')
    hold off
end

%%
NAME = {'u','v','w'};
for ii = 1:3
    figure(ii+3)
    plot(ti,velocity(ii,:), 'g-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[m/sec]')
    hold on
    plot(ti,u_v_w(ii,:), 'r-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[m/sec]')
    hold off
end
%%
NAME = {'p','q','r'};
for ii = 1:3
    figure(ii+6)
    plot(ti,attitudedot(:,ii), 'g-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[rad /sec]')
    hold on
    plot(ti,p_q_r(:,ii), 'r-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[rad /sec]')
    hold off
end
%%
NAME = {'x','y','z'};
for ii = 1:3
    figure(ii+9)
    plot(ti,position(:,ii) , 'g-')
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[meters]')
    hold on
    plot(ti,x_y_z(ii,:), 'r-')
%     plot(time,DIFF (ii,:), 'r-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[meters]')
    hold off
end