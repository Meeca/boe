1.在终端中cd到该目录

2.执行命令:
./scaffold schema build controller.json

3.将生成的controller.h 和controller.mm复制到该目录

4.这两个文件不支持arc，需要添加：-fno-objc-arc
