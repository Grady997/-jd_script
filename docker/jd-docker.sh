#!binbash
set -e
JD_PATH=
SHELL_FOLDER=$(pwd)
CONTAINER_NAME=

log() {
    echo -e e[32m$1 e[0mn
}

warn() {
    echo -e e[31m$1 e[0mn
}

cancelrun() {
    if [ $# -gt 0 ]; then
        echo -e 033[31m $1 033[0m
    fi
    exit 1
}

docker_install() {
    echo 检查Docker......
    if [ -x $(command -v docker) ]; then
       echo 检查到Docker已安装!
    else
       if [ -r etcos-release ]; then
            lsb_dist=$(. etcos-release && echo $ID)
        fi
        if [ $lsb_dist == openwrt ]; then
            echo openwrt 环境请自行安装docker
            #exit 1
        else
            echo 安装docker环境...
            curl -fsSL httpsget.docker.com  bash -s docker --mirror Aliyun
            echo 安装docker环境...安装完成!
            systemctl restart docker
        fi
    fi
}

docker_install

echo -n -e e[33m请输入配置文件保存的绝对路径,直接回车为当前目录e[0m
read jd_path
JD_PATH=$jd_path
if [ -z $jd_path ]; then
    JD_PATH=$SHELL_FOLDER
fi

config_path=$JD_PATHjd_dockerconfig
log_path=$JD_PATHjd_dockerlog
log 本脚本将会添加作者（老竭力）的助力码，感谢你的支持！
log 1.开始创建配置文件目录
mkdir -p $config_path
mkdir -p $log_path

log 2.开始下载配置文件
wget -q --no-check-certificate httpsgitee.comevinejd-baserawv3sampleconfig.sh.sample -O $config_pathconfig.sh
if [ $ -ne 0 ]; then
    cancelrun 下载配置文件出错请重试
fi

#添加脚本作者助力码
sed -i 'sForOtherFruit1=ForOtherFruit1=3bea619de1814b5688e5504af8c58591@c6d6d910e53040a483e7301f518c03c5@e974332dbff343cf864f6e56c2a5224a@782d9d59e02146b181506fe146af0aabg' $config_pathconfig.sh
sed -i 'sForOtherBean1=ForOtherBean1=ckvke3ri7sj4c7u3xbhnnuirk4@a355so2hppyl3on7tb3pjq4ose5ac3f4ijdgqji@qpb2rslaqgfqrqgpyys4ntjufi@kywswt3zvukcfhf7x3zekcigsmg' $config_pathconfig.sh
sed -i 'sForOtherJdFactory1=ForOtherJdFactory1=T0085KgxAldCCjVWnYaS5kRrbA@T0165awtF0VIqwO4c1K9CjVWnYaS5kRrbA@T0124qggGEtb9FXXCjVWnYaS5kRrbA@T0105q8yGkJTrQCjVWnYaS5kRrbAg' $config_pathconfig.sh
sed -i 'sForOtherJdzz1=ForOtherJdzz1=S5KgxAldC@S5awtF0VIqwO4c1K9@S4qggGEtb9FXX@S5q8yGkJTrQg' $config_pathconfig.sh
sed -i 'sForOtherJoy1=ForOtherJoy1=mGjQUKjeeEI=@9ZEh-gFiuyjFpr0m0MiK7w==@iGRAEiEd8T1nJA1ZYLpP-w==@QPNaobA6Be4=g' $config_pathconfig.sh

wget -q --no-check-certificate httpsgitee.comevinejd-baserawv3sampledocker.list.sample -O $config_pathcrontab.list
if [ $ -ne 0 ]; then
    cancelrun 下载配置文件出错请重试
fi

echo -n -e 配置文件config.sh已经下载到$config_path目录下，你可以手动去修改config.sh中的配置，也可以在这里输入第一个cookien[Cookie的具体形式（只有pt_key字段和pt_pin字段，没有其他字段）：pt_key=xxxxxxxxxx;pt_pin=xxxx;]ne[33mCookie1-e[0m
read cookie

if [ -z $cookie ]; then
    warn 您没有输入cookie,请手动去$config_pathconfig.sh中修改
else
    sed -i 'sCookie1=Cookie1='$cookie'g' $config_pathconfig.sh
fi

echo -n -e 请输入server酱的PUSH_KEYn[ServerChan，教程：httpsc.ftqq.com3.version]ne[33mPUSH_KEY-e[0m
read pushKey

if [ -z $pushKey ]; then
    warn 您没有输入PUSH_KEY,所以不会接收推送消息，如有需要可以手动去$config_pathconfig.sh中修改。n也可以使用其他推送如：BARKTelegram钉钉iGot聚合推送酷推Push Plus等，config.sh中有详细说明
else
    sed -i 'sexport PUSH_KEY=export PUSH_KEY='$pushKey'g' $config_pathconfig.sh
fi

echo -n -e e[33m请输入要创建的 docker container 的名称[默认为：jd-script]-e[0m
read container_name
if [ -z $container_name ]; then
    CONTAINER_NAME=jd-script
else
    CONTAINER_NAME=$container_name
fi

log 3.开始创建容器并执行
docker run -dit 
    -v $config_pathjdconfig 
    -v $log_pathjdlog 
    -p 56785678 
    --name $CONTAINER_NAME 
    --hostname jd 
    --restart always 
    --network host 
    evinedengjdgitee

log 4.是否安装containrrrwatchtower自动更新Docker容器：n1) 安装[默认]n2) 不安装
echo -n -e e[33m输入您的选择-e[0m
read watchtower
if [ -z $watchtower ]  [ $watchtower == 1 ]; then
    docker run -d 
    --name watchtower 
    -v varrundocker.sockvarrundocker.sock 
    containrrrwatchtower
fi

log 5.docker容器已经运行,下面列出所有在运行的容器

docker ps


log 6.接下来你可以选择：n1) 退出[默认]n2) 立刻执行京豆变动检测脚本进行测试
echo -n -e e[33m输入您的选择-e[0m
read action
if [ $action == 2 ]; then
    docker exec $CONTAINER_NAME bash jd  bean_change now
else
    log 即将退出脚本！
    exit 1
fi