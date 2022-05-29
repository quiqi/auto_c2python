#auto_c2python 使用说明：



### 1. 运行环境：

1. python3
2. ubuntu20
3. gcc (Ubuntu 9.4.0)



### 2.使用流程：

1. 将 .h 文件和 .c 文件放在source文件夹，请确保头文件中声明过您需要的全部函数；

2. 使用 chmod 给 c2p.sh 赋予运行权限：

   ```shell
   chmod u+x ./c2p.sh
   ```

3. 运行 ./c2p.sh

   ```shell
   ./c2p.sh
   ```

4. 完成后您可以在output文件夹中看到 interface.py、log.txt、put.so 文件：

   1. **interface.py：**自动生成的python接口，其中包含一个接口类(Interface)，在第五步您可以看到它的使用方式。
   2. **log.txt：**日志文件，您可以在这个文件中看到程序运行的日志，它的第二行写明了这次在每个头文件中找到函数的个数；然后是生成的interface.c的代码（该代码在soucre文件夹中）；然后是interface.py的代码。
   3. **put.so：** 文件，该文件是soucre中所有c代码生成的so库文件，供interface.py 调用。

5. 测试interface.py文件：

   ```shell
   $ cd output		# 进入output文件夹
   $ python3		# 运行python3
   ```

   在python3中：

   ```python
   >>> from interface import Interface		# 引入interface.py
   >>> a = Interface('./put.so')			# 实例化Interface类
   >>> a.sin(1)	# 如果您.h文件中有声明sin函数，并在c代码中实现，您可以通过a.sin调用之
   ```



### 3. 备注：

1. auto_c2python会自动寻找soucre目录中的.h文件，但请保证所有 .h 文件和 .c 文件都在soucre中，且不能在子文件夹中。

2. 如果 .h 文件夹中存在两个同名的函数，比如：

   ```c
   int fun(int x1, double x2);
   int fun(double x1, double x2);
   ```

   第二个函数在 interface.py中将被写为：

   ```python
   def fun_dd(x1,x2):
       return self.so.fun(ctypes.d_double(x1), ctypes.d_double(x2))
   ```

   也就是以参数类型首字母首字母为后缀进行命名，但第一个函数不会修改：

   ```python
   def fun(x1,x2):
       return self.so.fun(ctypes.d_int(x1), ctypes.d_double(x2))
   ```

   