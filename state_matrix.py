def read_permutations(filename):
    perms = []
    with open(filename, 'r') as f:
        for line in f:
            # 将每行转换为整数列表
            perm = [int(x) for x in line.strip().split()]
            perms.append(perm)
    return perms


def save_state_matrices(matrices, filename):
    with open(filename, 'w') as f:
        for matrix in matrices:
            # 将矩阵展平成一维并转换为字符串
            flat = [str(x) for x in matrix.flatten()]
            flat = flat[::-1]
            f.write(' '.join(flat) + '\n')


def process_permutations(input_file, output_file):
    import numpy as np
    from Benes import benes  # 假设benes函数在benes模块中

    # 读取置换序列
    perms = read_permutations(input_file)

    # 存储所有state matrices
    state_matrices = []

    # 对每个置换序列调用benes函数
    for perm in perms:
        state_matrix = benes(perm)
        state_matrices.append(state_matrix)

    # 保存结果
    save_state_matrices(state_matrices, output_file)


# 使用示例
input_file = 'permutation.txt'
output_file = 'state_matrices.txt'
process_permutations(input_file, output_file)