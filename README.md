ZPF-project
===========

框架视频教程地址：http://pan.baidu.com/s/1pJBrdH5   
框架视频教程密码：sudg

一、项目结构：
---------

>AppDelegate---------程序入口<br>
>model---------------数据模型（存放项目所有的数据模型）<br>
>view----------------存放项目所有的view/viewcontroller<br>
>controller----------view和model协调者（非viewcontroller）<br>
>resource------------存放项目资源文件（图片、视频、音频、plist、xml等一切资源文件）<br>
>util----------------存放第三方类库、工具、category等。<br>
>Supporting Files----Xcode生成的必要文件如Info.plist、Prefix.pch<br>
>Frameworks----------项目所引用到的framework<br>


二、开发规范：
------------
1.请在本工程基础上进行开发，严格遵守项目结构，所有的文件归类到各自的文件夹中；<br>
2.命名规范：
<pre>
* 所有命名要有意义，不要用自认为好理解的缩写，宁可名称长一些也没关系，易读性是首位；<br>
* 命名时要带上类型，比如：xxxArray，xxxDictionary，xxxSize；<br>
* 类名首字母大写，如：@interface MyClass: NSObject；<br>
* 函数名第一个字母小写，后面单词首字母大写；如果有参数，第一个参数要从函数名称上携带出来，myFunctionWithXxx；第二个参数的首字母小写；完整示例如：- (void)myFunctionWithSizeA:(CGSize)sizeA sizeB:(CGSize)sizeB{}；<br>
* 变量名第一个字母小写，后面单词首字母大写，如：myVariable；<br>
* 常量名全大写，如：MYCONSTANT；<br>
</pre>
3.ViewController命名规范：
<pre>
* 在view目录下为每个viewcontroller建立单独的实体文件夹
* 每个viewcontroller的命名和原型图编号对应，如：A1_LoginViewController，B1_NewsListViewController
* 每个viewcontroller的子view、cell等放到对应的实体文件夹中
</pre>


