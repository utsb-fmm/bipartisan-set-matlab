function P=BipartisanSet(A,verbose)
    if(nargin<=1)
        verbose=0;
    end
    N0=size(A,1);
    SS=SmithSet(A);
    p=false;
    while all(p==false) || all(p<1.e-8)
        SS=SS(randperm(end));
        nA=A(SS,SS);
        p=RockPaperScissors(nA,1000);
        disp('.')
    end
    P=zeros(1,N0);
    P(SS)=p;

    if verbose==2
        fprintf('A=\n');
        disp(A)
    end
    if verbose
        n=find(P>1.e-8);
        fprintf('The Smith Set has %d options \n',length(SS));
        fprintf('The pipartisan set is:\n')
        for i=1:length(n)
            fprintf('%4d (p=%.5f)\n',n(i),P(n(i)));
        end
    end
end

