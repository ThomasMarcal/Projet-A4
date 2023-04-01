% TD 2-3 : SCARA Code

% ------------------------------------------------------------------------

% Nettoyage

clear all;
clc;

% ------------------------------------------------------------------------

syms q1 q2 q4 L1 L2 r3; % Use Symbolic Math Toolbox

% ------------------------------------------------------------------------

% DATA 

sigma = [0;0;1;0]; % IF Prismatic joint (translation) value = 1 OR Rotation so value = 0
alpha = [0;0;0;0]; % Rotation about x
theta = [q1;q2;0;q4]; % Rotation about z
d = [0;L1;L2;0]; % Distance between current and last z
r = [0;0;-r3;0]; % Distance between current and previous x

% ------------------------------------------------------------------------

% Solution to the direct kinematics

[TOTn, entities] = DenaHart(alpha, d, theta, r);
TOTn

% ------------------------------------------------------------------------

% Jacobian matrix for the mechanism 

J = JacobianMatrix(entities,sigma)