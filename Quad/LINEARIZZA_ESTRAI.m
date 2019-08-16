trim_input = stato(13:end); step_dxdu = 1e-7;

[A,B]=linearizza(@QUADROTOR,stato(1:12),trim_input,step_dxdu);
Q = 100*eye(12); 
R = eye(4);
[K_baseline,S,E] = lqr(A,B,Q,R);
K_baseline = K_baseline * 100; 
%%.........................

C = [1 0 0 0 0 0 0 0 0 0 0 0  
     0 1 0 0 0 0 0 0 0 0 0 0 
     0 0 1 0 0 0 0 0 0 0 0 0 
     0 0 0 1 0 0 0 0 0 0 0 0 ];
D = [0 0 0 0
     0 0 0 0
     0 0 0 0
     0 0 0 0]';
 
P = ss(A,B,C,D);
% sys = ss(A,B)
[K_hinfy,CL,gamma] = hinfsyn(P,3,4);
