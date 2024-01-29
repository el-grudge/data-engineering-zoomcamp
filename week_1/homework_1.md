
## Question 1. Knowing docker tags

### Answer 

Run the following commands

```
docker build --help | grep "Automatically remove the container when it exits"
docker run --help | grep "Automatically remove the container when it exits"
```

solution: - `--rm`

## Question 2. Understanding docker first run 

### Answer 

Run the following commands

```
docker run -it python:3.9 /bin/bash
pip list | grep wheel
```

solution: - 0.42.0