%Create plot for temperatures of collector and storage tank

%generate data
date_con= cellstr(datestr(T_col.Time/86400+datenum(2005,1,1,0,0,0)));
dates = datenum(date_con);
T_col_var=T_col.Data;
T_st_var=T_st.Data;
v_col_var=v_col.Data;
v_st_var=v_st.Data;

%figure data
figure
plot(dates,T_col_var,dates,T_st_var);
ax = gca;
ax.FontSize = 12;

%Customize X axe for labeling name of months
dynamicDateTicks
setDateAxes(gca, 'XLim', [datenum('December 31, 2004') datenum('January 1, 2006')]);

% ax = gca;
% ax.XTick =linspace(0,uint(max(h)),50);
xlabel('Time, month','FontSize',20) 
ylabel('Temperature, C','FontSize',20)
% ylim([-40,82])
% xlim([0,max(h)])
% ax.XGrid = 'on';
% %ax.XMinorGrid = 'on';
% ax.YGrid = 'on';
% %ax.YMinorGrid = 'on';
lgd=legend('Temperature collector, C','Temperature storage tank, C','Location','northwest');
lgd.FontSize = 14;
grid on

%--------------------------------------------------------------------
%Create plots of temperatures of collector, storage tank and pump work
figure
[ax,h1,h2] = plotyy(dates,[T_col_var,T_st_var],dates,v_col_var);

%Customize X axe for labeling name of months and Y axe
dynamicDateTicks
%setDateAxes(gca, 'XLim', [datenum('December 31, 2004') datenum('January 1, 2006')]);
dynamicDateTicks([], [], 'mmmm');
linkaxes([ax(1) ax(2)], 'x');
dynamicDateTicks([ax(1) ax(2)], 'linked')

set(ax(2),'YLim',[0 10])
set(ax(2),'YTick',[0 1])
set(ax(1),'YLim',[-40 82])
set(ax(1),'YTick',linspace(-40,80,7))
set(h2,'Color','k');
set(ax,{'ycolor'},{'k';'k'});
set(ax,'FontSize',14);

% set(ax(1),'XLim',[0 max(h)])
% set(ax(1),'XTick',linspace(0,max(h),50))
% set(ax(1),'YTick',linspace(-40,82,10))
% %set(h1,'LineWidth',2)
% set(ax(1),'XGrid','on')
% set(ax(1),'YGrid','on')
% %set(ax(1),'XMinorGrid','on')
% %set(ax(1),'YMinorGrid','on')
xlabel(ax(1),'Time, month','FontSize',20)
ylabel(ax(1),'Temperature, C','FontSize',20)
ylabel(ax(2),'on/off','FontSize',20)

lgd=legend('Temperature collector, C','Temperature storage tank, C','Ststus of collector pump: ON/OFF','Location','northwest',14);
lgd.FontSize = 14;
grid on

%------------------------------------------------------------------------------
%Create plots of temperatures of collector, storage tank and ambient temperature
%Interpolate temperatures of ambient from 8760 to 10713 size
Temp_des = interp1(Second_date, DrybulbC, T_col.Time);

figure
plot(dates,T_col_var,dates,T_st_var,dates,Temp_des);
ax = gca;
ax.FontSize = 12;

xlabel('Time, month','FontSize',20) 
ylabel('Temperature, C','FontSize',20)

dynamicDateTicks
setDateAxes(gca, 'XLim', [datenum('December 31, 2004') datenum('January 1, 2006')]);
lgd=legend('Temperature of collector, C','Temperature of storage tank, C','Temperature of ambient, C','Location','northwest');
lgd.FontSize = 14;

%------------------------------------------------------------------------------
%Create plots of temperatures of collector, storage tank and solar irradiance
%Interpolate soalr irradiance from 8760 to 10713 size
Irr_des = interp1(Second_date, GHIWm2, T_col.Time);

figure
[ax,h1,h2] = plotyy(dates,[T_col_var,T_st_var,Temp_des],dates,Irr_des);

dynamicDateTicks
%setDateAxes(gca, 'XLim', [datenum('December 31, 2004') datenum('January 1, 2006')]);
dynamicDateTicks([], [], 'mmmm');
linkaxes([ax(1) ax(2)], 'x');
dynamicDateTicks([ax(1) ax(2)], 'linked')

set(ax(2),'YLim',[0 4000])
set(ax(2),'YTick',linspace(0,1000,3))
set(ax(1),'YLim',[-40 82])
set(ax(1),'YTick',linspace(-40,80,7))
set(h2,'Color','g');
set(ax,{'ycolor'},{'k';'g'})
set(ax,'FontSize',14);

xlabel(ax(1),'Time, month','FontSize',20)
ylabel(ax(1),'Temperature, C','FontSize',20)
ylabel(ax(2),'Solar irradiance','FontSize',20)

lgd=legend('Temperature collector, C','Temperature storage tank, C','Temperature of ambient, C','Solar irradiance, W/m^2','Location','northwest');
lgd.FontSize = 14;
