function varargout=plotPc2TileStat(I,x,y,tsize,shift,varargin)
%function [(P,M,fh)]=plotPc2TileStat(I,x,y,tsize,shift,(pltmap,debug,Gtype))
%
%  Get the histogram at the tile with point (x,y) a the center

if numel(varargin)>0; pltmap = varargin{1}; else; pltmap = 0; end
if numel(varargin)>1; debug  = varargin{2}; else; debug  = 0; end
if numel(varargin)>2; Gtype  = varargin{3}; else; Gtype = 3; end

xtileStart = x-round(tsize/2);
xtileEnd   = x+tsize-round(tsize/2);
ytileStart = y-round(tsize/2);
ytileEnd   = y+tsize-round(tsize/2);

if pltmap
    figure; 
    imagesc(I,[-3 3]);
    hold on;
    pgon=polyshape([xtileStart xtileStart xtileEnd xtileEnd],...
                   [ytileStart ytileEnd   ytileEnd ytileStart]);
    plot(pgon,'FaceColor','none','EdgeColor','r','LineWidth',2);
end

tmpImg = I(ytileStart:ytileEnd, xtileStart:xtileEnd);
% figure; imagesc(tmpImg); colorbar
[ P,M,fh ] = getStatG3( tmpImg, 1, debug, Gtype ); 

if nargout > 0
    varargout{1} = P;
end
if nargout > 1
    varargout{2} = M;
end
if narargout > 3
    varargout{3} = fh;
end

fprintf('x=%d, y=%d\n',x,y);
fprintf('xt=[%d,%d],yt=[%d,%d]\n',xtileStart,xtileEnd,ytileStart,ytileEnd);
fprintf('BC  = %02d\n',round(M.BC*100));
fprintf('AD1 = %3.1f, SR1 = %02d, AS1 = %f, NIA1 = %f\n',M.AD1,round(M.SR1*100),M.AS1,M.NIA1);
fprintf('AD3 = %3.1f, SR3 = %02d, AS3 = %f, NIA3 = %f\n',M.AD3,round(M.SR3*100),M.AS3,M.NIA3);
fprintf('1st Gaussian amp = %5f, mean = %4.2f, std = %4.2f\n',P.G3p1(1),P.G3p1(2),P.G3p1(3));
fprintf('2nd Gaussian amp = %5f, mean = %4.2f, std = %4.2f\n',P.G3p2(1),P.G3p2(2),P.G3p2(3));
fprintf('3rd Gaussian amp = %5f, mean = %4.2f, std = %4.2f\n',P.G3p3(1),P.G3p3(2),P.G3p3(3));

end

