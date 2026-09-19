from iapws import IAPWS97
import numpy as np

# 定义压力和温度点（共10×10）
pressures = np.linspace(1, 15, 10)  # 单位 MPa
temperatures = np.linspace(200, 400, 10)  # 单位 ℃

# 输出 pressure_table 和 temperature_table
print("const float pressure_table[10] = { " + ', '.join(f'{p:.2f}' for p in pressures) + " };")
print("const float temperature_table[10] = { " + ', '.join(f'{t:.1f}' for t in temperatures) + " };")
print()

# 生成密度表
print("const float density_table[10][10] = {")
for p in pressures:
    row = []
    for T in temperatures:
        try:
            steam = IAPWS97(P=p, T=T + 273.15)
            row.append(f"{steam.rho:.3f}")
        except Exception:
            row.append("0.0")  # 若超出范围，设为 0
    print("    { " + ', '.join(row) + " },")
print("};")
