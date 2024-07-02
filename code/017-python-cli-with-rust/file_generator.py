from pathlib import Path
from random import randint


def main():
    for i in range(10_000):
        if i % 100 == 0:
            print(i)

        h_path = Path(f'./data/headers/headers_{i}.csv')
        i_path = Path(f'./data/index/index_{i}.csv')

        with h_path.open('w') as h_file, i_path.open('w') as i_file:
            h_file.write('col_1,col_2\n')
            i_file.write('')

        for j in range(1000):
            with h_path.open('a') as h_file, i_path.open('a') as i_file:
                h_file.write(f'{randint(0, 100)},{randint(0, 100)}\n')
                i_file.write(f'{randint(0, 100)},{randint(0, 100)}\n')


if __name__ == '__main__':
    main()
