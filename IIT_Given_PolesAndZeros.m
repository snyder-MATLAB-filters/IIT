close all; clear all; clc;

syms z b0

%enter poles and zeros if none of them are 0
zeros=[-exp(j*pi/4) -exp(-j*pi/4) -exp(j*3*pi/4) -exp(-j*3*pi/4)];
poles=[0.9 -0.9 j*0.9 -j*0.9];

% used to troubleshoot Part f.)
%expand((z+j)*(z-j)*(z-1)*(z-exp(j*pi/4))*(z-exp(-j*pi/4))*(z-exp(j*3*pi/4))*(z-exp(-j*3*pi/4)))

num=poly(zeros)
den=poly(poles)

% if poles are 0 enter polynomial manually
% den=[1 0 0 0 0 0 0 0]

% for LPF, HPF, BSF
b0=sum(den)/sum(num)

% for BPF
% theta=0:0.001:pi;
% k=0:2;
% H=num*exp(-j*k'*theta)./(den*exp(-1j*k'*theta));
% b0=1/max(abs(H))

vpa(b0,4)

% adjust numerator by b0
num=num*double(b0)

% get frequency response and plot
[Hd,w3]=freqz(num,den,500); 

figure(1)
plot(w3/pi,abs(Hd),'LineWidth',2);grid on; 
xlabel('\theta/\pi');ylabel('|H(\theta)|'); 
title('Digital Magnitude Response (Linear)');

figure(2);
plot(w3/pi,angle(Hd)*180/pi,'LineWidth',2);grid on; 
xlabel('\theta/\pi');ylabel('\angleH(\theta) (deg)'); 
title('Digital Phase Response');

figure(3);
semilogx(w3/pi,20*log10(abs(Hd)),'LineWidth',2);grid on; 
xlabel('\theta/\pi');ylabel('20*log_1_0|H(\theta)|'); 
title('Digital Magnitude Response (dB)');
