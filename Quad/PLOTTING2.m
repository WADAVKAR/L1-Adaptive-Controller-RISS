
% filename = fullfile(matlabroot,'examples','matlab','hard_traj.txt');
% 
% T = readtable(filename,...
%     'Delimiter',' ','ReadVariableNames',false);
G = readtable('grtruth.xlsx');
G = G{:,:};
xg = G(:,1);
yg = G(:,2);
zg = G(:,3);
positiong = [xg yg zg]';
positiong = reshape(positiong,3,max(size(positiong)));
positiong = positiong';

T = readtable('hard_traj.xlsx');
T = T{:,:};
x = T(:,1);
y = T(:,2);
z = T(:,3);
position = [x y z]';
position = reshape(position,3,max(size(position)));
position = position';
%%%%%%%%%%%%%%%
xtg = G(:,5);
ytg = G(:,6);
ztg= G(:,7);
wtg = G(:,4);
quatg = [wtg xtg ytg ztg];
attitudeg = quat2eul(quatg);%theta_phi_psi
attitudeg = reshape(attitudeg,3,max(size(attitudeg)));
attitudeg = attitudeg';

xt = T(:,5);
yt = T(:,6);
zt= T(:,7);
wt = T(:,4);
quat = [wt xt yt zt];
attitude = quat2eul(quat);%theta_phi_psi
attitude = reshape(attitude,3,max(size(attitude)));
attitude = attitude';
%%%%%%%%%%%%%%%

ug = G(:,8);
vg = G(:,9);
wg = G(:,10);
velocityg = [ug vg wg]';
velocityg = reshape(velocityg,3,max(size(velocityg)));
% velocity = velocity';

u = T(:,8);
v = T(:,9);
w = T(:,10);
velocity = [u v w]';
velocity = reshape(velocity,3,max(size(velocity)));
% velocity = velocity';
%%%%%%%%%%%%%%%

pg = G(:,11);
qg = G(:,12);
rg = G(:,13);
attitudegdot = [pg qg rg]';                                                                      
attitudegdot = reshape(attitudegdot,3,max(size(attitudegdot)));
attitudegdot = attitudegdot';

p = T(:,11);
q = T(:,12);
r = T(:,13);
attitudedot = [p q r]';                                                                      
attitudedot = reshape(attitudedot,3,max(size(attitudedot)));
attitudedot = attitudedot';

for ii = 1:3230
tgi(ii,1) = 0.00 + (ii-1)/100; 
end 

for ii = 1:2307
ti(ii,1) = 0.00 + (ii-1)/100; 
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

% P = [1 2 3; 4 5 6; 1 3 5; 2 6 9] ;
% [nx,ny] = size(position) ;
% figure
% hold on
% for i = 1:nx-1
%     v=[position(i,:);position(i+1,:)];
%     plot3(v(:,1),v(:,2),v(:,3),'r')
% end
NAME = {'\phi','\theta','\psi'};
for ii = 1:3
    figure(ii)
    plot(ti,attitude(:,ii), 'g-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('deg [\circ]')
    hold on
    plot(ti,phi_theta_psi(:,ii), 'r-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('deg [\circ]')
    hold on
    plot(tgi,attitudeg(:,ii), 'b-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('deg [\circ]')
    hold off
    legend('Reference Trajectory','L1AC Output', 'MPC Output')
end

%%
NAME = {'u','v','w'};
for ii = 1:3
    figure(ii+3)
    plot(ti,velocity(ii,:), 'g-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[m/sec]')
    hold on
    plot(ti,u_v_w(ii,:), 'r-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[m/sec]')
    hold on
    plot(tgi,velocityg(ii,:), 'b-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[m/sec]')
    hold off
    legend('Reference Trajectory','L1AC Output', 'MPC Output')
end
%%
NAME = {'p','q','r'};
for ii = 1:3
    figure(ii+6)
    plot(ti,attitudedot(:,ii), 'g-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[rad /sec]')
    hold on
    plot(ti,p_q_r(:,ii), 'r-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[rad /sec]')
    hold on
    plot(tgi,attitudegdot(:,ii), 'b-','LineWidth',2)
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[rad /sec]')
    hold off
    legend('Reference Trajectory','L1AC Output', 'MPC Output')
end
%%
NAME = {'x','y','z'};
for ii = 1:3
    figure(ii+9)
    plot(ti,position(:,ii) , 'g-','LineWidth',2)
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[meters]')
    hold on
    plot(ti,x_y_z(ii,:), 'r-','LineWidth',2)
%     plot(time,DIFF (ii,:), 'r-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[meters]')
    hold on
    plot(tgi,positiong(:,ii), 'b-','LineWidth',2)
%     plot(time,DIFF (ii,:), 'r-')
    grid on
    grid minor
    title(NAME(ii))
    xlabel('time [sec]')
    ylabel('[meters]')
    hold off
    legend('Reference Trajectory','L1AC Output', 'MPC Output')
end

% t = 0:pi/20:10*pi;
% xt = sin(t);
% yt = cos(t);
figure(13)
plot3(x,y,z,'-o','Color','b','MarkerSize',10,'MarkerFaceColor','#D9FFFF')
grid on
grid minor
    
    xlabel('time [sec]')
    ylabel('[meters]')
    hold on
    plot3(xg, yg, zg,'-o','Color','r','MarkerSize',5,'MarkerFaceColor','#D9FFFF')
% plot3(x_y_z(1,:),x_y_z(2,:),x_y_z(3,:),'-o','Color','r','MarkerSize',5,'MarkerFaceColor','#D9FFFF')
    hold off