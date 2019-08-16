%% Example to set up the model of a rigid body
% T = T1 + T2 + T3 + T4;
% L
% M
% N
%                       1 CCW
%                       |
%                       |
%                       |
%         CW 4-------------------2 CW
%                       |
%                       |
%                       |
%                       3 CCW



%
% % GAMMA = T L M N;
% Kt = 0.052; % Nm/Volt^2
% Kf = 0.11;  % N/Volt
% l  =  .5; % meters m
% LAMBDA = [Kf Kf Kf Kf
%          0  -l*Kf 0 l*Kf
%          l*Kf 0 -l*Kf 0
%          Kt -Kt Kt -Kt];
% DELTA = eye(4);
% syms u1 u2 u3 u4 real
% U = [u1 u2 u3 u4]';
% GAMMA = LAMBDA * DELTA * U;
%
% %% %%%%%%%%%%%%%%%%%%%%%%%%
% clear
% syms Ixx Iyy Izz Ixy Ixz Iyz real
% syms m u_dot v_dot w_dot real
% syms p q r u v w real
% syms p_dot q_dot r_dot T real
% syms L M N real
% V = [u v w]';
% omega = [p q r]';
%
% V_dot = [u_dot v_dot w_dot]';
% omega_dot = [p_dot q_dot r_dot]';
% F = [0 0 -T]';
% I =[Ixx Ixy Ixz
%     Ixy Iyy Iyz
%     Ixz Iyz Izz];
% %%
% % F = m*V_dot +  cross (omega,m*V);
%
% m_V_dot  = F -  cross (omega,m*V);
% V_dot = m_V_dot /m;
% V_dot = simplify(expand(V_dot));
% % M = I*omega_dot +  cross (omega,I*omega);
%
% M = [L M N]';
% I_omega_dot = M-cross (omega,I*omega);
%
% omega_dot_formula = inv(I)*I_omega_dot;
% omega_dot_2 = simplify(expand(omega_dot_formula));
% omega_dot_2  = simplify(inv(I))*I_omega_dot;
%
% %%
% syms phi theta psi real
%
% MATRIX = [1          0                 -sin(theta)
%          0        cos(phi)     sin(phi)*cos(theta)
%          0       -sin(phi)     cos(theta)*cos(phi)];
%
% ATTITUDE_DOT = simplify(inv(MATRIX))*[p q r]';
%
% phi_dot   = ATTITUDE_DOT(1);
% theta_dot = ATTITUDE_DOT(2);
% psi_dot   = ATTITUDE_DOT(3);
%
%
% MATRIX2 = [cos(psi)*cos(theta) cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi) cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi)
%            sin(psi)*cos(theta) sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi) sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi)
%            -sin(theta) cos(theta)*sin(phi) cos(theta)*cos(phi)];
% POS_DOT = MATRIX2 * [u v w]';
%
% X_dot = POS_DOT(1);
% Y_dot = POS_DOT(2);
% Z_dot = POS_DOT(3);
%
% x_dot = [V_dot;omega_dot_2;phi_dot;theta_dot;psi_dot;POS_DOT]

%% Setup Beginning
clear all

global LAMBDA inertia m g
g = 9.81;
Kt = 0.052; % Nm/Volt^2  Kt = 0.052
Kf = 0.11;  % N/Volt  Kf = 0.11
l  =  .5; % meters m
LAMBDA = [Kf Kf Kf Kf
         0  -l*Kf 0 l*Kf
         l*Kf 0 -l*Kf 0
         Kt -Kt Kt -Kt];
m = 0.300;% [kg]  m = 2.356;% [kg]
Ix = 0.1676 * 2;    % kg m2 Ix = 0.1676;
Iy = 0.1676 * 2;    % kg m2
Iz = 0.29743;   % kg m2
inertia =  diag([Ix,Iy,Iz])

V0 = 0*ones(3,1);
% omega0 = 0*ones(3,1);
ATTITUDE0 = 1/60*ones(3,1);
POS0 = 0*ones(3,1);

inertia_inv = inv(inertia);
omega_start = 0*ones(3,1);



T = readtable('hard_traj.xlsx');
T = T{:,:};

for ii = 1:2307
ti(ii,1) = 0.00 + (ii-1)/100; 
end 
% ti = ti';
% 

x = T(:,1);
y = T(:,2);
z = T(:,3);
position = [x y z]';
position = reshape(position,3,max(size(position)));
position = position';

StateX = [ti x];
StateY = [ti y];
StateZ = [ti z];

xt = T(:,5);
yt = T(:,6);
zt= T(:,7);
wt = T(:,4);
quat = [wt xt yt zt];
attitude = quat2eul(quat);%theta_phi_psi
attitude = reshape(attitude,3,max(size(attitude)));
attitude = attitude';

Statetheta = [ti attitude(:,2)];
Statephi = [ti attitude(:,1)];
Statepsi = [ti attitude(:,3)];

u = T(:,8);
v = T(:,9);
w = T(:,10);
velocity = [u v w]';
velocity = reshape(velocity,3,max(size(velocity)));
velocity = velocity';

p = T(:,11);
q = T(:,12);
r = T(:,13);
attitudedot = [p q r]';
attitudedot = reshape(attitudedot,3,max(size(attitudedot)));
attitudedot = attitudedot';



State = [ti position attitude velocity attitudedot];


%%
u_trim = 0;
v_trim = 0;
w_trim = 0;
TRIM
LINEARIZZA_ESTRAI
ALTITUDE_PLUS_ATTITUDE_CONTROL
close all
% phi_ref = 0/60;
% theta_ref = 0/60;
% psi_ref = 0/60;

theta_ref = attitude(:,1);
psi_ref = attitude(:,3);
phi_ref = attitude(:,2);

sim('Quad22')
PLOTTING2
docknewfig
