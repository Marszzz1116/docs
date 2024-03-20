#! /bin/bash

###################
# 1 将所测试的包列表放到 test文件中（是提测申请单中的update列，全复制）
# 2 打开系统默认配置源. 创建update.repo文件并添加升级源，且状态切换为不可用
# 3 在test文件统计目录执行 nohup bash -x run.sh  >>run.log &
# 4 在/home/packages_log 目录下查看结果
#     install.log  安装默认版本过程日志
#     uninstall_packages 默认源没有安装成功的包
#     install_new.log 用最新的源安装uninstall_packages的包
#     update.log 升级日志
#     update_error.log 升级报错日志，如果没有生成该文件，说明安装升级全部成功,测试通过
#     update_check.log 版本信息检查日志
###################
echo  "1 将所测试的包放到 test文件中"
rm -rf package_list
cat test | tr -s '\n' >> package_list


result_log=/home/packages_log
rm -rf ${result_log:?}
mkdir -p ${result_log}
echo "获取包名 package_name"
rm -rf package_name
while read line
do
        pkgname1=`echo ${line%-*}`
        pkgname=`echo ${pkgname1%-*}`
        echo $pkgname >> package_name
done <  package_list

echo "默认配置安装低版本软件包"
sed -i 's/enabled = 1/enabled = 0/g'  /etc/yum.repos.d/update.repo
yum clean all
### 低版本源 UnionTechOS-Server-20-everything
while read line
do
      yum -y install  ${line} --allowerasing  >>${result_log}/install.log 2>&1
      if [ "$?" != "0" ];then
         echo "${line} install failed in old repo"
         echo ${line} >> ${result_log}/uninstall_packages 2>&1
      fi
done <  package_name

### 配置源
echo "配置高版本源，并升级"
sed -i 's/enabled = 1/enabled = 0/g'  /etc/yum.repos.d/UnionTechOS.repo
sed -i 's/enabled = 0/enabled = 1/g'  /etc/yum.repos.d/update.repo
yum clean all
if [ -f "${result_log}/uninstall_packages" ]; then
  echo "start try install rpm in uninstall_packages"
  while read line
  do
      yum -y install  ${line} --allowerasing  >>${result_log}/install_new.log 2>&1
  done <  ${result_log}/uninstall_packages

fi
yum clean all
#yum update --allowerasing -y >>${result_log}/update.log 2>&1
while read line
do
      yum update --allowerasing -y  ${line} >>${result_log}/update.log 2>&1
      if [ "$?" != "0" ];then
         echo "${line} update failed "
         echo ${line} >> ${result_log}/update_failed_list 2>&1
      fi
done <  package_name



echo "检查版本号是否正确"

while read line
do
        rpm -qa | grep ${line%.*}
        if [ "$?" != "0" ];then
           echo "${line} rpm version check Fail"
           echo "${line} update failed"  >>${result_log}/update_error.log  2>&1
        else
           echo "${line} rpm version check success"
           echo "${line}  check    PASS" >> ${result_log}/update_check.log 2>&1
        fi
done <  package_list
sed -i 's/update failed//g' ${result_log}/update_error.log 
sed -i 's/1://g' ${result_log}/update_error.log  
sed -i 's/2://g' ${result_log}/update_error.log 
sed -i 's/9://g' ${result_log}/update_error.log 
while read line
do
        rpm -qa | grep ${line%.*}
        if [ "$?" != "0" ];then
           echo "${line} rpm version check Fail"
           echo "${line} update failed"  >>${result_log}/update1_error.log  2>&1
        else
           echo "${line} rpm version check success"
           echo "${line}  check    PASS" >> ${result_log}/update_check.log 2>&1
        fi
done <  ${result_log}/update_error.log 



if [ -f "${result_log}/update_error.log" ]; then
  echo "**************Test  Fail**************"
  exit 1
else
  echo "##################Test  PASS##################"
  exit 0
fi
