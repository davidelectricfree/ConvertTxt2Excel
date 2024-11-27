% 步骤 1：弹出文件选择对话框
[file, path] = uigetfile('*.xlsx', '请选择Excel数据文件');
if isequal(file, 0)
    disp('用户取消选择文件');
    return; % 如果用户取消选择，退出程序
end
fullFileName = fullfile(path, file);

% 从选定的Excel文件中导入数据
data = readtable(fullFileName);

% 假设数据的列分别为：
% 第1列：序号
% 第2列：x的测试偏差量
% 第3列：y的测试偏差量
% 第4列：θ的测试偏差量

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
yline(-0.1, 'k--', 'x=-0.1', 'LabelHorizontalAlignment', 'left');
yline(0.1, 'k:', 'y=0.1', 'LabelHorizontalAlignment', 'right');
yline(-0.1, 'k:', 'y=-0.1', 'LabelHorizontalAlignment', 'right');
yline(0.02, 'k-.', 'θ=0.02', 'LabelHorizontalAlignment', 'right');
yline(-0.02, 'k-.', 'θ=-0.02', 'LabelHorizontalAlignment', 'right');

% 设置图形属性
title('测试偏差量');
xlabel('样本序号');
ylabel('偏差量');
legend;
grid on;

% 步骤 4：显示3 sigma值
text('Units', 'normalized', 'Position', [0.8, 0.1], ...
    'String', {['x_{sigma} = ', num2str(x_sigma)], ...
    ['y_{sigma} = ', num2str(y_sigma)], ...
    ['θ_{sigma} = ', num2str(theta_sigma)]}, ...
    'FontSize', 10, 'BackgroundColor', 'w');

hold off;

% 步骤 5：绘制直方图
figure;

% 设置直方图的边界
edges = -0.3:0.05:0.3;

% 绘制每个直方图
hold on;
histogram(x_data, edges, 'FaceColor', 'r', 'DisplayName', 'x的偏差量', 'EdgeColor', 'k', 'Normalization', 'probability');
histogram(y_data, edges, 'FaceColor', 'g', 'DisplayName', 'y的偏差量', 'EdgeColor', 'k', 'Normalization', 'probability');
histogram(theta_data, edges, 'FaceColor', 'b', 'DisplayName', 'θ的偏差量', 'EdgeColor', 'k', 'Normalization', 'probability');

% 设置图形属性
title('偏差量的直方图');
xlabel('偏差量');
ylabel('概率');
legend;
grid on;
hold off;
