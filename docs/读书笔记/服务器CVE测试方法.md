---
Author: chenyi
---

# 服务器CVE测试方案


## CVE进行下载地址

1060u1A:
https://cdimage.uniontech.com/server-dev/1060u1/a/release/amd64/
1060u1E:
https://cdimage.uniontech.com/server-dev/1060u1/e/release/amd64/
1050A:
https://cdimage.uniontech.com/iso-v20/
1050E:
https://cdimage.uniontech.com/iso-v20/
1002A:
https://cdimage.uniontech.com/iso-v20/
1050D:
arm&amd
http://10.0.32.57/server/1050u1/d/release/ISO/
loongarch
https://iso.uniontech.com/#/productdetails/F5rRRsdxJ4TdoV7X9NacOEF

![](/服务器CVE测试方法_assets/产品说明.jpg)

## 安装方式
高危&&常规：图形化默认安装，选择商业授权
补丁CVE：图形化全选安装，选择商业授权
![](/服务器CVE测试方法_assets/安装.jpg)
内核CVE：需要根据实际需要选择4.19和5.10安装；
![](/服务器CVE测试方法_assets/内核选择.jpg)

## 高危&&常规
### 提测周期
高危：每周一和周三晚提测
常规：每周二晚提测

### 提测仓库
常规：
提测仓库E：http://10.7.60.100/server/1050_update/e/cve_regular.repo
A：https://cdimage.uniontech.com/server-dev/1050_update/a/cve_regular.repo
C：https://cdimage.uniontech.com/server-dev/1050_update/c/cve_regular.repo

高危：
E：http://10.7.60.100/server/1050_update/e/cve_risk.repo
A：https://cdimage.uniontech.com/server-dev/1050_update/a/cve_risk.repo
C: https://cdimage.uniontech.com/server-dev/1050_update/c/cve_risk.repo

### 测试策略
1.添加提测仓库（自带仓库不用屏蔽）
2.下载邮件中的提测申请单（邮件中的附件）
3.安装提测申请单中的提测包并核对版本，仓库中的所有包都需要安装（ACED版二进制包名列，核对二进制包名列是否与仓库一致，如果不一致找开发沟通  AC版张兴荣  D版王佳  E版孔立栋）
4.包安装完成后，进行重启，重启以后对包的基本功能进行测试（部分包的功能是需要自己调研的，如果是库包，实在找不到测试方法，可接受测试安装即可）
5.建立测试单，可以查看以前cve的测试单（格式：安全更新a版提测（高危）_2024-1-5_arm_2024/1/10）
6.输出测试报告，按照之前抄送给你的邮件格式即可

### 高危外网推送
测试周期：每周一高危外网推送
测试方法：
1.外网推送方法（先推到update仓库，update仓库是商业授权仓库，所以测试外网推送的时候需要打开商业授权仓库）
2.在各架构机器上安装查看版本即可，项目经理会提供外网推送列表

## 内核CVE测试
### 测试方法
1.下载内核提测包，安装内核提测包（rpm -Uvh *.rpm 进行安装，或者使用yum install*.rpm  如果之前安装过同版本 可以使用 rpm -Uvh *.rpm --force）
2.安装内核包后，重启系统，查看内核版本，内核版本正确可开始运行ltp和内核基本功能测试用例

### 测试注意事项
1.ltp版本问题  1060用2023-1月份的版本  1070用最新版本
2.生态机器链接：https://udoc.uniontech.com/apps/editor/677888?gbcotea=4c11c48eeb983bb22fec6963e8b038a9
3.测试单建立方式
统信服务器操作系统V20（1060）A版本 CVE-20230904_2023/09/04_ AMD
4.D版使用2016的测试套
5.机器挂了使用串口运行，C版和A版容易出问题尽量使用就近的机器
6.使用生态的机器,需要用到跳板机，跳板机ip: 10.20.48.157 
7.鲲鹏机器跑ltp的时候，在ltp-service-for-kunpeng套件里面的skip-list需要放在与ltp-service文件中的ExecStart路径一致，ltp-service文件中的ExecStart默认路径为/home,可以把skip-list默认放在/home目录下
8.每日需要跟踪ltp的是否正常运行

### 内核基本功能自动化运行方式
1.访问自动化工程：https://jenkinswh.uniontech.com/jenkinsb/view/%E6%B5%8B%E8%AF%95/job/autotest/job/update/
工程为A_AMD_CVE——KERNEL A_ARM_CVE——KERNEL  A_LONNGARCH_CVE——KERNEL
2.工程构建任务填写
VERSION_TIME 默认为20230606-1951不用修改
20230725-kernel 根据实际情况填写 （例如：20230817-5.10kernel，根据转测申请单的实际情况填写，一定要加上5.10和4.19)
cve_version不用修改
3.创建好的qcow2路径
http://10.7.60.181/test_qcow2
![](/服务器CVE测试方法_assets/内核功能自动化操作手册.wps)

