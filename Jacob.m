disp('Cartesian Manipulator')
syms a1 a2 a3 a4 d1 d2 d3

%% Link Lengths
a1 = 5;
a2 = 10;
a3 = 5;
a4 = 10;

%% Joint Variables
d1 = 3;
d2 = 3;
d3 = 3;

%% D-H Parameters [theta, d, r, alpha, offset]
% if prismatic joint: theta, d = 0, offset = 1, after offset put the value of d
% if revolute joint: theta = 0, after offset put the value of theta

H0_1 = Link([0,0,0,3*pi/2,1,a1]);
H0_1.qlim = [0 0];

H1_2 = Link([3*pi/2,0,0,3*pi/2,1,a2]);
H1_2.qlim = [0 d1];

H2_3 = Link([pi/2,0,0,3*pi/2,1,a3]);
H2_3.qlim = [0 d2];

H3_4 = Link([0,0,0,0,1,a4]);
H3_4.qlim = [0 d3];

Cart = SerialLink([H0_1 H1_2 H2_3 H3_4], 'name', 'Cart')
Cart.plot([0 0 0 0], 'workspace',[-30 30 -30 30 -30 30]) %plot at Origin position
Cart.teach
%% Inverse Kinematics
%syntax: IK = robot_variable.ikine(PV,qready,'mask',[1 1 1 0 0 0])
q_init=[0 0 0];
PV=transl([8 13 -8]);
IK = Cart.ikine(PV,q_init,'mask',[1 1 1 0 0 0])

%% Jacobian Matrix
q_j1 = [0 d1 d2 d3]
J1 = jacob0(Cart,q_j1)
