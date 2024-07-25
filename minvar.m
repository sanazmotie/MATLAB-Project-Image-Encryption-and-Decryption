function [mv] = minvar(photo1)
%bedast avardane kamtarin variance dar har khane
%va zakhire an dar yek matris
[photo_row,photo_column,z]=size(photo1);

%sefr kardan lsb
for i=1:1:photo_row
    for j=1:1:photo_column
        for k=1:1:3
            if rem(photo1(i,j,k),2)==1
                photo1(i,j,k)=photo1(i,j,k)-1;
            end
        end
    end
end

k=0;
l=0;
for i=8:8:photo_row
    k=k+1;
    for j=8:8:photo_column
        l=l+1;
        a=photo1(i-7:1:i,j-7:1:j,1);
        a=double(a);
        b=photo1(i-7:1:i,j-7:1:j,2);
        b=double(b);
        c=photo1(i-7:1:i,j-7:1:j,3);
        c=double(c);
        x=[var(a,0,'all') var(b,0,'all') var(c,0,'all')];
        [v,mv(k,l)] = min(x);
    end
    l=0;
end
end

