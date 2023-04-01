% TD 2-3 : FANUC Code

% ------------------------------------------------------------------------

% Nettoyage

clear all:
clc;

% ------------------------------------------------------------------------

syms r4 q1 q2 q3 q4 q5 q6 L2 L3 L4 a1 a2 a3 a4 a5 a6; % Use Symbolic Math Toolbox

% ------------------------------------------------------------------------

% DATA 

sigma = sym([0;0;0;0;0;0]); % IF Prismatic joint (translation) value = 1 OR Rotation so value = 0

alpha = sym([0;pi/2;0;pi/2;-pi/2;pi/2]); % Rotation about x

% OR

% alpha = [a1;a2;a3;a4;a5;a6];
% alpha(1) = 0;
% alpha(2) = pi/2;
% alpha(3) = 0;
% alpha(4) = pi/2;
% alpha(5) = -pi/2;
% alpha(6) = pi/2;

theta = sym([q1;q2+pi/2;q3;q4;q5;q6]); % Rotation about z
d = sym([0;L2;L3;L4;0;0]); % Distance between current and last z
r = sym([0;0;0;r4;0;0]); % Distance between current and previous x

% ------------------------------------------------------------------------

% Solution to the direct kinematics

[T0Tn, entities]=DenaHart(alpha, d, theta, r);
simplify(T0Tn)

% ------------------------------------------------------------------------

% Jacobian matrix for the mechanism 

J = JacobianMatrix(entities,sigma)