function [A_Astar, P_P0, rho_rho0, T_T0] = isentropic(M)
% Input Mach number to calculate critical area ratio, pressure, Density and
% Temprature ratio.
    gama=1.4;
    
    delta=(gama-1)/2;
    P_P0=(1 + delta * M^2) ^ (-gama/(gama-1));
    T_T0=(1 + delta * M^2) ^ -1;
    rho_rho0=(1 + delta * M^2) ^ (-1/(gama-1));
    A_Astar= ((((gama+1)/2)/(1+delta*M^2))^((gama+1)/(2-2*gama)))/M;
end
