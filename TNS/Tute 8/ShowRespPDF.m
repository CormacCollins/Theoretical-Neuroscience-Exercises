function ShowRespPDF( sin, xout, PN_XandS, EXN_S )

fs = 10;

clr  = ['r.';'g.';'b.';'k.'];

figure;
for i=1:4
        
    %a = PN_XandS(i,:,:)
    subplot(2,2,i);
    hold on;
    contour( sin, xout, squeeze( PN_XandS(i,:,:)) );
%    plot( sA, Xmean(i,:), clr(i,:) );
    plot( sin, EXN_S(i,:), clr(i,:) );   
    
    hold off;
    axis 'square';
    set( gca, 'FontSize', fs );
    
    xlabel('s', 'FontSize', fs );
    ylabel('x', 'FontSize', fs );

    title( ['Neuron ' num2str(i,'%d')], 'FontSize', fs );
end

return;