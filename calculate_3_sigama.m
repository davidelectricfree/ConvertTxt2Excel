% 步骤 1：弹出文件选择对话框
[file, path] = uigetfile('*.xlsx', '请选择Excel数据文件');
if isequal(file, 0)
    disp('用户取消选择文件');
    return; % 如果用户取消选择，退出程序
end
fullFileName = fullfile(path, file);

% 从选定的Excel文件中导入数据，设置VariableNamingRule为preserve
data = readtable(fullFileName, 'VariableNamingRule', 'preserve');

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

% 计算数据组数
total_data_points = length(x_data); % 假设x、y、θ的数据组数相同

% 计算3 sigma值
x_sigma = 3 * std(x_data);
y_sigma = 3 * std(y_data);
theta_sigma = 3 * std(theta_data);

% 设置图形属性
title('测试偏差量');
xlabel('样本序号');
ylabel('偏差量');
legend;
grid on;

% 在图中添加统计信息
text('Units', 'normalized', 'Position', [0.8, 0.1], ...
    'String', {['x_{sigma} = ', num2str(x_sigma)], ...
    ['y_{sigma} = ', num2str(y_sigma)], ...
    ['θ_{sigma} = ', num2str(theta_sigma)]}, ...
    'FontSize', 10, 'BackgroundColor', 'w');

% 在图中添加总数据组数信息
text('Units', 'normalized', 'Position', [0.8, 0.2], ...
    'String', {['总数据组数 = ', num2str(total_data_points)]}, ...
    'FontSize', 10, 'BackgroundColor', 'w');

hold off;

% 步骤 5：绘制 x、y 和 θ 的直方图，各自放在不同图中
edges = -0.3:0.05:0.3; % 直方图的边界

% 绘制 x 的直方图
figure;
[hX, xEdges] = histcounts(x_data, edges, 'Normalization', 'probability');
histogram(x_data, edges, 'FaceColor', 'r', 'EdgeColor', 'k', 'Normalization', 'probability');
title('x的偏差量直方图');
xlabel('偏差量');
ylabel('概率');
grid on;

% 添加计数标注
xCenters = (xEdges(1:end-1) + xEdges(2:end)) / 2; % 计算每个直方条形的中心
for i = 1:length(hX)
    text(xCenters(i), hX(i), num2str(hX(i) * total_data_points, '%.1f'), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'k');
end

% 绘制 y 的直方图
figure;
[hY, yEdges] = histcounts(y_data, edges, 'Normalization', 'probability');
histogram(y_data, edges, 'FaceColor', 'g', 'EdgeColor', 'k', 'Normalization', 'probability');
title('y的偏差量直方图');
xlabel('偏差量');
ylabel('概率');
grid on;

% 添加计数标注
yCenters = (yEdges(1:end-1) + yEdges(2:end)) / 2; % 计算每个直方条形的中心
for i = 1:length(hY)
    text(yCenters(i), hY(i), num2str(hY(i) * total_data_points, '%.1f'), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'k');
end

% 绘制 θ 的直方图
figure;
[hTheta, thetaEdges] = histcounts(theta_data, edges, 'Normalization', 'probability');
histogram(theta_data, edges, 'FaceColor', 'b', 'EdgeColor', 'k', 'Normalization', 'probability');
title('θ的偏差量直方图');
xlabel('偏差量');
ylabel('概率');
grid on;

% 添加计数标注
thetaCenters = (thetaEdges(1:end-1) + thetaEdges(2:end)) / 2; % 计算每个直方条形的中心
for i = 1:length(hTheta)
    text(thetaCenters(i), hTheta(i), num2str(hTheta(i) * total_data_points, '%.1f'), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'k');
end
