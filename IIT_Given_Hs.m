clear all;close all;clc;
syms n;

fsampling=10;d=[0 7.252 36.26];c=[1 7 36.26];
N1=length(c);N2=length(d);d=[zeros(1,N1-N2),d] ;
[R,AP,C]=residue(d,c)
AP=roots(c)
AZ=roots(d)
T=1/fsampling;
DP=exp(AP*T)

% a is denominator, b is numerator
% b0 found later
% use if degree of numerator less than denominator
[b,a]=residuez(R,DP,C)

% use if degree of numerator equal to denominator
% manually plug in new denominator
% b=[1 -1.6695 1]

% makes matrices equal length
b=[b,zeros(1,length(a)-length(b))] 

% DZ is Hd roots
DZ=roots(b)
Ha=tf(d,c);
Hdig=filt(b,a)

figure(1);
pzplot(Ha)
axis([-10 10 -10 10])
% pzmap(Ha) 
[Hc,w2]=freqs(d,c,500);

figure(2);
plot(w2,abs(Hc),'LineWidth',2);grid on; xlabel('\omega');ylabel('|H(\omega)|'); title('Analog Magnitude Response (Linear)');

figure(3);
plot(w2,angle(Hc)*180/pi,'LineWidth',2);grid on; xlabel('\omega');ylabel('\angleH(\omega) (deg)'); title('Analog Phase Response');

figure(4);
semilogx(w2,20*log10(abs(Hc)),'LineWidth',2);grid on; xlabel('\omega');ylabel('20*log10|H(\omega)|'); title('Analog Magnitude Response (dB)');

figure(5);
zplane(DZ,DP)
% b0=sum(a)/sum(b)

% for BPF
theta=0:0.001:pi;
k=0:2;
H=b*exp(-j*k'*theta)./(a*exp(-1j*k'*theta));
b0=1/max(abs(H))

b=b0*b;
[Hd,w3]=freqz(b,a,500); 

figure(6)
plot(w3/pi,abs(Hd),'LineWidth',2);grid on; xlabel('\theta/\pi');ylabel('|H(\theta)|'); title('Digital Magnitude Response (Linear)');

figure(7);
plot(w3/pi,angle(Hd)*180/pi,'LineWidth',2);grid on; xlabel('\theta/\pi');ylabel('\angleH(\theta) (deg)'); title('Digital Phase Response');

figure(8);
semilogx(w3/pi,20*log10(abs(Hd)),'LineWidth',2);grid on; xlabel('\theta/\pi');ylabel('20*log_1_0|H(\theta)|'); title('Digital Magnitude Response (dB)');
