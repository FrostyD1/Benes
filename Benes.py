import numpy as np
import math

def MN_NB_Generator(mp, size):
    mn = np.zeros(size,dtype=np.int16)
    mt = np.zeros(size,dtype=np.int16)
    nb = np.zeros(size, dtype=np.int16)
    for i in range (size):
        mn[mp[i]] = i
        if i % 2 == 0:
            mt[i] = i + 1
        else:
            mt[i] = i - 1
    for i in range (size):
        nb[i] = mn[mt[mp[i]]]
    return mt, mn, nb

def peripheral_switch(mp, mn, nb, mt):
    size = len(mp)
    cover_table = np.zeros(size, dtype=np.int16)
    min_port = 0
    p_current = int(0)
    ci = np.zeros(size, dtype=np.int16)
    co = np.zeros(size, dtype=np.int16)
    for i in range(int(size/2)):
        ci[p_current] = 1
        ci[mt[p_current]] = 0
        cover_table[p_current] = 1
        cover_table[mt[p_current]] = 1
        flag = 0
        for j in range(size):
            if cover_table[j] == 0:
                if flag == 0:
                    min_port = j
                    flag = 1
                else:
                    pass
            else:
                pass
        if cover_table[nb[mt[p_current]]] == 0:
            p_current = nb[mt[p_current]]
        else:p_current =min_port

    for i in range(size):
        co[mp[i]] = ci[i]
    return ci, co

def Next_stage(mp, ci, co):
    up = np.zeros(len(mp) // 2, dtype=np.int16)
    down = np.zeros(len(mp) // 2, dtype=np.int16)
    for i in range(len(ci)):
        if ci[i] == 1:
            up[int(i//2)] = mp[i] // 2
        else:
            down[int(i//2)] = mp[i] // 2
    return up, down


def benes_layer(mp):
    size = len(mp)
    mt, mn, nb = MN_NB_Generator(mp, size)
    ci, co = peripheral_switch(mp, mn, nb, mt)
    up, down = Next_stage(mp, ci, co)
    return ci, co, up, down

def benes(mp):
    size = len(mp)
    rows = int(size//2)
    cols = int(2 * math.log2(size) - 1)
    state_matrix = np.zeros([rows, cols], dtype=np.int16)
    if size > 2:
        ci, co, up, down = benes_layer(mp)
        for i in range(size // 2):
                state_matrix[i][0] = ci[2*i]    # 1->bar
                state_matrix[i][cols-1] = co[2*i]

        state_matrix[0:int(rows // 2),1:cols - 1] = benes(up)
        state_matrix[int(rows // 2):rows,1:cols - 1] = benes(down)
        return state_matrix
    else:
         return 1-mp[0]

if __name__ == '__main__':

    mp = [0,1,4,5,7,6,3,2]
    '''
    ci, co, up, down = benes(mp)
    np.ones([])

    mt, mn, nb = MN_NB_Generator(mp, 8)
    ci, co = peripheral_switch(mp, mn, nb, mt)
    up, down = Next_stage(mp, ci, co)
    
    print(ci)
    print(ci[0], ci[1], ci[2])
    print(co)
    print(up, down)
    '''
    ci, co, up, down = benes_layer(mp)

    state = benes(mp)
    state_list = state.flatten()
    for i in range(len(state_list)):
        print(state_list[int(len(state_list)-1-i)])