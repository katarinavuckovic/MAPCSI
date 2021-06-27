function [angles,delays,powers] = ADPPeaksUnique1(ADP,N)
angles = [];
delays = [];
powers = [];
Lm = imregionalmax((ADP));
[A B]= (find(Lm == 1));
for i = 1 : length(A)
    Amp(i)=ADP(A(i),B(i));
end
Amp = sort(Amp,'descend');
M = 0;
i = 1;
while(M<N)
    [a d] = find(ADP == Amp(i));
    angles = [angles;a];
    delays = [delays;d];
    i=i+1;
    M = length(unique(angles));
    
end
delays = delays;% * 3*10^8/(5*10^8);
len = length(angles);
powers = Amp(1:len);
end