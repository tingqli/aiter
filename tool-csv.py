import csv


def get_unique_column_values(csv_path, column_name, encoding='utf-8'):
    """
    从CSV文件中提取指定列的不重复值，按首次出现顺序返回列表。

    :param csv_path: CSV文件路径
    :param column_name: 列名（表头名称）
    :param encoding: 文件编码，默认utf-8
    :return: 不重复的值组成的列表
    """
    seen = set()
    result = []

    with open(csv_path, 'r', encoding=encoding, newline='') as f:
        reader = csv.DictReader(f)
        # 校验列名是否存在
        if column_name not in (reader.fieldnames or []):
            raise ValueError(f"列 '{column_name}' 不存在，可用列: {reader.fieldnames}")

        for row in reader:
            value = row[column_name]
            if value not in seen:
                seen.add(value)
                result.append(value)

    return result

kernels=[]
kernels.extend(get_unique_column_values("/root/workdir/aiter/aiter/configs/profile_fmoe.csv", "kernelName"))
kernels.extend(get_unique_column_values("/root/workdir/aiter/aiter/configs/model_configs/kimik3_a16w4_tuned_fmoe.csv", "kernelName1"))
kernels.extend(get_unique_column_values("/root/workdir/aiter/aiter/configs/model_configs/kimik3_a16w4_tuned_fmoe.csv", "kernelName2"))
kernels.extend(get_unique_column_values("/root/workdir/aiter/aiter/configs/model_configs/minimax_m3_a16w4_tuned_fmoe.csv", "kernelName1"))
kernels.extend(get_unique_column_values("/root/workdir/aiter/aiter/configs/model_configs/minimax_m3_a16w4_tuned_fmoe.csv", "kernelName2"))

knames = set(kernels)

for k in knames:
    if k.startswith("flydsl"):
        print(f'"{k}",')