function Thiy2= getdiffmovment(X,Window)
Thiy = X;
Thiy= Thiy(~isnan(Thiy));
Thiy=smooth(Thiy,Window);
Thiy2 = NaN(size(X));
Thiy3 = X;
Thiy2(~isnan(Thiy3))=Thiy;
% plot(diff(Thiy2))