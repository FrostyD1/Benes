from Benes import benes
import math
def generate_verilog(permutations, benes):
    n = len(permutations[0])
    N = 1 << math.ceil(math.log2(n))
    width = math.ceil(math.log2(N))

    # Get all possible state matrices
    all_states = []
    for perm in permutations:
        perm1 = []
        for j in range(len(perm)):
            perm1.append(int(perm[j]))
        state = benes(perm1)  # 直接使用传入的benes函数
        all_states.append(state)

    num_stages = len(all_states[0])  # 从state matrix获取阶段数

    # Generate Verilog code
    verilog = f"""module benes_4(
    input [{width - 1}:0] in0"""

    for i in range(1, n):
        verilog += f",\n    input [{width - 1}:0] in{i}"

    for i in range(state.shape[0]):
        for j in range(state.shape[1]):
            verilog += f",\n    output reg state_{i}_{j}"

    verilog += "\n);\n\n"

    verilog += "always @(*) begin\n"
    verilog += "    case({" + ", ".join([f"in{i}" for i in range(n)]) + "})\n"

    # Add cases for each permutation
    for idx, perm in enumerate(permutations):
        case_val = []
        for i in range(n):
            case_val.append(f"{width}'d{perm[i]}")
        case_str = ", ".join(case_val)
        verilog += f"        {{{case_str}}}: begin\n"

        state = all_states[idx]
        for i in range(state.shape[0]):
            for j in range(state.shape[1]):
                verilog += f"            state_{i}_{j} = 1'b{state[i][j]};\n"
        verilog += "        end\n"

    verilog += "        default: begin\n"
    for i in range(state.shape[0]):
        for j in range(state.shape[1]):
            verilog += f"            state_{i}_{j} = 1'b0;\n"
    verilog += "        end\n"

    verilog += "    endcase\n"
    verilog += "end\n\nendmodule"

    return verilog

if __name__ == "__main__":
    # Read permutations from file
    from permutation import generate_permutations

    with open('permutation_4.txt', 'r') as f:
        lines = f.readlines()
        permutations = []
        for line in lines[0:]:
            perm = [int(x) for x in line.strip().split()]
            permutations.append(perm)

    # Generate and write Verilog code


    verilog_code = generate_verilog(permutations, benes)
    with open(f'benes_4.v', 'w') as f:
        f.write(verilog_code)
