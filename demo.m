fprintf('Case with a Condorcet winner:\n')
A=[0 1 -1 1 -1;-1 0 1 -1 -1;1 -1 0 1 -1;-1 1 -1 0 -1;1 1 1 1 0];
p=BipartisanSet(A,2); %,2 is for display

fprintf('\n\nCase with a Smith set at 4 options and a bipartisan set with 3 options:\n')
A=[0 -1 -1 -1 -1;1 0 1 -1 -1;1 -1 0 -1 1; 1 1 1 0 -1; 1 1 -1 1 0];
p=BipartisanSet(A,2);


fprintf('\n\nCase with a complicated Condorcet paradox with 5 not equipropable options:\n')
A=[0 -1 -1 -1 1;1 0 1 -1 -1;1 -1 0 1 -1; 1 1 -1 0 -1; -1 1 1 1 0];
p=BipartisanSet(A,2);


fprintf('\n\nCase of weak Condorcet Winner (tie with one of the alternatives):\n')
A=[0 1 -1 1 0;-1 0 1 -1 -1;1 -1 0 1 -1;-1 1 -1 0 -1;0 1 1 1 0];
p=BipartisanSet(A,2);

fprintf('\n\nCase with several ties:\n')
A=[0 1 1 0 0; -1 0 1 1 -1; -1 -1 0 -1 1; 0 -1 1 0 0; 0 1 -1 0 0];
p=BipartisanSet(A,2);

fprintf('\n\nCase with full ties:\n')
A=zeros(5);
p=BipartisanSet(A,2);

fprintf('\n\n20,000 candidates Smith set of 50 candidates, random duels in the Smith Set:\n');
N=50;
A=zeros(N,N);for i=1:N,for j=i+1:N,  A(i,j)=(rand(1)>.5)*2-1; A(j,i)=-A(i,j); end,end
M=20000;
B=zeros(M,M);for i=1:M,for j=i+1:M,  B(i,j)=(rand(1)>.5)*2-1; B(j,i)=-B(i,j); end,end
C=[A ones(N,M);-ones(M,N) B];
r=randperm(M+N);
C=C(r,r);
tic,
p=BipartisanSet(C,1);
toc;

fprintf('\n\nWith 70 options and random duels, some instablility starts to occur, several trial may be necessary:\n');
N=70;
A=zeros(N,N);for i=1:N,for j=i+1:N,  A(i,j)=(rand(1)>.5)*2-1; A(j,i)=-A(i,j); end,end
p=BipartisanSet(A,1);