function p=RockPaperScissors(A,MaxIter)
% Solve Rock-Paper-Scissors type problem by finding the optimal strategy
% or compute the Randomized Condorcet Winner lottery..
%
% Syntax:
% p=RockPaperScissors(A)
% p=RockPaperScissors(A,MaxIter)
% Input :
% A : duel matrix (NxN) Aij=0 if the alternative i is equally prefered to j; Aij=1
% if i is prefered to j; -1 if j is prefered to i. Should respect A'=-A
% and diag A = 0;
% MaxIter: If the Paradox is too high, unstinbility occur and if the
% solution is not found in few iter, it is never found. 
%
% Output :
% p probability vector of the optimal lottery/strategy
%
% Example :
%
% Case of Condorcet Winner (or an object which beat every one)
% A=[0 1 -1 1 -1;-1 0 1 -1 -1;1 -1 0 1 -1;-1 1 -1 0 -1;1 1 1 1 0];
% p=RockPaperScissors(A)
%
% Case of a more complicated Condorcet parradoxe (/strategy to adopt)
% B=[0 -1 -1 -1 1;1 0 1 -1 -1;1 -1 0 1 -1; 1 1 -1 0 -1; -1 1 1 1 0];
% p=RockPaperScissors(B)
%
% Case of "pseudo" Condorcet Winner (equality with one of the alternatives)
% C=[0 1 -1 1 0;-1 0 1 -1 -1;1 -1 0 1 -1;-1 1 -1 0 -1;0 1 1 1 0];
% p=RockPaperScissors(C)
%
% Number of equality
% D=[0 1 1 0 0; -1 0 1 1 -1; -1 -1 0 -1 1; 0 -1 1 0 0; 0 1 -1 0 0];
% p=RockPaperScissors(D)
%
% Absolute equality
% p=RockPaperScissors(zeros(5))
%
% Ploblem = min_p Qp so that Ap<=0, p>=0 and sum p =1; (=Phase II)
% Problem Phase I is min_p -sum p so that Ap<=0 and sum p<=1. If
% Q=zeros(1,5) Solution problem phase I is the solution of problem Phase II

if nargin<=1
    MaxIter=1000;
end

N=size(A,1);

S=[[A;ones(1,N);-ones(1,N)] [eye(N+1);zeros(1,N+1)] [zeros(N,1);1;0] ];

[S,solvedVar]=simplexAlgo(S,2*N,N+1, N+1:2*N+1,MaxIter );%Phase I
p=zeros(1,size(S,2)-1);%max(N ligne)
p(solvedVar)=S(1:N+1,end);
j=1;
list(1,:)={S,solvedVar};
nlist=1;

while nlist<=size(list,1)
    for i=1:2*N
        if ~any(solvedVar==i)
            S2=list{nlist,1};
            solvedVar2=list{nlist,2};
            S2(end,i)=-0.01;
            [S2,solvedVar2]=simplexAlgo(S2,2*N,N+1,solvedVar2,MaxIter);
            if S2==false
                p=false;
                return
            end
            ptmp=zeros(1,size(S,2)-1);
            ptmp(solvedVar2)=S2(1:N+1,end);
            if(~any(all(abs(ones(j,1)*ptmp-p)'<1.e-8)))
                j=j+1;
                p(j,solvedVar2)=S2(1:N+1,end);
                list(j,:)={S2,solvedVar2};
            end
        end
    end
    nlist=nlist+1;
end
p=mean(p(:,1:N),1);

end


function [S,solvedVar]=simplexAlgo(S,n,m,solvedVar,MaxIter)
    iter=0;
    while any(S(end,1:n)<-1.e-8) && iter<MaxIter
        [~, col] = min(S(end,1:n));    
        positive_rows = find(S(1:m, col)>1.e-8);

        if isempty(positive_rows)
            error('The problem is unbounded');
        end

        ratios = S(positive_rows, end) ./ S(positive_rows, col);
        [~, i] = min(ratios);  % Choose row with smallest ratio
        row = positive_rows(i);
        solvedVar(row)=col;

        S(row,:)=S(row,:)/S(row,col);
        for i=[1:row-1 row+1:size(S,1)]
            S(i,:)=S(i,:)-S(i,col)*S(row,:);
        end
        iter=iter+1;
    end
end
