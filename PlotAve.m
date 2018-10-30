function PlotAve
Average=load('AVERAGE.OUT');

%--------------------------------------------------------------------------
AverageX = Average(:,1:2);
figure(10);
hold on
plot(AverageX(:,1),AverageX(:,2));
% title('')
ylabel('Average Stress (kN/m2)');
xlabel('Time (s)');
axis([min(AverageX(:,1)) max(AverageX(:,1))...
      min(AverageX(:,2)) max(AverageX(:,2))]);
hold off
end
