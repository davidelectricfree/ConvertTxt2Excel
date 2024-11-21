import pandas as pd

def txt_to_excel(input_txt_file, output_excel_file):
    data = []
    
    # 读取 TXT 文件
    with open(input_txt_file, 'r', encoding='utf-8') as file:
        for line in file:
            # 分割每一行数据
            parts = line.strip().split(';')
            if len(parts) == 3:  # 确保每行有三组数据
                data.append(parts)

    # 创建 DataFrame
    df = pd.DataFrame(data, columns=['X', 'Y', 'θ'])
    
    # 尝试将每列数据转换为数字类型
    try:
        df['X'] = pd.to_numeric(df['X'], errors='coerce')  # 转换为数字，无法转换的设置为 NaN
        df['Y'] = pd.to_numeric(df['Y'], errors='coerce')  # 转换为数字
        df['θ'] = pd.to_numeric(df['θ'], errors='coerce')  # 转换为数字
    except Exception as e:
        print(f"数据转换发生错误: {e}")

    # 添加序号列
    df.insert(0, '序号', range(1, len(df) + 1))

    # 输出到 Excel 文件
    df.to_excel(output_excel_file, index=False)
    print(f"数据已成功输出到 {output_excel_file}")


# 使用示例
if __name__ == "__main__":
    input_txt_file = r'D:\onedrive\应用\GitHub\ConvertTxt2Excel\input.txt'      # 输入的 TXT 文件名
    output_excel_file = r'D:\onedrive\应用\GitHub\ConvertTxt2Excel\output.xlsx'  # 输出的 Excel 文件名
    
    txt_to_excel(input_txt_file, output_excel_file)
