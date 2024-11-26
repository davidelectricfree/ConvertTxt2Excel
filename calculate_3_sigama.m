% 步骤 1：导入数据
data = readtable('D:\onedrive\应用\GitHub\ConvertTxt2Excel\output.xlsx');

% 假设数据的列分别为：
% 第一列：序号
% 第二列：x的测试偏差量
% 第三列：y的测试偏差量
% 第四列：θ的测试偏差量

x_data = data{:, 2}; % x的偏差量
y_data = data{:, 3}; % y的偏差量
theta_data = data{:, 4}; % θ的偏差量

% 步骤 2：绘制数据图形
figure;
hold on;
plot(x_data, 'r', 'DisplayName', 'x的偏差量');
plot(y_data, 'g', 'DisplayName', 'y的偏差量');
plot(theta_data, 'b', 'DisplayName', 'θ的偏差量');

% 步骤 3：计算3 sigma值
x_sigma = 3 * std(x_data);
y_sigma = 3 * std(y_data);
theta_sigma = 3 * std(theta_data);

% 在图中添加基准线
yline(0.1, 'k--', 'x=0.1', 'LabelHorizontalAlignment', 'left');
yline(0.1, 'k:', 'y=0.1', 'LabelHorizontalAlignment', 'right');
yline(0.02, 'k-.', 'θ=0.02', 'LabelHorizontalAlignment', 'right');

% 设置图形属性
title('测试偏差量');
xlabel('样本序号');
ylabel('偏差量');
legend;
grid on;
hold off;

% 步骤 4：显示3 sigma值
disp(['x的3 sigma值: ', num2str(x_sigma)]);
disp(['y的3 sigma值: ', num2str(y_sigma)]);
disp(['θ的3 sigma值: ', num2str(theta_sigma)]);
