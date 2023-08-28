function theSet=SmithSet(A)
    Copeland=sum(A,2);
    theSet=[];
    [~,added]=max(Copeland);
    while added(1)>=0
        theSet=[theSet added];
        added=-1;
        for i=1:length(Copeland)
            if ~any(theSet==i) && any(A(i,theSet)>=0)
                added=i;
                break;
            end
        end
    end
    
end