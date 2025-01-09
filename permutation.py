'''
import itertools


def generate_permutations(n):
    # 生成从0到n-1的列表
    numbers = list(range(n))
    # 生成所有置换
    permutations = list(itertools.permutations(numbers))

    # 将置换写入文件
    with open('permutation.txt', 'w') as f:
        for perm in permutations:
            f.write(' '.join(map(str, perm)) + '\n')


if __name__ == "__main__":
    n = int(input("请输入一个整数n: "))
    generate_permutations(n)
'''
import random
import itertools

def generate_permutations(n):
    if n <= 4:
        # 直接生成所有排列
        return list(itertools.permutations(range(n)))
    else:
        # 随机生成300个排列
        results = []
        for _ in range(20000):
            # 复制一份原始数字列表
            numbers = list(range(n))
            perm = []
            while numbers:
                # 随机选择并移除一个数字
                idx = random.randint(0, len(numbers)-1)
                perm.append(numbers.pop(idx))
            results.append(perm)
        return results

def write_to_file(perms):
    with open('permutation.txt', 'w') as f:
        for perm in perms:
            # 将每个排列转换为字符串并写入文件
            f.write(' '.join(map(str, perm)) + '\n')

n = int(input("请输入n: "))
permutations = generate_permutations(n)
write_to_file(permutations)
