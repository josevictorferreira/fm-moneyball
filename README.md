# Football Manager Moneyball

A simple Football Manager 2024 moneyball tool to help you find players using coefficients for the best attributes.

## Usage

First run the help script to see the available CLI options:

```bash
./bin/moneyball -h
```

### Use Cases

- Find the best position for your squad players:
```bash
./bin/moneyball -f SAOPAULO_SQUAD_U20.rtf -d name,age,position,best_rating,best_rating_value,second_best_rating,second_best_rating_value -s desc -l 500 -o best_rating_value -c _meta
```
The `-f` option specifies the input file, which can be a `.rtf` file from Football Manager 2024. The `-d` option specifies the data to display, and the `-s` option sorts the output. The `-l` option limits the number of results, and the `-o` option specifies the order of sorting. The `-c` option allows you to add a filter for which coefficients to use, in this case it will look only the FM `meta` coefficients.
