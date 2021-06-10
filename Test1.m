% test things
clc
clear all
close all
n = 600;
m = 1000;
feasible = 0;
[A,B,rez] = genRandomFeasibleLP(m,n,1e-5,1e5,feasible);
[found, X,y] = assertLP_feasibility(A,B);
A*X + B