### 内核CVE外网推送
1.打开update源，安装内核包，装完后重启系统，查看内核版本，参考测试用例：https://pms.uniontech.com/testcase-view-1240931-6.html

## 例行补丁
### 提测周期
![](/服务器CVE测试方法_assets/2024年1月补丁任务日历.docx)

### 提测仓库
E：https://cdimage.uniontech.com/server-dev/1050_update/e/1060e-UTSA-xxxx/
A： http://10.30.38.115/packages.chinauos.com/server-enterprise-c-test/kongzi/1060/
C： http://10.30.38.115/packages.chinauos.com/server-enterprise-c-test/kongli/1000/update/ 

### 测试策略
1.添加提测仓库，添加完成后，执行yum makecache可以看见新增的仓库
2.提测申请单中，任意找一个包查看是否有对应的高版本，存在对应的高版本则表示仓库配置成功
3.下载转测申请单中的附件，下载附件脚本，新建test文件，把转测申请单中的update列，复制到test文件，然后运行脚本
![](/服务器CVE测试方法_assets/run-update.sh)
4.运行完成后，查看/home/packages_log/update-error.log日志，分析升级失败的软件包，可以接受当前安装版本比提测版本高
5.待所有安装失败的软件包核对完成后，进行系统升级，执行yum update，执行完成后，执行重启操作

### updateinfo测试
1.下载转测申请单附件中的cve更新列表，和高危cve更新列表，需要准备全新的环境
2.安装步骤1两个cve更新列表中低版本的包，所有的二进制包，安装完成后做个快照
![](/服务器CVE测试方法_assets/二进制包.jpg)
3.A版：需要屏蔽自带的仓库源，E版：不需要屏蔽自带的仓库， C版：需要屏蔽自带的update仓库，然后根据updateinfo的测试用例测试
4.如果外网update仓库和提测仓库中版本一样，并且没有其他低版本，则不进行update的测试

### 自动化运行注意事项
1.准备qcow2的环境，qcow2的环境密码必须为uostest12#$（建议创建虚拟机的时候直接设置此密码，创建虚拟机时候全选安装）
2.上传qcow2的时候，查看是否传完
3.修改qcow2的权限
chmod -R 644 uniontechos-server-20-1050a_update-amd64-gui-legacy-release-UTSA-2023-0818.qcow2(根据实际情况修改)
4.修改qcow2的名称
a版的qcow2命名为
uniontechos-server-20-1050a_update-amd64-gui-legacy-release-UTSA-2023-0818.qcow2
uniontechos-server-20-1050a_update-arm64-gui-release-UTSA-2023-0818.qcow2
uniontechos-server-20-1050a_update-loongarch64-gui-release-UTSA-2023-0928.qcow2
e版的qcow2命名为
uniontechos-server-20-1050e_update-amd64-gui-legacy-release-UTSA-2023-0818.qcow2
uniontechos-server-20-1050e_update-arm64-gui-release-UTSA-2023-0818.qcow2
5.保证机器的/home目录有足够的空间，以及剩余内存足够多，大于150G
6.如果创建虚拟机出现进入了紧急模式的情况，可以强制重启虚拟机，如果还解决不了，可以参照
https://wikidev.uniontech.com/UTSA%E8%A1%A5%E4%B8%81%E8%87%AA%E5%8A%A8%E5%8C%96%E6%B5%8B%E8%AF%95%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%A4%B1%E8%B4%A5%E5%A4%84%E7%90%86%E6%96%B9%E6%B3%95

### 自动化构建
1.先根据构建自动化https://wikidev.uniontech.com/%E8%A1%A5%E4%B8%81%E8%87%AA%E5%8A%A8%E5%8C%96%E6%8B%89%E8%B5%B7%E6%B5%81%E7%A8%8B
2.访问研测平台：http://adtmp.uniontech.com/#/ProductVersion
3.选择基线管理-->产品版本-->构建-->新增
![](/服务器CVE测试方法_assets/新增版本.jpg)
4.任务管理-->版本测试-->新建
![](/服务器CVE测试方法_assets/新建版本测试.jpg)
5.版本测试内容填入
![](/服务器CVE测试方法_assets/版本测试内容.jpg)
6.运行自动化
![](/服务器CVE测试方法_assets/自动化运行.jpg)
7.查看自动化运行日志
![](/服务器CVE测试方法_assets/查看自动化运行日志.jpg)

